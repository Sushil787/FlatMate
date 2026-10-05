import 'package:flutter/material.dart';

/// Colours of the fridge-door look: the kitchen, the fridge and the
/// magnets on it.
@immutable
class FridgeColors extends ThemeExtension<FridgeColors> {
  const FridgeColors({
    required this.door,
    required this.doorHighlight,
    required this.doorShade,
    required this.cabinet,
    required this.plinth,
    required this.handle,
    required this.wall,
    required this.tile,
    required this.floor,
    required this.plank,
    required this.glow,
    required this.chores,
    required this.calendar,
    required this.notices,
    required this.groceries,
    required this.flat,
  });

  /// The brushed-steel doors.
  final Color door;
  final Color doorHighlight;
  final Color doorShade;

  /// The fridge's body, seen in the gaps around the doors.
  final Color cabinet;

  /// The vent grille at the bottom and the feet.
  final Color plinth;
  final Color handle;

  /// The kitchen behind the fridge.
  final Color wall;
  final Color tile;
  final Color floor;
  final Color plank;

  /// Light from the bulb, when it's on.
  final Color glow;

  /// One magnet colour per section.
  final Color chores;
  final Color calendar;
  final Color notices;
  final Color groceries;
  final Color flat;

  static const light = FridgeColors(
    door: Color(0xFFE3E9EC),
    doorHighlight: Color(0xFFFAFCFD),
    doorShade: Color(0xFFC9D2D6),
    cabinet: Color(0xFFB4BEC2),
    plinth: Color(0xFF3A4245),
    handle: Color(0xFF9AA6AB),
    wall: Color(0xFFF2EDE4),
    tile: Color(0xFFE3DBCE),
    floor: Color(0xFFC9A57A),
    plank: Color(0xFFAF8B60),
    glow: Color(0xFFFFC861),
    chores: Color(0xFF0F766E),
    calendar: Color(0xFF6D28D9),
    notices: Color(0xFFBE185D),
    groceries: Color(0xFFC2410C),
    flat: Color(0xFF0369A1),
  );

  static const dark = FridgeColors(
    door: Color(0xFF2B3437),
    doorHighlight: Color(0xFF3C474B),
    doorShade: Color(0xFF1E2528),
    cabinet: Color(0xFF111618),
    plinth: Color(0xFF0A0D0E),
    handle: Color(0xFF56636A),
    wall: Color(0xFF1C2022),
    tile: Color(0xFF252B2D),
    floor: Color(0xFF2E251C),
    plank: Color(0xFF231C15),
    glow: Color(0xFFFFC861),
    chores: Color(0xFF0F766E),
    calendar: Color(0xFF6D28D9),
    notices: Color(0xFFBE185D),
    groceries: Color(0xFFC2410C),
    flat: Color(0xFF0369A1),
  );

  @override
  FridgeColors copyWith() => this;

  @override
  FridgeColors lerp(FridgeColors? other, double t) =>
      t < 0.5 ? this : (other ?? this);
}

extension FridgeColorsX on BuildContext {
  FridgeColors get fridge => Theme.of(this).extension<FridgeColors>()!;
}
