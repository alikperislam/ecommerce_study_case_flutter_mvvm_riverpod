//? textfields
enum TextfieldType { name, email, password }

//? splash button type - login or skip
enum SplashButtonType { loginButton, skipButton }

//? catalog button choose
enum CatalogButtons {
  all(-1),
  bestSeller(0),
  classic(1),
  children(2),
  philosophy(3);

  const CatalogButtons(
    this.buttonIndex,
  );
  final int buttonIndex;
}
