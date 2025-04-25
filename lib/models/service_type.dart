enum ServiceType {
  carWash('Car Wash', 20000),
  oilChange('Oil Change', 25000),
  tireRotation('Tire Rotation', 30000),
  brakeService('Brake Service', 18000),
  inspection('Inspection', 15000),
  detailing('Detailing', 14000);

  final String label;
  final double basePrice;

  const ServiceType(this.label, this.basePrice);
}
