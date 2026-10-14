# Flatmates — design handoff

Flatmates is a Flutter app (iOS and Android) for 2–6 people sharing a flat: fair recurring chores, a shared calendar, a notice board and a grocery list. This folder is the source of truth for the UI.

## What is in this folder

| Path | What it is |
|---|---|
| `screens/*.html` | One static HTML file per screen, 390×844. Every colour, size, radius and spacing value is in the inline `style` attributes. Read these as the spec. |
| `screenshots/*.png` | A render of each screen at 2x. Use them to check your build visually. |
| `lib/theme/app_theme.dart` | The tokens as Dart: colours (light and dark), spacing, radii, text styles, Mate colours, status colours. Start here. |
| `DESIGN.md` | This file. |

## How to build from this (instructions for Claude Code)

1. Copy `lib/theme/app_theme.dart` into the app and wire `FlatmatesTheme.light()` / `.dark()` into `MaterialApp`.
2. Build the shared components first (list below), each as its own widget, matching `screens/Components.html`.
3. Build screens one at a time. For each: open the HTML, read the inline styles, build the widget tree, then compare against the matching PNG.
4. Use the domain terms below exactly as written in all UI copy. Copy the strings from the HTML.
5. Do not invent colours or sizes. If a value is missing from the theme file, take it from the HTML and add it to the theme.

## Domain terms (use exactly)

Flat, Mate, Admin, Invite, Chore, Rotation, Rotation period, Turn (ends as Done or Missed), Away, Away rule (Swap / Skip / Pause), Event, Notice, Grocery item.

- **Swap**: another Mate covers the Turn and is owed one back.
- **Skip**: the Turn passes to the next Mate.
- **Pause**: the Chore waits until the Mate is back.

## Look: "Ink and lime"

Neutral grey-white ground, near-black ink, one loud accent (lime). Flat cards, no shadows except the floating nav and the Add Event button. Warm, friendly, calm.

### Colour tokens

| Token | Light | Dark | Use |
|---|---|---|---|
| ground | `#F3F3EE` | `#121312` | Screen background |
| surface | `#FFFFFF` | `#1E201E` | Cards, sheets, nav |
| ink | `#16181A` | `#F3F3EE` | Text, icons |
| inkSoft | `#55584F` | `#A9ACA2` | Secondary text, inactive icons |
| line | `#DEDED6` | `#3A3D38` | Dividers, input borders |
| fillQuiet | `#EAEAE3` | `#2A2D29` | Neutral chips, quiet buttons |
| primary (lime) | `#C8F169` | `#C8F169` | Primary buttons, active tab, focus ring |
| onPrimary | `#16181A` | `#16181A` | Text on lime. Never white on lime. |
| primaryTint | `#E9F7C6` | `#323A1C` | "Due" chip, live highlight, selected option |
| onPrimaryTint | `#16181A` | `#E0F7A8` | Text on the tint |
| link | `#3F5A00` | `#C8F169` | Text links and text buttons (lime text is unreadable on white) |
| danger | `#9A3412` on `#FDE9DD` | same | Errors, Remove, Leave the Flat |

### Turn status (never a red wall)

| Status | Light bg / text | Dark bg / text | Icon |
|---|---|---|---|
| Due | `#E9F7C6` / `#16181A` | `#323A1C` / `#E0F7A8` | `clock` |
| Done | `#DDF2E6` / `#17594A` | `#1E4636` / `#9FE3C2` | `check` |
| Missed | `#ECE7F1` / `#5E4B73` | `#3A3148` / `#CDBFE0` | `minus` |
| Away | `#E3ECF5` / `#2F5275` | `#24384D` / `#B5CFEA` | `plane` |

Missed has the same visual weight as Done. Copy is blame-free and always says who is next. Status never relies on colour alone: every chip has a word, most have an icon.

### Mate colours (avatar = the colour's face on a coloured circle)

