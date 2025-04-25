import '../models/vendor.dart';

final mockVendors = [
  Vendor(
    id: '1',
    name: 'Premium Auto Spa',
    serviceTypes: [ServiceType.carWash, ServiceType.detailing],
    rating: 4.8,
    reviewCount: 128,
    distance: 1.2,
    estimatedWaitTime: 15,
    imageUrl: 'assets/vendor1.jpg',
    isRecommended: true,
  ),
  Vendor(
    id: '2',
    name: 'Quick & Clean Car Care',
    serviceTypes: [ServiceType.carWash, ServiceType.oilChange],
    rating: 4.5,
    reviewCount: 89,
    distance: 2.4,
    estimatedWaitTime: 30,
    imageUrl: 'assets/vendor2.jpg',
    isRecommended: true,
  ),
  Vendor(
    id: '3',
    name: 'AutoTech Masters',
    serviceTypes: [
      ServiceType.oilChange,
      ServiceType.tireRotation,
      ServiceType.brakeService
    ],
    rating: 4.9,
    reviewCount: 256,
    distance: 3.1,
    estimatedWaitTime: 45,
    imageUrl: 'assets/vendor3.jpg',
    isRecommended: true,
  ),
  Vendor(
    id: '4',
    name: 'Express Maintenance',
    serviceTypes: [
      ServiceType.oilChange,
      ServiceType.inspection,
      ServiceType.brakeService
    ],
    rating: 4.3,
    reviewCount: 67,
    distance: 1.8,
    estimatedWaitTime: 20,
    imageUrl: 'assets/vendor4.jpg',
    isRecommended: false,
  ),
  Vendor(
    id: '5',
    name: 'Luxury Car Care',
    serviceTypes: [ServiceType.detailing, ServiceType.carWash],
    rating: 4.7,
    reviewCount: 182,
    distance: 4.2,
    estimatedWaitTime: 60,
    imageUrl: 'assets/vendor5.jpg',
    isRecommended: true,
  ),
];
