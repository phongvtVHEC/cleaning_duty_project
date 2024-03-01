import 'dart:ui';

abstract class AppColor {
  const AppColor();

  //Font Colors
  static const Color colorFontBlack = Color(0xFF737C96);

  //Toast Colors
  static const Color colorToastError = Color(0xFFE74C3C);
  static const Color colorToastSuccess = Color(0xFF4BB543);

  //Basic Colors
  static const Color colorBlack = Color(0xFF111111);
  static const Color colorWhite = Color(0xFFFFFFFF);

  //TextField Colors
  static const Color colorTextFieldDisable = Color(0xffEEEEEE);
  static const Color colorTextFieldBorder = Color(0xFFEBF2FD);
  static const Color colorTextFieldLabel = Color(0xFF337EEE);

  //Button Colors
  static const Color colorButtonPrimary = Color(0xFF337EEE);
  static const Color colorButtonDisable = Color(0xFFCCCCCC);
}
