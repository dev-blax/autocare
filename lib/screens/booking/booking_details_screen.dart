import 'package:flutter/cupertino.dart';
import '../../models/booking.dart';
import 'package:intl/intl.dart';

class BookingDetailsScreen extends StatelessWidget {
  final Booking booking;

  const BookingDetailsScreen({
    super.key,
    required this.booking,
  });

  void _showChatDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Contact Vendor'),
        content: Text(
          'Opening chat with ${booking.vendor.name}...\n\nThis is a mock dialog. In a real app, this would open a chat interface.',
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
    final dateFormat = DateFormat('EEEE, MMMM d, y');
    final timeFormat = DateFormat('h:mm a');

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Booking Details'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.chat_bubble_2),
          onPressed: () => _showChatDialog(context),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Status Banner
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: booking.status.color.withOpacity(0.1),
                ),
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.info_circle_fill,
                      color: booking.status.color,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            booking.status.label,
                            style: TextStyle(
                              color: booking.status.color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            booking.status.description,
                            style: TextStyle(
                              color: booking.status.color,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Vendor Details
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: CupertinoColors.systemGrey6,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            CupertinoIcons.car_detailed,
                            size: 30,
                            color: CupertinoColors.systemGrey.withOpacity(0.3),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                booking.vendor.name,
                                style: const TextStyle(
                                  fontSize: 20,
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
                                    booking.vendor.rating.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    ' (${booking.vendor.reviewCount})',
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
                    const SizedBox(height: 24),

                    // Service Details
                    const Text(
                      'Service Details',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _DetailRow(
                      icon: CupertinoIcons.cube_box,
                      title: 'Package',
                      value: booking.servicePackage.name,
                    ),
                    _DetailRow(
                      icon: CupertinoIcons.calendar,
                      title: 'Date',
                      value: dateFormat.format(booking.dateTime),
                    ),
                    _DetailRow(
                      icon: CupertinoIcons.time,
                      title: 'Time',
                      value: timeFormat.format(booking.dateTime),
                    ),
                    _DetailRow(
                      icon: CupertinoIcons.money_dollar,
                      title: 'Total Price',
                      value: '\$${booking.totalPrice.toStringAsFixed(2)}',
                    ),
                    _DetailRow(
                      icon: CupertinoIcons.creditcard,
                      title: 'Payment Status',
                      value: booking.paymentStatus.label,
                      valueColor: booking.paymentStatus.color,
                    ),

                    if (booking.isPickupEnabled && booking.pickupAddress != null) ...[
                      const SizedBox(height: 24),
                      const Text(
                        'Pickup Details',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _DetailRow(
                        icon: CupertinoIcons.location,
                        title: 'Address',
                        value: booking.pickupAddress!,
                      ),
                    ],

                    if (booking.driver != null) ...[
                      const SizedBox(height: 24),
                      const Text(
                        'Driver Details',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemGrey6,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: CupertinoColors.systemGrey4,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: const Icon(CupertinoIcons.person_fill),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    booking.driver!.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(
                                        CupertinoIcons.star_fill,
                                        size: 14,
                                        color: CupertinoColors.systemYellow,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        booking.driver!.rating.toString(),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        ' • ${booking.driver!.completedTrips} trips',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: CupertinoColors.systemGrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: CupertinoTheme.of(context)
                                      .primaryColor
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      CupertinoIcons.phone_fill,
                                      size: 14,
                                      color:
                                          CupertinoTheme.of(context).primaryColor,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Call',
                                      style: TextStyle(
                                        color: CupertinoTheme.of(context)
                                            .primaryColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 32),
                    if (booking.status == BookingStatus.confirmed ||
                        booking.status == BookingStatus.inProgress)
                      CupertinoButton.filled(
                        child: const Text('Track Booking'),
                        onPressed: () {
                          // TODO: Navigate to tracking screen
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color? valueColor;

  const _DetailRow({
    required this.icon,
    required this.title,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: CupertinoColors.systemGrey,
          ),
          const SizedBox(width: 8),
          Text(
            '$title:',
            style: const TextStyle(
              color: CupertinoColors.systemGrey,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: valueColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
