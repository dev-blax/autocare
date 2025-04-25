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
    name: 'Enock William',
    phone: '+255 655 533 588',
    photoUrl: 'https://images.pexels.com/photos/31738334/pexels-photo-31738334/free-photo-of-confident-man-standing-in-open-field.jpeg?auto=compress&cs=tinysrgb&w=600',
    rating: 4.8,
    completedTrips: 342,
  ),
  Driver(
    id: 'd2',
    name: 'James Mbogo',
    phone: '+255 653 533580',
    photoUrl: 'https://images.pexels.com/photos/31766866/pexels-photo-31766866/free-photo-of-portrait-of-a-thoughtful-woman-outdoors.jpeg?auto=compress&cs=tinysrgb&w=600',
    rating: 4.9,
    completedTrips: 567,
  ),
];
