// Flatmates design tokens ("Ink and lime").
// Requires: google_fonts. See DESIGN.md for usage rules.
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Colours that change between light and dark mode.
@immutable
class FlatmatesColors extends ThemeExtension<FlatmatesColors> {
  const FlatmatesColors({
    required this.ground,
    required this.surface,
    required this.ink,
    required this.inkSoft,
    required this.line,
    required this.fillQuiet,
    required this.primary,
    required this.onPrimary,
    required this.primaryTint,
    required this.onPrimaryTint,
    required this.link,
    required this.heroCard,
    required this.onHeroCard,
    required this.heroButton,
    required this.onHeroButton,
    required this.doneBg,
    required this.doneFg,
    required this.missedBg,
    required this.missedFg,
    required this.awayBg,
    required this.awayFg,
    required this.dangerBg,
    required this.dangerFg,
    required this.switchOff,
  });

  final Color ground, surface, ink, inkSoft, line, fillQuiet;
  final Color primary, onPrimary, primaryTint, onPrimaryTint, link;

  /// The "Your Turn today" card on Home and the Mark Done button on it.
  final Color heroCard, onHeroCard, heroButton, onHeroButton;

  final Color doneBg, doneFg, missedBg, missedFg, awayBg, awayFg;
  final Color dangerBg, dangerFg, switchOff;

  static const light = FlatmatesColors(
    ground: Color(0xFFF3F3EE),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF16181A),
    inkSoft: Color(0xFF55584F),
    line: Color(0xFFDEDED6),
    fillQuiet: Color(0xFFEAEAE3),
    primary: Color(0xFFC8F169),
    onPrimary: Color(0xFF16181A),
    primaryTint: Color(0xFFE9F7C6),
    onPrimaryTint: Color(0xFF16181A),
    link: Color(0xFF3F5A00),
    heroCard: Color(0xFF16181A),
    onHeroCard: Color(0xFFFFFFFF),
    heroButton: Color(0xFFC8F169),
    onHeroButton: Color(0xFF16181A),
    doneBg: Color(0xFFDDF2E6),
    doneFg: Color(0xFF17594A),
    missedBg: Color(0xFFECE7F1),
    missedFg: Color(0xFF5E4B73),
    awayBg: Color(0xFFE3ECF5),
    awayFg: Color(0xFF2F5275),
    dangerBg: Color(0xFFFDE9DD),
    dangerFg: Color(0xFF9A3412),
    switchOff: Color(0xFFC9C9C0),
  );

  static const dark = FlatmatesColors(
    ground: Color(0xFF121312),
    surface: Color(0xFF1E201E),
    ink: Color(0xFFF3F3EE),
    inkSoft: Color(0xFFA9ACA2),
    line: Color(0xFF3A3D38),
    fillQuiet: Color(0xFF2A2D29),
    primary: Color(0xFFC8F169),
    onPrimary: Color(0xFF16181A),
    primaryTint: Color(0xFF323A1C),
    onPrimaryTint: Color(0xFFE0F7A8),
    link: Color(0xFFC8F169),
    heroCard: Color(0xFFC8F169),
    onHeroCard: Color(0xFF16181A),
    heroButton: Color(0xFF16181A),
    onHeroButton: Color(0xFFFFFFFF),
    doneBg: Color(0xFF1E4636),
    doneFg: Color(0xFF9FE3C2),
    missedBg: Color(0xFF3A3148),
    missedFg: Color(0xFFCDBFE0),
    awayBg: Color(0xFF24384D),
    awayFg: Color(0xFFB5CFEA),
    dangerBg: Color(0xFF4A2414),
    dangerFg: Color(0xFFFFC9AE),
    switchOff: Color(0xFF4A4D47),
  );

  @override
  FlatmatesColors copyWith() => this;

  @override
  FlatmatesColors lerp(ThemeExtension<FlatmatesColors>? other, double t) =>
      t < 0.5 || other is! FlatmatesColors ? this : other;
}

/// Mate avatar colours. Same in light and dark.
enum MateColor {
  tomato(Color(0xFFC8431F), Colors.white),
  sky(Color(0xFF2670AD), Colors.white),
  plum(Color(0xFF8E4EA8), Colors.white),
  leaf(Color(0xFF1F7A52), Colors.white),
  marigold(Color(0xFFE0A100), Color(0xFF16181A)),
  berry(Color(0xFFB8356B), Colors.white);

