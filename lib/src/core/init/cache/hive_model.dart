import 'package:hive/hive.dart';
part 'hive_model.g.dart';

@HiveType(typeId: 0)
class UserHiveDb {
  @HiveField(0)
  bool currentUser;

  @HiveField(1)
  UserDb user;

  UserHiveDb({
    required this.currentUser,
    required this.user,
  });
}

@HiveType(typeId: 1)
class UserDb {
  @HiveField(0)
  String token;

  UserDb({
    required this.token,
  });
}