Tomato `#C8431F`, Sky `#2670AD`, Plum `#8E4EA8`, Leaf `#1F7A52`, Marigold `#E0A100`, Berry `#B8356B`. Each colour comes with its own illustrated face (`flatmates_flutter/assets/avatars/<colour>.svg`: "Notionists" by Zoish, CC0, via DiceBear; gender-neutral: no beards, neutral hair), so picking a colour picks the face too. `design/avatars/generate.js` rebuilds them. One colour per Mate in a Flat.

- Away Mate: the Away tint instead of their colour, under a 2px dashed `#2F5275` outline.
- Mate whose Turn it is: 3px lime ring, 2px offset.
- Sizes: 24 inline, 36 in rows, 48 in headers.

### Type

Headings: **Bricolage Grotesque** 700. Everything else: **DM Sans** 400/500/600/700. Both on Google Fonts (`google_fonts` package).

| Style | Size / line height | Font |
|---|---|---|
| display | 32 / 34 | Bricolage 700 |
| title | 24 / 28 (screen titles are 30) | Bricolage 700 |
| heading | 17 / 22 | Bricolage 700 |
| body | 15 / 21 | DM Sans 500 |
| meta | 13 / 18 | DM Sans 400, inkSoft |
| label | 12 / 16 | DM Sans 700 |

Sizes are logical pixels and must follow the OS text scale (up to 200%). Rows use min-height, never fixed height. Chips wrap under the title at large sizes.

### Spacing, shape, motion

- Spacing scale: 4, 8, 12, 16, 24, 32, 56. Screen margin 16. Top inset 56 (leave room for the status bar; use `SafeArea`).
- Radius: 12 chip, 16 input, 20 card, 28 hero card and sheet top, full pill for buttons.
- Touch targets ≥ 48. Primary actions 56–60 high and in the bottom half of the screen (one-handed use).
- Motion: 200 ms ease-out. A change arriving live from another Mate fades in with a brief lime-tint highlight.

## Icons

Lucide, stroke icons. Suggested package: `lucide_icons_flutter` (check the exact Dart identifiers in the package; names below are the Lucide names).

| Use | Lucide name |
|---|---|
| Nav Home / Chores / Calendar / Groceries / Flat | `house`, `refresh-cw`, `calendar`, `shopping-basket`, `users` |
| Done / Missed / Due | `check`, `minus`, `clock` |
| Away | `plane` |
| Add / back / forward / next in Rotation | `plus`, `chevron-left`, `chevron-right`, `arrow-right` |
| Post Notice / Notice board row | `arrow-up`, `sticky-note` |
| Profile / rename Flat | `user`, `pencil` |
| Error / reconnecting spinner | `circle-alert`, `loader-circle` |

The basket drawing on the empty Groceries screen is a custom illustration (inline SVG in `GroceriesEmpty.html`).

## Components (build these first; see `screens/Components.html`)

- **Button**: primary (lime fill, ink text, pill, 56 high), primary-on-ink (same, used on the black Turn card), secondary (2px ink outline, 48 high), text (link colour), danger text, disabled (fillQuiet).
- **Input**: 56 high, radius 16, 2px line border. Focus: 2px ink border plus 3px lime outer ring. Error: 2px danger border plus message below.
- **Card**: surface fill, radius 20, no shadow, 16 padding. **Hero card**: radius 28.
- **List row**: min-height 48–56, avatar or checkbox left, title + meta, chip or chevron right, 1px line divider.
- **Mate avatar**: as above.
- **Turn chip**: radius 12, label style, optional 14px icon.
- **Bottom nav**: floating capsule, inset 16 from the sides and 22 from the bottom, surface fill, 1px line border, radius 36, padding 6, soft shadow. Five tabs. The active tab is a lime pill (48 high, radius 24) showing icon + label side by side and sized to its content; the other four are icon-only and share the remaining width. Inactive icons use inkSoft. Give inactive tabs semantic labels.
- **Sheet**: bottom sheet, radius 28 top corners, 40×4 grabber, title + Cancel, primary action pinned at the bottom. Used for create/edit Chore, Add Event, Mark myself Away.
- **Switch**: 52×32, ink track with lime knob when on; grey track with white knob when off.
- **Banners**: reconnecting (ink bar, white text, spinner), error (danger tint card with Dismiss / Try again).