  const MateColor(this.fill, this.onFill);
  final Color fill;
  final Color onFill;
}

abstract final class Space {
  static const double xs = 4, sm = 8, md = 12, lg = 16, xl = 24, xxl = 32, top = 56;
  static const double screenMargin = 16;
}

abstract final class Radii {
  static const double chip = 12, input = 16, card = 20, hero = 28, sheet = 28, nav = 36;
}

abstract final class Sizes {
  static const double touchMin = 48;
  static const double buttonPrimary = 56, buttonHero = 60, buttonSecondary = 48;
  static const double input = 56;
  static const double avatarSm = 24, avatarMd = 36, avatarLg = 48;
  static const double navTab = 48;
}

abstract final class Motion {
  static const Duration standard = Duration(milliseconds: 200);
  static const Curve curve = Curves.easeOut;
}

abstract final class FlatmatesTheme {
  static ThemeData light() => _build(Brightness.light, FlatmatesColors.light);
  static ThemeData dark() => _build(Brightness.dark, FlatmatesColors.dark);

  static ThemeData _build(Brightness brightness, FlatmatesColors c) {
    TextStyle head(double size, double height) => GoogleFonts.bricolageGrotesque(
        fontSize: size, height: height / size, fontWeight: FontWeight.w700, color: c.ink);
    TextStyle body(double size, double height, FontWeight w, [Color? color]) =>
        GoogleFonts.dmSans(fontSize: size, height: height / size, fontWeight: w, color: color ?? c.ink);

    final text = TextTheme(
      displaySmall: head(32, 34), // display: Chore name on the Turn card
      headlineMedium: head(30, 33), // screen title
      headlineSmall: head(24, 28), // sheet title
      titleMedium: head(17, 22), // section heading
      bodyLarge: body(16, 22, FontWeight.w500), // inputs, Notice text
      bodyMedium: body(15, 21, FontWeight.w500), // body
      titleSmall: body(15, 21, FontWeight.w600), // row title
      bodySmall: body(13, 18, FontWeight.w400, c.inkSoft), // meta
      labelLarge: body(17, 22, FontWeight.w700), // button
      labelMedium: body(12, 16, FontWeight.w700), // chip
      labelSmall: body(11, 14, FontWeight.w600, c.inkSoft),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: c.ground,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: c.primary,
        onPrimary: c.onPrimary,
        secondary: c.ink,
        onSecondary: c.ground,
        surface: c.surface,
        onSurface: c.ink,
        error: c.dangerFg,
        onError: Colors.white,
        outline: c.line,
      ),
      textTheme: text,
      dividerTheme: DividerThemeData(color: c.line, thickness: 1, space: 1),
      cardTheme: CardThemeData(
        color: c.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radii.card)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: c.primary,
          foregroundColor: c.onPrimary,
          disabledBackgroundColor: c.fillQuiet,
          disabledForegroundColor: c.inkSoft,
          minimumSize: const Size.fromHeight(Sizes.buttonPrimary),
          shape: const StadiumBorder(),
          textStyle: text.labelLarge,
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: c.ink,
          side: BorderSide(color: c.ink, width: 2),
          minimumSize: const Size.fromHeight(Sizes.buttonSecondary),
          shape: const StadiumBorder(),
          textStyle: text.labelLarge?.copyWith(fontSize: 16),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: c.link,
          minimumSize: const Size(Sizes.touchMin, Sizes.touchMin),
          textStyle: text.labelLarge?.copyWith(fontSize: 16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: c.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintStyle: text.bodyLarge?.copyWith(color: c.inkSoft),
        labelStyle: text.bodySmall?.copyWith(fontWeight: FontWeight.w600),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Radii.input),
          borderSide: BorderSide(color: c.line, width: 2),
        ),
        // Design also shows a 3px lime outer ring on focus; add it in the input widget.
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Radii.input),
          borderSide: BorderSide(color: c.ink, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Radii.input),
          borderSide: BorderSide(color: c.dangerFg, width: 2),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: c.surface,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(Radii.sheet)),
        ),
      ),
      extensions: [c],
    );
  }
}

extension FlatmatesThemeX on BuildContext {
  FlatmatesColors get fm => Theme.of(this).extension<FlatmatesColors>()!;
}
