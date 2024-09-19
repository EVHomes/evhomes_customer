import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
 
class ThemeColors {
  static Color primaryColor = const Color(0xFF42BEA5);
  static Color secondaryColor = const Color(0xFF359F8A);
  static Color tertiaryColor = const Color(0xFFE86969);
  static Color alternate = const Color(0xFF262D34);
  static Color primaryBackground = const Color(0xFFF1F4F8);
  static Color secondaryBackground = const Color(0xFFFFFFFF);
  static Color primaryText = const Color.fromARGB(255, 43, 43, 43);
  static Color secondaryText = const Color(0xFF95A1AC);
  static Color white = const Color(0xFFFFFFFF);
  static Color lineColor = const Color(0xFFDBE2E7);
  static Color darkBG = const Color(0xFF1A1F24);
  static Color primaryBlack = const Color(0xFF131619);

  static var deepPurpleAccent;
}

class ThemeTexts {
  static String get title1Family => typography.title1Family;
  static TextStyle get title1 => typography.title1;
  static String get title2Family => typography.title2Family;
  static TextStyle get title2 => typography.title2;
  static String get title3Family => typography.title3Family;
  static TextStyle get title3 => typography.title3;
  static String get subtitle1Family => typography.subtitle1Family;
  static TextStyle get subtitle1 => typography.subtitle1;
  static String get subtitle2Family => typography.subtitle2Family;
  static TextStyle get subtitle2 => typography.subtitle2;
  static String get bodyText1Family => typography.bodyText1Family;
  static TextStyle get bodyText1 => typography.bodyText1;
  static String get bodyText2Family => typography.bodyText2Family;
  static TextStyle get bodyText2 => typography.bodyText2;

  static Typography get typography => MobileTypography();
}

abstract class Typography {
  String get title1Family;
  TextStyle get title1;
  String get title2Family;
  TextStyle get title2;
  String get title3Family;
  TextStyle get title3;
  String get subtitle1Family;
  TextStyle get subtitle1;
  String get subtitle2Family;
  TextStyle get subtitle2;
  String get bodyText1Family;
  TextStyle get bodyText1;
  String get bodyText2Family;
  TextStyle get bodyText2;

  // New getters
}

class MobileTypography extends Typography {
  @override
  String get title1Family => 'Manrope';
  @override
  TextStyle get title1 => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 24,
      );
  @override
  String get title2Family => 'Manrope';
  @override
  TextStyle get title2 => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      );
  @override
  String get title3Family => 'Manrope';
  @override
  TextStyle get title3 => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 15,
      );
  @override
  String get subtitle1Family => 'Manrope';
  @override
  TextStyle get subtitle1 => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.secondaryText,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      );
  @override
  String get subtitle2Family => 'Manrope';
  @override
  TextStyle get subtitle2 => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
  @override
  String get bodyText1Family => 'Manrope';
  @override
  TextStyle get bodyText1 => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
  @override
  String get bodyText2Family => 'Manrope';
  @override
  TextStyle get bodyText2 => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 12,
      );

  TextStyle get titleSmall => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 16,
      );

  TextStyle get titleMedium => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      );

  TextStyle get headlineMedium => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.primaryText,
        fontWeight: FontWeight.w700,
        fontSize: 24,
      );

  TextStyle get labelLarge => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      );

  TextStyle get labelMedium => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.secondaryText,
        fontWeight: FontWeight.w400,
        fontSize: 12,
      );

  TextStyle get bodyLarge => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 16,
      );

  TextStyle get bodyMedium => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
}

