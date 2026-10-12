// Flatmates design tokens ("Ink and lime"), from design/lib/theme/app_theme.dart.
// See design/DESIGN.md for the rules.
import 'package:flutter/material.dart';

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

/// Mate avatar fill and initial colours, indexed by the server's
/// `MateColor` (tomato, sky, plum, leaf, marigold, berry). Same in light
/// and dark.
const mateColors = [
  (name: 'Tomato', fill: Color(0xFFC8431F), onFill: Colors.white),
  (name: 'Sky', fill: Color(0xFF2670AD), onFill: Colors.white),
  (name: 'Plum', fill: Color(0xFF8E4EA8), onFill: Colors.white),
  (name: 'Leaf', fill: Color(0xFF1F7A52), onFill: Colors.white),
  (name: 'Marigold', fill: Color(0xFFE0A100), onFill: Color(0xFF16181A)),
  (name: 'Berry', fill: Color(0xFFB8356B), onFill: Colors.white),
];

abstract final class Space {
  static const double xs = 4, sm = 8, md = 12, lg = 16, xl = 24, xxl = 32;
  static const double screenMargin = 16;

  /// Room left under scrolling content for the floating bottom nav.
  static const double navClearance = 120;
}

abstract final class Radii {
  static const double chip = 12, input = 16, card = 20, hero = 28, sheet = 28;
  static const double nav = 36;
}

abstract final class Sizes {
  static const double touchMin = 48;
  static const double buttonPrimary = 56, buttonHero = 60;
  static const double buttonSecondary = 48;
  static const double avatarSm = 24, avatarMd = 36, avatarLg = 48;
}

abstract final class Timing {
  static const Duration standard = Duration(milliseconds: 200);
  static const Duration delayed = Duration(milliseconds: 300);
  static const Curve curve = Curves.easeOut;
}

abstract final class FlatmatesTheme {
  /// Bundled in assets/fonts (SIL Open Font License).
  static const headFont = 'BricolageGrotesque';
  static const bodyFont = 'DMSans';

  static ThemeData light() => _build(Brightness.light, FlatmatesColors.light);
  static ThemeData dark() => _build(Brightness.dark, FlatmatesColors.dark);

  static ThemeData _build(Brightness brightness, FlatmatesColors c) {
    TextStyle head(double size, double height) => TextStyle(
      fontFamily: headFont,
      fontSize: size,
      height: height / size,
      fontWeight: FontWeight.w700,
      color: c.ink,
    );
    TextStyle body(double size, double height, FontWeight w, [Color? color]) =>
        TextStyle(
          fontFamily: bodyFont,
          fontSize: size,
          height: height / size,
          fontWeight: w,
          color: color ?? c.ink,
        );

    final text = TextTheme(
      displaySmall: head(32, 34), // display: Chore name on the Turn card
      headlineMedium: head(30, 33), // screen title
      headlineSmall: head(24, 28), // sheet title
      titleLarge: head(20, 24), // card title
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
      fontFamily: bodyFont,
      scaffoldBackgroundColor: c.ground,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: c.primary,
        onPrimary: c.onPrimary,
        secondary: c.ink,
        onSecondary: c.ground,
        surface: c.surface,
        onSurface: c.ink,
        onSurfaceVariant: c.inkSoft,
        error: c.dangerFg,
        onError: Colors.white,
        outline: c.line,
        outlineVariant: c.line,
      ),
      textTheme: text,
      iconTheme: IconThemeData(color: c.ink, size: 22),
      dividerTheme: DividerThemeData(color: c.line, thickness: 1, space: 1),
      cardTheme: CardThemeData(
        color: c.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.card),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: c.primary,
          foregroundColor: c.onPrimary,
          disabledBackgroundColor: c.fillQuiet,
          disabledForegroundColor: c.inkSoft,
          minimumSize: const Size.fromHeight(Sizes.buttonPrimary),
          padding: const EdgeInsets.symmetric(horizontal: Space.xl),
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
          padding: const EdgeInsets.symmetric(horizontal: Space.lg),
          shape: const StadiumBorder(),
          textStyle: text.labelLarge?.copyWith(fontSize: 16),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: c.ink,
          minimumSize: const Size(Sizes.touchMin, Sizes.touchMin),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: c.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        hintStyle: text.bodyLarge?.copyWith(color: c.inkSoft),
        labelStyle: text.bodySmall?.copyWith(fontWeight: FontWeight.w600),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        errorStyle: text.bodySmall?.copyWith(
          color: c.dangerFg,
          fontWeight: FontWeight.w600,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Radii.input),
          borderSide: BorderSide(color: c.line, width: 2),
        ),
        // The 3px lime outer ring on focus is drawn by AppField.
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Radii.input),
          borderSide: BorderSide(color: c.ink, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Radii.input),
          borderSide: BorderSide(color: c.dangerFg, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Radii.input),
          borderSide: BorderSide(color: c.dangerFg, width: 2),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: c.ink,
        selectionColor: c.primaryTint,
        selectionHandleColor: c.ink,
      ),
      switchTheme: SwitchThemeData(
        trackColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? c.ink : c.switchOff,
        ),
        thumbColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? c.primary : Colors.white,
        ),
        trackOutlineColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? c.ink : c.switchOff,
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: c.ink),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: c.surface,
        modalBackgroundColor: c.surface,
        elevation: 0,
        showDragHandle: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(Radii.sheet),
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: c.ink,
        contentTextStyle: text.bodyMedium?.copyWith(color: c.ground),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: c.surface,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: text.headlineSmall,
        contentTextStyle: text.bodyMedium?.copyWith(color: c.inkSoft),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.hero),
        ),
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: c.surface,
        surfaceTintColor: Colors.transparent,
        headerBackgroundColor: c.ink,
        headerForegroundColor: c.ground,
        todayBorder: BorderSide(color: c.ink),
        dayBackgroundColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? c.primary : null,
        ),
        dayForegroundColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? c.onPrimary : c.ink,
        ),
        rangeSelectionBackgroundColor: c.primaryTint,
      ),
      extensions: [c],
    );
  }
}

extension FlatmatesThemeX on BuildContext {
  FlatmatesColors get fm => Theme.of(this).extension<FlatmatesColors>()!;
  TextTheme get text => Theme.of(this).textTheme;
}
