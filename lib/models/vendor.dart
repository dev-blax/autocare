import 'service_type.dart';

class Vendor {
  final String id;
  final String name;
  final List<ServiceType> serviceTypes;
  final double rating;
  final int reviewCount;
  final double distance;
  final int estimatedWaitTime;
  final String imageUrl;
  final bool isRecommended;

  const Vendor({
    required this.id,
    required this.name,
    required this.serviceTypes,
    required this.rating,
    required this.reviewCount,
    required this.distance,
    required this.estimatedWaitTime,
    required this.imageUrl,
    required this.isRecommended,
  });
}

enum SortOption {
  price('Price'),
  rating('Rating'),
  distance('Distance'),
  waitTime('Wait Time');

  final String label;

  const SortOption(this.label);
}
