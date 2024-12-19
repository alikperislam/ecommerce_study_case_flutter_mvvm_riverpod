//? path constants
const kLangAssetPath = "assets/l10n";
//? regex constants
final nameRegex = RegExp(r'^[\p{L}]+(\s[\p{L}]+)*$', unicode: true);
final passwordRegex = RegExp(r'^[\p{L}0-9]{6,20}$', unicode: true);
