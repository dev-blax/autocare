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

enum ServiceType {
  carWash('Car Wash', 29.99),
  oilChange('Oil Change', 49.99),
  tireRotation('Tire Rotation', 39.99),
  brakeService('Brake Service', 89.99),
  inspection('Inspection', 34.99),
  detailing('Detailing', 149.99);

  final String label;
  final double basePrice;

  const ServiceType(this.label, this.basePrice);
}

enum SortOption {
  price('Price'),
  rating('Rating'),
  distance('Distance'),
  waitTime('Wait Time');

  final String label;

  const SortOption(this.label);
}
