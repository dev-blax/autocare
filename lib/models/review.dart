class Review {
  final String id;
  final String bookingId;
  final double rating;
  final String? comment;
  final DateTime createdAt;

  const Review({
    required this.id,
    required this.bookingId,
    required this.rating,
    this.comment,
    required this.createdAt,
  });
}

// Mock reviews for some of our bookings
final mockReviews = {
  '3': Review(
    id: 'r1',
    bookingId: '3',
    rating: 4.5,
    comment: 'Great service! The car looks brand new.',
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
  ),
};
