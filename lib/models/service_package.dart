class ServicePackage {
  final String id;
  final String name;
  final String description;
  final double price;
  final int durationMinutes;
  final List<String> features;

  const ServicePackage({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.durationMinutes,
    required this.features,
  });
}

final mockServicePackages = [
  ServicePackage(
    id: 'basic-wash',
    name: 'Basic Wash',
    description: 'Essential exterior wash service',
    price: 29.99,
    durationMinutes: 30,
    features: [
      'Exterior wash',
      'Wheel cleaning',
      'Basic dry',
      'Windows cleaning',
    ],
  ),
  ServicePackage(
    id: 'premium-wash',
    name: 'Premium Wash',
    description: 'Complete interior & exterior service',
    price: 49.99,
    durationMinutes: 60,
    features: [
      'Everything in Basic Wash',
      'Interior vacuum',
      'Dashboard cleaning',
      'Tire dressing',
      'Air freshener',
    ],
  ),
  ServicePackage(
    id: 'deluxe-wash',
    name: 'Deluxe Wash',
    description: 'Ultimate car care experience',
    price: 79.99,
    durationMinutes: 90,
    features: [
      'Everything in Premium Wash',
      'Wax application',
      'Leather conditioning',
      'Engine bay cleaning',
      'Paint protection',
    ],
  ),
];
