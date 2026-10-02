# Flatmates

Flatmates share out recurring chores fairly, keep one calendar, a notice board and a grocery list.
Flutter app + Serverpod 3.4 backend. Vocabulary lives in [../GLOSSARY.md](../GLOSSARY.md).

## Run locally

```sh
cd flatmates_server
docker compose up -d                       # Postgres for dev (8090) and tests (9090)
dart bin/main.dart --apply-migrations      # API on :8080

cd ../flatmates_flutter
flutter run                                # talks to http://localhost:8080
```

In development the sign-in screen also offers **email sign-in** so you can create several test
mates without Google accounts; verification codes are printed in the server log. Release builds
show Google only, and the server only enables email in development mode.

## Tests

```sh
cd flatmates_server
dart test        # rotation rules (unit) + full flows against Postgres (integration)
```

## Setup you need to do

### Google sign-in
1. Google Cloud console → create OAuth client IDs (a **Web** client for the server, plus iOS/Android clients).
2. Put the Web client's JSON in `flatmates_server/config/passwords.yaml` as `googleClientSecret: '<json>'`
   (under `shared:` or the run mode). Google sign-in is enabled automatically when it's present.
3. Run the app with
   `--dart-define=GOOGLE_CLIENT_ID=<platform client id> --dart-define=GOOGLE_SERVER_CLIENT_ID=<web client id>`.
   iOS also needs the reversed client ID as a URL scheme in `Info.plist`.

### Push notifications (FCM)
1. Create a Firebase project; run `flutterfire configure` in `flatmates_flutter` (adds
   `google-services.json` / `GoogleService-Info.plist`).
2. Firebase console → Service accounts → generate a key; put the JSON in `passwords.yaml` as
   `fcmServiceAccount: '<json>'`.

Until then everything works, and notifications are written to the server log instead.

### Deploy (Serverpod Cloud)
Uses Serverpod Cloud's managed Postgres (SSL is required there and handled by the platform).
Set `googleClientSecret` and `fcmServiceAccount` as Cloud passwords, deploy, then build the app with
`--dart-define=SERVER_URL=https://<your-api-host>/`.

## How rotation works

- Each **Chore** has a **Rotation** (ordered Mates, repeats allowed) and a **Rotation period**.
  A **Turn** is one Mate's responsibility for one period; it ends when the period ends, **Done** or **Missed**.
- Turn start, the 3-hour reminder and the end are Serverpod **FutureCalls** (`TurnCalls`), so they
  survive restarts. Turn end marks Missed if needed and creates the next Turn.
- The Flat-wide **Away rule** (Admin picks): **Swap** (next Mate covers, Away Mate does their next
  Turn in return), **Skip** (next Mate covers, nothing owed), **Pause** (Chore waits; Away days
  mid-Turn extend it). If nobody can cover, the Chore pauses.
- Pure planning logic: `flatmates_server/lib/src/rotation/planner.dart`; DB + scheduling:
  `turn_service.dart`. Live app updates stream over `flat.changes()`.

## Known simplifications
- Instants are stored in UTC and shown in each phone's local time; the Flat's timezone is stored
  but not yet used for display.
- Cancelling an Away keeps covers already arranged for it.
- Changing the Rotation period applies from the next Turn.
