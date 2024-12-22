import 'package:ecommerce_case_study/src/feature/home/model/catalog/catalog_response_model.dart';
import 'package:hive/hive.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'hive_model.dart';

class CacheOperations {
  final Box dbBox;
  CacheOperations(this.dbBox);
  //? get user account infos.
  Future<UserHiveDb?> getUserDb() async {
    int? index = await _getCurrentAccountIndex();
    if (index != null && index >= 0) {
      UserHiveDb? user = dbBox.getAt(index) as UserHiveDb;
      return user;
    } else {
      return null;
    }
  }

  //? get current account index.
  Future<int?> _getCurrentAccountIndex() async {
    int? currentUserIndex = dbBox.isEmpty
        ? null
        : dbBox.values.toList().indexWhere((i) => i.currentUser);
    return currentUserIndex;
  }

  //? check if the token belongs to the user.
  Future<int> _isTokenUserAccount({required String token}) async {
    if (dbBox.isEmpty) {
      return -1;
    }
    //? new token payload
    final newPayload = JwtDecoder.decode(token);
    //? current user index
    int currentUserIndex = dbBox.values.toList().indexWhere(
      (i) {
        //? existing token payload
        final existingTokenPayload = JwtDecoder.decode(i.user.token);
        //? check the user_id and email values of the existing token with the new token.
        return existingTokenPayload['user_id'] == newPayload['user_id'] &&
            existingTokenPayload['email'] == newPayload['email'];
      },
    );
    //? return the index of the account that matches the token.
    return currentUserIndex;
  }

  //? first user register process
  Future<void> userRegister({required UserHiveDb userDb}) async {
    //? if there is a registered account, make it not current.
    await deactivateAllUsers();
    //? register the new account.
    await dbBox.add(userDb);
  }

  //? user login proccess
  Future<void> userLogin({required UserHiveDb userDb}) async {
    int? userIndex = await _isTokenUserAccount(token: userDb.user.token);
    if (userIndex case == null || == -1) {
      //? if there is a registered account, make it not current.
      await deactivateAllUsers();
      //? logged in but account was not registered. register account.
      await dbBox.add(userDb);
    } else {
      //? if there is a registered account, make it not current.
      await deactivateAllUsers();
      //? the relevant account already exists in cache.
      UserHiveDb? account = dbBox.getAt(userIndex) as UserHiveDb;
      account.currentUser = userDb.currentUser;
      account.user.token = userDb.user.token;
      await dbBox.putAt(userIndex, account);
    }
  }

  //? Deactivate all registered accounts
  Future<void> deactivateAllUsers() async {
    if (dbBox.isNotEmpty) {
      for (int i = 0; i < dbBox.length; i++) {
        UserHiveDb account = dbBox.getAt(i) as UserHiveDb;
        account.currentUser = false;
        await dbBox.putAt(i, account);
      }
    }
  }

  //? Update category data of the user account.
  Future<void> setCategoryData({
    required DateTime createdDate,
    required List<CategoryModel> categories,
  }) async {
    UserHiveDb? account = await getUserDb();
    int? userIndex = await _getCurrentAccountIndex();

    if (userIndex != null && userIndex >= 0) {
      account!.user.categoryField = CategoryField(
        createdDate: createdDate,
        categories: categories
            .map((category) => CategoryModelDb.fromModel(category))
            .toList(),
      );
      await dbBox.putAt(userIndex, account);
    }
  }

  //? Update product like status
  Future<void> setLikeData({
    required int categoryId,
    required int productId,
    required int like,
  }) async {
    UserHiveDb? account = await getUserDb();
    int? userIndex = await _getCurrentAccountIndex();
    if (userIndex != null && userIndex >= 0) {
      account!.user.categoryField!.categories[categoryId].products[productId]
          .likesCount = like;
      await dbBox.putAt(userIndex, account);
    }
  }

  //? Get the list of categories that have been converted.
  Future<List<CategoryModel>> getCategoryData() async {
    UserHiveDb? account = await getUserDb();
    if (account != null && account.user.categoryField != null) {
      return account.user.categoryField!.categories
          .map((categoryDb) => categoryDb.toModel())
          .toList();
    }
    return [];
  }
}
