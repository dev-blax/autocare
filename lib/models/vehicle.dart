class Vehicle {
  final String id;
  final String make;
  final String model;
  final int year;
  final String? licensePlate;

  const Vehicle({
    required this.id,
    required this.make,
    required this.model,
    required this.year,
    this.licensePlate,
  });
}

// Mock vehicles
final mockVehicles = [
  Vehicle(
    id: '1',
    make: 'Toyota',
    model: 'Camry',
    year: 2020,
    licensePlate: 'ABC 123',
  ),
  Vehicle(
    id: '2',
    make: 'Honda',
    model: 'CR-V',
    year: 2019,
    licensePlate: 'XYZ 789',
  ),
];
