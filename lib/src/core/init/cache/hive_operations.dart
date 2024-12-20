import 'package:hive/hive.dart';
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

  //? if the token information from the service is available in any account, freeze the index of the existing account.
  Future<int> _isTokenUserAccount({required String token}) async {
    int currentUserIndex = dbBox.isEmpty
        ? -1
        : dbBox.values.toList().indexWhere((i) => i.user.token == token);
    return currentUserIndex;
  }

  //? first user register proccess
  Future<void> userRegister({required UserHiveDb userDb}) async {
    await dbBox.add(userDb);
  }

  //? user login proccess
  Future<void> userLogin({required UserHiveDb userDb}) async {
    int? tokenIndex = await _isTokenUserAccount(token: userDb.user.token);
    if (tokenIndex case == null || == -1) {
      //? logged in but account was not registered. register account.
      await dbBox.add(userDb);
    } else {
      //? the relevant account already exists in cache.
      UserHiveDb? account = dbBox.getAt(tokenIndex) as UserHiveDb;
      account.currentUser = userDb.currentUser;
      await dbBox.putAt(tokenIndex, account);
    }
  }

  //Todo:
  //? speak page sayfasinda ki status durumlarini guncelle.
  Future<void> setTry() async {
    UserHiveDb? userAccount = await getUserDb();
    int? index = await _getCurrentAccountIndex();
    //!userAccount?.user.speakStatus = SpeakStatus(status: model.status!);
    await dbBox.putAt(index!, userAccount);
  }

  //? gunluk serilere ait tum verilerin kullaniciya dondurulmesi islemi.
  Future<bool?> getTry() async {
    UserHiveDb? userAccount = await getUserDb();
    //!Serials? serialDetails = userAccount?.user.serials;
    //!return serialDetails;
    return userAccount?.currentUser;
  }
}


/*
  CacheOperations().userRegister(
      userDb: UserHiveDb(
        currentUser: false,
        user: UserDb(
          token: token
        ),
    ),
  ),

  CacheOperations().userLogin(
      userDb: UserHiveDb(
        currentUser: rememberMe,
        user: UserDb(
          token: token
        ),
    ),
  ),

  Future<void> readNameToCache() async {
    UserHiveDb? data = await CacheOperations().getUserDb();
    userName = data != null ? data.user.name.firstElement : '';
    notifyListeners();
  }
*/