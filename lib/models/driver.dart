class Driver {
  final String id;
  final String name;
  final String phone;
  final String photoUrl;
  final double rating;
  final int completedTrips;

  const Driver({
    required this.id,
    required this.name,
    required this.phone,
    required this.photoUrl,
    required this.rating,
    required this.completedTrips,
  });
}

final mockDrivers = [
  Driver(
    id: 'd1',
    name: 'John Smith',
    phone: '+1 (555) 123-4567',
    photoUrl: 'assets/driver1.jpg',
    rating: 4.8,
    completedTrips: 342,
  ),
  Driver(
    id: 'd2',
    name: 'Sarah Johnson',
    phone: '+1 (555) 987-6543',
    photoUrl: 'assets/driver2.jpg',
    rating: 4.9,
    completedTrips: 567,
  ),
];
