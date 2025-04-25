import 'package:flutter/cupertino.dart';
import '../../models/booking.dart';
import '../../widgets/booking_card.dart';
import '../booking/booking_details_screen.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  int _selectedSegment = 0;

  List<Booking> get _activeBookings => mockBookings
      .where((booking) =>
          booking.status == BookingStatus.confirmed ||
          booking.status == BookingStatus.inProgress)
      .toList();

  List<Booking> get _upcomingBookings => mockBookings
      .where((booking) =>
          booking.status == BookingStatus.confirmed &&
          booking.dateTime.isAfter(DateTime.now()))
      .toList();

  void _showCancelDialog(Booking booking) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Cancel Booking'),
        content: Text(
          'Are you sure you want to cancel your booking with ${booking.vendor.name}?',
        ),
        actions: [
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
              _showCancellationConfirmed();
            },
            child: const Text('Cancel Booking'),
          ),
          CupertinoDialogAction(
            child: const Text('Keep Booking'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showCancellationConfirmed() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Booking Cancelled'),
        content: const Text(
          'Your booking has been cancelled. A refund will be processed within 3-5 business days.',
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

  void _showBookingDetails(Booking booking) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => BookingDetailsScreen(booking: booking),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Bookings'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: CupertinoSlidingSegmentedControl<int>(
                groupValue: _selectedSegment,
                onValueChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedSegment = value);
                  }
                },
                children: const {
                  0: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text('Active'),
                  ),
                  1: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text('Upcoming'),
                  ),
                },
              ),
            ),
            Expanded(
              child: _selectedSegment == 0
                  ? _activeBookings.isEmpty
                      ? const _EmptyState(
                          message: 'No active bookings',
                        )
                      : ListView.builder(
                          itemCount: _activeBookings.length,
                          itemBuilder: (context, index) {
                            final booking = _activeBookings[index];
                            return BookingCard(
                              booking: booking,
                              onViewDetails: () => _showBookingDetails(booking),
                            );
                          },
                        )
                  : _upcomingBookings.isEmpty
                      ? const _EmptyState(
                          message: 'No upcoming bookings',
                        )
                      : ListView.builder(
                          itemCount: _upcomingBookings.length,
                          itemBuilder: (context, index) {
                            final booking = _upcomingBookings[index];
                            return BookingCard(
                              booking: booking,
                              onViewDetails: () => _showBookingDetails(booking),
                              onCancel: () => _showCancelDialog(booking),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}



class _EmptyState extends StatelessWidget {
  final String message;

  const _EmptyState({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            CupertinoIcons.calendar,
            size: 64,
            color: CupertinoColors.systemGrey,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              color: CupertinoColors.systemGrey,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
