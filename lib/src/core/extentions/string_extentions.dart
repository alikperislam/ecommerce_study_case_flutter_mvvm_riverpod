import 'package:easy_localization/easy_localization.dart';

//? localization
extension StringLocalization on String {
  String get locale => this.tr();
}

//? dollar symbol
extension PriceWithDollar on String {
  String get dollar => '$this \$';
}