class TabletTypography extends Typography {
  @override
  String get title1Family => 'Manrope';
  @override
  TextStyle get title1 => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 34,
      );
  @override
  String get title2Family => 'Manrope';
  @override
  TextStyle get title2 => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 24,
      );
  @override
  String get title3Family => 'Manrope';
  @override
  TextStyle get title3 => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      );
  @override
  String get subtitle1Family => 'Manrope';
  @override
  TextStyle get subtitle1 => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.white,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      );
  @override
  String get subtitle2Family => 'Manrope';
  @override
  TextStyle get subtitle2 => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
  @override
  String get bodyText1Family => 'Manrope';
  @override
  TextStyle get bodyText1 => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
  @override
  String get bodyText2Family => 'Manrope';
  @override
  TextStyle get bodyText2 => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 12,
      );

  TextStyle get titleSmall => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 16,
      );

  TextStyle get titleMedium => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      );

  TextStyle get headlineMedium => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.primaryText,
        fontWeight: FontWeight.w700,
        fontSize: 24,
      );

  TextStyle get labelLarge => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      );

  TextStyle get labelMedium => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.secondaryText,
        fontWeight: FontWeight.w400,
        fontSize: 12,
      );

  TextStyle get bodyLarge => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 16,
      );

  TextStyle get bodyMedium => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
}

class DesktopTypography extends Typography {
  @override
  String get title1Family => 'Manrope';
  @override
  TextStyle get title1 => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 34,
      );
  @override
  String get title2Family => 'Manrope';
  @override
  TextStyle get title2 => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 24,
      );
  @override
  String get title3Family => 'Manrope';
  @override
  TextStyle get title3 => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      );
  @override
  String get subtitle1Family => 'Manrope';
  @override
  TextStyle get subtitle1 => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.white,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      );
  @override
  String get subtitle2Family => 'Manrope';
  @override
  TextStyle get subtitle2 => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
  @override
  String get bodyText1Family => 'Manrope';
  @override
  TextStyle get bodyText1 => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
  @override
  String get bodyText2Family => 'Manrope';
  @override
  TextStyle get bodyText2 => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 12,
      );

  TextStyle get titleSmall => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 16,
      );

  TextStyle get titleMedium => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      );

  TextStyle get headlineMedium => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.primaryText,
        fontWeight: FontWeight.w700,
        fontSize: 24,
      );

  TextStyle get labelLarge => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      );

  TextStyle get labelMedium => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.secondaryText,
        fontWeight: FontWeight.w400,
        fontSize: 12,
      );

  TextStyle get bodyLarge => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 16,
      );

  TextStyle get bodyMedium => GoogleFonts.getFont(
        'Manrope',
        color: ThemeColors.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
}

// class DarkModeTheme extends FlutterFlowTheme {
//   late Color primaryColor = const Color(0xFF42BEA5);
//   late Color secondaryColor = const Color(0xFF359F8A);
//   late Color tertiaryColor = const Color(0xFFE86969);
//   late Color alternate = const Color(0xFF262D34);
//   late Color primaryBackground = const Color(0xFF1A1F24);
//   late Color secondaryBackground = const Color(0xFF131619);
//   late Color primaryText = const Color(0xFFFFFFFF);
//   late Color secondaryText = const Color(0xFF95A1AC);

//   late Color white = const Color(0xFFFFFFFF);
//   late Color lineColor = const Color(0xFF262D34);
//   late Color darkBG = const Color(0xFF1A1F24);
//   late Color primaryBlack = const Color(0xFF131619);
// }

// extension TextStyleHelper on TextStyle {
//   TextStyle override({
//     String? fontFamily,
//     Color? color,
//     double? fontSize,
//     FontWeight? fontWeight,
//     double? letterSpacing,
//     FontStyle? fontStyle,
//     bool useGoogleFonts = true,
//     TextDecoration? decoration,
//     double? lineHeight,
//   }) =>
//       useGoogleFonts
//           ? GoogleFonts.getFont(
//               fontFamily!,
//               color: color ?? this.color,
//               fontSize: fontSize ?? this.fontSize,
//               letterSpacing: letterSpacing ?? this.letterSpacing,
//               fontWeight: fontWeight ?? this.fontWeight,
//               fontStyle: fontStyle ?? this.fontStyle,
//               decoration: decoration,
//               height: lineHeight,
//             )
//           : copyWith(
//               fontFamily: fontFamily,
//               color: color,
//               fontSize: fontSize,
//               letterSpacing: letterSpacing,
//               fontWeight: fontWeight,
//               fontStyle: fontStyle,
//               decoration: decoration,
//               height: lineHeight,
//             );
// }
