import 'package:easy_localization/easy_localization.dart';
import '../constants/enums.dart';
import '../init/localization/locale_keys.g.dart';

//? localization
extension StringLocalization on String {
  String get locale => this.tr();
}

//? dollar symbol
extension PriceWithDollar on String {
  String get dollar => '$this \$';
}

//? CatalogButtons extension for localization
extension CatalogButtonsExtension on CatalogButtons {
  String get name {
    final localizedValue = _localizedName();
    return localizedValue.trim().toLowerCase();
  }

  String _localizedName() {
    switch (this) {
      case CatalogButtons.all:
        return LocaleKeys.catalogAll.locale;
      case CatalogButtons.bestSeller:
        return LocaleKeys.catalogBestSeller.locale;
      case CatalogButtons.classic:
        return LocaleKeys.catalogClassic.locale;
      case CatalogButtons.children:
        return LocaleKeys.catalogChildren.locale;
      case CatalogButtons.philosophy:
        return LocaleKeys.catalogPhilosophy.locale;
    }
  }
}
