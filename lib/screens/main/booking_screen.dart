import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../models/vendor.dart';
import '../../models/service_package.dart';
import '../../models/time_slot.dart';
import '../../models/payment_method.dart';
import '../../widgets/service_package_card.dart';
import '../../widgets/time_slot_picker.dart';
import '../../widgets/payment_method_selector.dart';

class BookingScreen extends StatefulWidget {
  final Vendor vendor;

  const BookingScreen({
    super.key,
    required this.vendor,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  ServicePackage? _selectedPackage;
  TimeSlot? _selectedTimeSlot;
  bool _isPickupEnabled = false;
  final _addressController = TextEditingController(text: '123 Main St');
  PaymentMethod _selectedPaymentMethod = PaymentMethod.card;

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  void _showSuccessDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Booking Confirmed'),
        content: const Text(
          'Your booking has been confirmed! You will receive a confirmation email shortly.',
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () {
              Navigator.pop(context);
              context.go('/shell/bookings');
            },
          ),
        ],
      ),
    );
  }

  void _showLocationConfirmation() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Location Confirmed'),
        content: Text(
          'Your pickup location has been confirmed:\n${_addressController.text}',
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Book Service'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Vendor Details
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: CupertinoColors.systemGrey5,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: CupertinoColors.systemGrey5,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              CupertinoIcons.car_detailed,
                              size: 30,
                              color:
                                  CupertinoColors.systemGrey.withOpacity(0.3),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.vendor.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(
                                      CupertinoIcons.star_fill,
                                      size: 16,
                                      color: CupertinoColors.systemYellow,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      widget.vendor.rating.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      ' (${widget.vendor.reviewCount})',
                                      style: const TextStyle(
                                        color: CupertinoColors.systemGrey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Service Packages
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Select Package',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ...mockServicePackages.map(
                            (package) => ServicePackageCard(
                              package: package,
                              isSelected: _selectedPackage == package,
                              onSelect: () =>
                                  setState(() => _selectedPackage = package),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Time Slots
                    if (_selectedPackage != null) ...[
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Select Time',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TimeSlotPicker(
                        timeSlots: generateMockTimeSlots(),
                        selectedSlot: _selectedTimeSlot,
                        onSelect: (slot) =>
                            setState(() => _selectedTimeSlot = slot),
                      ),
                      const SizedBox(height: 24),
                    ],

                    // Pickup & Delivery
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Pickup & Delivery',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          CupertinoSwitch(
                            value: _isPickupEnabled,
                            onChanged: (value) =>
                                setState(() => _isPickupEnabled = value),
                          ),
                        ],
                      ),
                    ),

                    // Address Input
                    if (_isPickupEnabled) ...[
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              height: 150,
                              decoration: BoxDecoration(
                                color: CupertinoColors.systemGrey6,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                child: Text('Map View'),
                              ),
                            ),
                            const SizedBox(height: 16),
                            CupertinoTextField(
                              controller: _addressController,
                              placeholder: 'Enter your address',
                              prefix: const Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Icon(CupertinoIcons.location),
                              ),
                            ),
                            const SizedBox(height: 16),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: _showLocationConfirmation,
                              child: const Text('Confirm Location'),
                            ),
                          ],
                        ),
                      ),
                    ],

                    // Payment Method
                    if (_selectedTimeSlot != null) ...[
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Payment Method',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: PaymentMethodSelector(
                          selectedMethod: _selectedPaymentMethod,
                          onSelect: (method) =>
                              setState(() => _selectedPaymentMethod = method),
                        ),
                      ),
                    ],
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            // Bottom Bar
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: CupertinoColors.systemGrey5,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Total Price',
                        style: TextStyle(
                          color: CupertinoColors.systemGrey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$${_selectedPackage?.price.toStringAsFixed(2) ?? '0.00'}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 200,
                    child: CupertinoButton.filled(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 0,
                      ),
                      onPressed: _selectedPackage != null &&
                              _selectedTimeSlot != null
                          ? _showSuccessDialog
                          : null,
                      child: const Text('Confirm Booking'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
