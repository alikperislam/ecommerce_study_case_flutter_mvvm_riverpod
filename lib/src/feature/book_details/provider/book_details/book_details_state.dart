part of 'book_details_provider.dart';

class BookDetailsState {
  final bool isSubmitting;

  const BookDetailsState({
    this.isSubmitting = false,
  });

  BookDetailsState copyWith({
    bool? isSubmitting,
  }) {
    return BookDetailsState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}
