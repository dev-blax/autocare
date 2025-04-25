import 'service_type.dart';

class ServicePackage {
  final String id;
  final String name;
  final String description;
  final double price;
  final int durationMinutes;
  final List<String> features;
  final ServiceType serviceType;

  const ServicePackage({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.durationMinutes,
    required this.features,
    required this.serviceType,
  });
}

final mockServicePackages = [
  ServicePackage(
    id: 'basic-wash',
    name: 'Basic Wash',
    description: 'Essential exterior wash service',
    price: 22000,
    durationMinutes: 30,
    features: [
      'Exterior wash',
      'Wheel cleaning',
      'Basic dry',
      'Windows cleaning',
    ],
    serviceType: ServiceType.carWash,
  ),
  ServicePackage(
    id: 'premium-wash',
    name: 'Premium Wash',
    description: 'Complete interior & exterior service',
    price: 25000,
    durationMinutes: 60,
    features: [
      'Everything in Basic Wash',
      'Interior vacuum',
      'Dashboard cleaning',
      'Tire dressing',
      'Air freshener',
    ],
    serviceType: ServiceType.carWash,
  ),
  ServicePackage(
    id: 'deluxe-wash',
    name: 'Deluxe Wash',
    description: 'Ultimate car care experience',
    price: 27000,
    durationMinutes: 90,
    features: [
      'Everything in Premium Wash',
      'Waxing',
      'Engine bay cleaning',
      'Paint protection',
    ],
    serviceType: ServiceType.carWash,
  ),
];
