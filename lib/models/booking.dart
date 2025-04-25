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
  });
}

// Mock data
final mockBookings = [
  Booking(
    id: '1',
    vendor: mockVendors[0],
    servicePackage: mockServicePackages[1],
    dateTime: DateTime.now().add(const Duration(hours: 2)),
    status: BookingStatus.confirmed,
    isPickupEnabled: true,
    pickupAddress: '123 Main St',
    totalPrice: 49.99,
    paymentStatus: PaymentStatus.paid,
    driver: mockDrivers[0],
  ),
  Booking(
    id: '2',
    vendor: mockVendors[1],
    servicePackage: mockServicePackages[0],
    dateTime: DateTime.now().add(const Duration(days: 1)),
    status: BookingStatus.confirmed,
    isPickupEnabled: false,
    totalPrice: 29.99,
    paymentStatus: PaymentStatus.pending,
  ),
  Booking(
    id: '3',
    vendor: mockVendors[2],
    servicePackage: mockServicePackages[2],
    dateTime: DateTime.now().subtract(const Duration(minutes: 30)),
    status: BookingStatus.inProgress,
    isPickupEnabled: true,
    pickupAddress: '456 Oak Ave',
    totalPrice: 79.99,
    paymentStatus: PaymentStatus.paid,
    driver: mockDrivers[1],
  ),
];
