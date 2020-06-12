extension StringExtension on String {
  String get onlyDigits => this.replaceAll(RegExp(r"[^0-9]+"), '');
}