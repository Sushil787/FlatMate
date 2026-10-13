# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

Flatmates: a Flutter app plus a Serverpod 3.4/4.x backend for sharing recurring chores between people in a flat, with a shared calendar, notice board and grocery list. The setup steps (Google sign-in, FCM, deploy) and the rules for how rotation works are in `README.md`.

## Domain language

`GLOSSARY.md` is the source of truth for domain terms: Flat, Mate, Admin, Invite, Chore, Rotation, Rotation period, Turn, Done/Missed, Away, Away rule (Swap/Skip/Pause), Event, Notice, Grocery item. Use these exact words in code, UI text and conversation, and avoid the synonyms the glossary lists under "Avoid". Before you call domain behaviour a bug, check it against the glossary definition.

## Layout

This is a Dart pub workspace (root `pubspec.yaml`) with four packages:
- `flatmates_server/`: the Serverpod server. Models live in `lib/src/models/*.spy.yaml` and endpoints in `lib/src/endpoints/`.
- `flatmates_shared/`: pure Dart used by both server and app: the Rotation planner (`lib/src/planner.dart`) and shared models (`AwayRule`). It's a Serverpod `shared_packages` entry, so its `.spy.yaml` files are generated into `lib/src/generated/` by `serverpod generate`.
- `flatmates_client/`: **generated** by `serverpod generate`. Never edit it by hand.
- `flatmates_flutter/`: the app (Riverpod 3, hand-written providers with no codegen, and auto_route).

## Commands

```sh
# server
cd flatmates_server
docker compose up -d                     # Postgres: dev on 8090, tests on 9090
dart bin/main.dart --apply-migrations    # API on :8080
serverpod generate                       # after changing a .spy.yaml or an endpoint signature
serverpod create-migration               # after a model/table change; commit the migrations/ dir
dart test                                # all tests (integration tests need the docker Postgres)
dart test -x integration                 # unit tests only
dart test test/unit/day_test.dart        # a single file; add --name '<pattern>' for a single test

# app
cd flatmates_flutter
dart run build_runner build -d           # regenerates router.gr.dart (auto_route) after adding or changing a @RoutePage
flutter test                             # widget tests; they run against FakeBackend, no server needed
flutter run                              # server URL comes from assets/config.json or --dart-define=SERVER_URL
./run_device.sh                          # physical device; points the app at this machine's LAN IP
```

## Architecture

**Server access pattern.** Every endpoint starts with `requireMate(session)` or `requireAdmin(session)` from `lib/src/flat_access.dart`. That call resolves the caller's active Mate and Flat, and all queries are then scoped to `flat.id`. User-facing errors go through `fail('...')`, which throws `FlatmatesException`, and the app shows that message as-is. After a mutation, the endpoint calls `broadcast(session, flatId, FlatChangeKind.x)`.

**Live updates.** `broadcast` posts to the Serverpod message channel `flat-<id>`. `FlatEndpoint.changes()` streams that channel to the app. In the app, `flatChangesProvider` (`features/flat/application/flat_changes.dart`) reconnects on its own and emits `flat` after a reconnect. `flatSyncProvider` (`features/home/application/flat_sync.dart`) maps each `FlatChangeKind` to the providers it should refresh or invalidate. If you add a new kind of data, you need a new `FlatChangeKind` value and a case in `flatSync`.

**Rotation.** `flatmates_shared/lib/src/planner.dart` holds the pure planning logic (`cd flatmates_shared && dart test` unit-tests it). `turn_service.dart` handles persistence and schedules the turn start, the 3-hour reminder and the turn end as FutureCalls (`future_calls/turn_calls.dart`), so they survive restarts. `SwapDebt` records who owes whom under the Swap rule. Notifications go through `notify/notifier.dart`, which logs them instead of sending when no `fcmServiceAccount` is configured.

**App feature layout.** Each feature lives in `lib/features/<feature>/` and is split into these folders:
- `data/`: a repository that wraps the generated client endpoint.
- `application/`: hand-written Riverpod (Async)Notifier controllers that own the data, with optimistic updates that roll back on error. Each user action that can take a while (Save Chore, Mark Done, …) has its own `ActionNotifier` (`core/providers/action_notifier.dart`) in `<feature>_actions.dart`: its button watches `.isLoading` for the spinner, and a second tap while it runs does nothing.
- `domain/`: view models.
- `presentation/`: screens and widgets.

Shared code lives in `lib/core/` (theme tokens, widgets, `action_runner`). The client provider is `core/providers/client_provider.dart`. Widget tests use `test/support/fakes.dart`, which builds a `FakeBackend` by overriding the repository providers.

**Auth.** Sign-in is Google only, through `serverpod_auth_idp`. `currentUserId(session)` is the single place that reads the auth user.

## Gotchas

- All instants are stored in UTC (`DateTime.now().toUtc()`) and shown in the phone's local time. The Flat's timezone is stored but not used yet.
- Mates are soft-deleted. A Mate is active only while `leftAt == null`, so always filter on that (see `activeMates`).
- Integration tests use `withServerpod` with `AuthenticationOverride` UUIDs to act as different Mates (see `test/integration/flat_flow_test.dart`).
- The project ships Serverpod skills in `.claude/skills/`. Use them for model, migration, endpoint and testing work.