## Screens

Navigation: bottom nav has Home, Chores, Calendar, Groceries, Flat. Notice board opens from Home (latest Notice card) and from the Flat tab. Profile/settings opens from the avatar on Home and from the Flat tab. Detail screens and sheets have no bottom nav.

| # | File | Notes |
|---|---|---|
| 1 | `SignIn.html` | Google sign-in only. Black screen, lime button. |
| 2 | `Onboarding.html` | Create a Flat (name it; creator becomes Admin) or join with an Invite code. |
| 3 | `Main.html` | **Home, Turn due today.** Black hero card with lime "Mark Done". Then "Up next in the Flat", latest Notice, open Grocery item count. After Mark Done the hero becomes a Done-tint card ("Done · just now", "Bins are out. Nice one.", outlined Undo button). |
| 3 | `HomeDark.html` | Home in dark mode. Hero card flips to solid lime with a black button. |
| 3 | `HomeEmpty.html` | New Flat, no Chores: share Invite, suggested Chores, "Create a Chore". |
| 3 | `Loading.html` | Skeleton state for Home, gently pulsing. |
| 4 | `Chores.html` | Chore list: whose Turn, who is next, Rotation period. Shows Due today, a Swap with an Away Mate ("back in 3 days"), a Missed Turn, and Done today. |
| 4 | `ChoreDetail.html` | Rotation order with Turns done per Mate (fairness), Turn history (Done/Missed), Rotation period, Away rule, Mark Done. |
| 4 | `ChoreEdit.html` | Create/edit sheet: name, Rotation (drag to reorder), Rotation period, Away rule, start date. Admin only. |
| 5 | `Calendar.html` | Month grid with Event dots and Away bars, "Coming up" agenda, Month/Agenda toggle, Add Event button. |
| 5 | `AddEvent.html` | Add Event sheet. |
| 6 | `Notices.html` | Notice feed with "Got it" acknowledgements, pinned Notice, composer docked at the bottom. |
| 7 | `Groceries.html` | Fast list. Quick-entry field docked above the nav. Tap checkbox to tick. Swipe left reveals Remove (third row shows the swiped state). Each row shows who added it. First row shows the live-update highlight. |
| 7 | `GroceriesEmpty.html` | Empty list with quick-add chips. |
| 7 | `Offline.html` | Offline/reconnecting bar, "Waiting to send" rows, and a server error card. |
| 8 | `Flat.html` | Flat name, Mates (Admin chip, Away chip), Invite code with Copy/Share, Mark myself Away, Leave the Flat. |
| 8 | `Away.html` | Date-range sheet. Previews what happens to each of your Turns under its Away rule. |
| 9 | `Settings.html` | Profile, Mate colour, notification toggles, appearance (System/Light/Dark), Sign out. |
| – | `Notifications.html` | Push copy: Turn starts, reminder 3 hours before the Turn ends (actions: Mark Done, Ask for a Swap), Turn Missed, new Notice, added to a Rotation. |
| – | `Foundations.html`, `Components.html` | The design system boards (1200 wide). |

## Behaviour notes

- Everything is real-time: changes from other Mates appear without a refresh. Show the small "live" dot next to the Flat name on Home.
- Offline: keep the UI usable, queue changes locally, mark queued rows "Waiting to send", sync on reconnect.
- Turns are whole days and end at 23:59 local time. A Turn not marked Done by then becomes Missed and the Rotation moves on.
- Only an Admin sees create/edit Chore, rename Flat and remove Mate.
- Only the light Home has a dark-mode screen drawn. For every other screen, apply the dark tokens from the theme file one-to-one.

## Known gaps

- Sample content (Maple Street 12; Maya, Sam, Priya, Jonas; MAPLE-42) is placeholder.
- Not drawn: remove-a-Mate confirmation, Leave the Flat confirmation, Agenda-only calendar view, custom Rotation period picker, date picker, large-text variants.
