import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';

//? path constants
const kLangAssetPath = "assets/l10n";
//? hive boxes
late Box dbBox;
//? regex constants
final kNameRegex = RegExp(r'^[\p{L}]+(\s[\p{L}]+)*$', unicode: true);
final kPasswordRegex = RegExp(r'^[\p{L}0-9]{6,20}$', unicode: true);
//? endpoints
final kRegisterUrl =
    '${dotenv.env['DOMAIN']}${dotenv.env['REGISTER_ENDPOINT']}';
