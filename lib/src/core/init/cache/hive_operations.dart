import '../../constants/app_constants.dart';
import 'hive_model.dart';

class CacheOperations {
  //? get user account infos.
  Future<UserHiveDb?> getUsetDb() async {
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
}
