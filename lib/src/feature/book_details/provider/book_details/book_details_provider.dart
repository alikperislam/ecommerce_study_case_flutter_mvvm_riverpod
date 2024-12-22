import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../../../core/init/cache/hive_operations.dart';
import '../../../../core/widgets/custom_snackbar.dart';
part 'book_details_state.dart';

class BookDetailsNotifier extends Notifier<BookDetailsState> {
  //? Dependencies
  final CustomSnackbar snackbar;
  final InternetConnectionChecker connection;
  final CacheOperations cache;
  BookDetailsNotifier({
    required this.snackbar,
    required this.connection,
    required this.cache,
  });

  @override
  BookDetailsState build() {
    return const BookDetailsState();
  }
}

