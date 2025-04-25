import 'package:flutter/cupertino.dart';
import '../data/mock_data.dart';
import 'vendor.dart';
import 'service_package.dart';
import 'driver.dart';

enum BookingStatus {
  confirmed(
    'Confirmed',
    CupertinoColors.systemBlue,
    'Your booking has been confirmed',
  ),
  inProgress(
    'In Progress',
    CupertinoColors.systemGreen,
    'Service is currently in progress',
  ),
  completed(
    'Completed',
    CupertinoColors.systemGrey,
    'Service has been completed',
  ),
  cancelled(
    'Cancelled',
    CupertinoColors.systemRed,
    'Booking has been cancelled',
  );

  final String label;
  final Color color;
  final String description;

  const BookingStatus(this.label, this.color, this.description);
}

enum PaymentStatus {
  paid('Paid', CupertinoColors.systemGreen),
  pending('Pending', CupertinoColors.systemOrange);

  final String label;
  final Color color;

  const PaymentStatus(this.label, this.color);
}

class Booking {
  final String id;
  final Vendor vendor;
  final ServicePackage servicePackage;
  final DateTime dateTime;
  final BookingStatus status;
  final bool isPickupEnabled;
  final String? pickupAddress;
  final double totalPrice;
  final PaymentStatus paymentStatus;
  final Driver? driver;
  final String? vendorImageUrl;

  const Booking({
    required this.id,
    required this.vendor,
    required this.servicePackage,
    required this.dateTime,
    required this.status,
    required this.isPickupEnabled,
    this.pickupAddress,
    required this.totalPrice,
    this.paymentStatus = PaymentStatus.pending,
    this.driver,
    this.vendorImageUrl,
  });
}

// Mock data
final mockBookings = [
  Booking(
    id: '1',
    vendor: mockVendors[0],
    servicePackage: mockServicePackages[1],
    dateTime: DateTime.now().subtract(const Duration(days: 2)),
    status: BookingStatus.completed,
    isPickupEnabled: true,
    pickupAddress: 'Kisasa, Dodoma',
    totalPrice: 12000,
    paymentStatus: PaymentStatus.paid,
    driver: mockDrivers[0],
    vendorImageUrl: mockVendors[0].imageUrl,
  ),
  Booking(
    id: '2',
    vendor: mockVendors[1],
    servicePackage: mockServicePackages[0],
    dateTime: DateTime.now().subtract(const Duration(days: 5)),
    status: BookingStatus.completed,
    isPickupEnabled: false,
    totalPrice: 20000,
    paymentStatus: PaymentStatus.paid,
    vendorImageUrl: mockVendors[1].imageUrl,
  ),
  Booking(
    id: '3',
    vendor: mockVendors[1],
    servicePackage: mockServicePackages[0],
    dateTime: DateTime.now().subtract(const Duration(days: 5)),
    status: BookingStatus.confirmed,
    isPickupEnabled: false,
    totalPrice: 20000,
    paymentStatus: PaymentStatus.paid,
    vendorImageUrl: mockVendors[1].imageUrl,
  ),

  Booking(
    id: '4',
    vendor: mockVendors[0],
    servicePackage: mockServicePackages[0],
    dateTime: DateTime.now().subtract(const Duration(days: 5)),
    status: BookingStatus.inProgress,
    isPickupEnabled: false,
    totalPrice: 20000,
    paymentStatus: PaymentStatus.paid,
    vendorImageUrl: mockVendors[0].imageUrl,
  ),

  Booking(
    id: '5',
    vendor: mockVendors[1],
    servicePackage: mockServicePackages[0],
    dateTime: DateTime.now().subtract(const Duration(days: 5)),
    status: BookingStatus.confirmed,
    isPickupEnabled: false,
    totalPrice: 20000,
    paymentStatus: PaymentStatus.paid,
    vendorImageUrl: mockVendors[1].imageUrl,
  ),
  Booking(
    id: '6',
    vendor: mockVendors[2],
    servicePackage: mockServicePackages[2],
    dateTime: DateTime.now().subtract(const Duration(days: 15)),
    status: BookingStatus.completed,
    isPickupEnabled: true,
    pickupAddress: 'Makole, Dodoma',
    totalPrice: 25000,
    paymentStatus: PaymentStatus.paid,
    driver: mockDrivers[1],
    vendorImageUrl: mockVendors[2].imageUrl,
  ),
];
