enum AppRouteNamed {
  splashPage('/', 'splashPage'),
  loginPage('/login', 'loginPage'),
  registerPage('/register', 'registerPage'),
  homePage('/home', 'homePage'),
  bookDetailsPage('/bookDetails', 'bookDetailsPage'),
  bookCategoriesPage('/bookCategories', 'bookCategoriesPage');

  const AppRouteNamed(
    this.path,
    this.name,
  );

  final String path;
  final String name;
}
