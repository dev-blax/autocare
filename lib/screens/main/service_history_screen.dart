import 'package:flutter/cupertino.dart';
import '../../models/booking.dart';
import '../../models/review.dart';
import '../../models/service_package.dart';
import 'package:intl/intl.dart';

import '../../models/vendor.dart';

class ServiceHistoryScreen extends StatefulWidget {
  const ServiceHistoryScreen({super.key});

  @override
  State<ServiceHistoryScreen> createState() => _ServiceHistoryScreenState();
}

class _ServiceHistoryScreenState extends State<ServiceHistoryScreen> {
  ServiceType? _selectedServiceType;
  String _selectedTimeRange = 'All Time';
  final List<String> _timeRanges = ['Last Week', 'Last Month', 'Last 3 Months', 'All Time'];

  List<Booking> get _completedBookings {
    var bookings = mockBookings
        .where((booking) => booking.status == BookingStatus.completed)
        .toList();

    // Apply service type filter
    // if (_selectedServiceType != null) {
    //   bookings = bookings
    //       .where((booking) =>
    //           booking.servicePackage.serviceTypes.contains(_selectedServiceType))
    //       .toList();
    // }

    // Apply time range filter
    final now = DateTime.now();
    switch (_selectedTimeRange) {
      case 'Last Week':
        bookings = bookings
            .where((booking) =>
                booking.dateTime.isAfter(now.subtract(const Duration(days: 7))))
            .toList();
        break;
      case 'Last Month':
        bookings = bookings
            .where((booking) =>
                booking.dateTime.isAfter(now.subtract(const Duration(days: 30))))
            .toList();
        break;
      case 'Last 3 Months':
        bookings = bookings
            .where((booking) =>
                booking.dateTime.isAfter(now.subtract(const Duration(days: 90))))
            .toList();
        break;
    }

    // Sort by date, newest first
    bookings.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    return bookings;
  }

  void _showRatingDialog(Booking booking) {
    double rating = 5;
    final commentController = TextEditingController();

    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: CupertinoColors.systemBackground,
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Rate Your Experience',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'How was your service with ${booking.vendor.name}?',
                style: const TextStyle(color: CupertinoColors.systemGrey),
              ),
              const SizedBox(height: 16),
              StatefulBuilder(
                builder: (context, setState) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return GestureDetector(
                      onTap: () => setState(() => rating = index + 1),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Icon(
                          index < rating
                              ? CupertinoIcons.star_fill
                              : CupertinoIcons.star,
                          color: CupertinoColors.systemYellow,
                          size: 32,
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 16),
              CupertinoTextField(
                controller: commentController,
                placeholder: 'Add a comment (optional)',
                minLines: 3,
                maxLines: 5,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: const Text('Cancel'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Expanded(
                    child: CupertinoButton.filled(
                      padding: EdgeInsets.zero,
                      child: const Text('Submit'),
                      onPressed: () {
                        // Mock review submission
                        Navigator.pop(context);
                        _showReviewSubmittedDialog();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showReviewSubmittedDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Thank You!'),
        content: const Text(
          'Your review has been submitted. Your feedback helps us improve our services.',
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
        middle: Text('Service History'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Filters
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
                  Expanded(
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.car_detailed,
                            size: 20,
                            color: _selectedServiceType != null
                                ? CupertinoTheme.of(context).primaryColor
                                : CupertinoColors.systemGrey,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _selectedServiceType?.label ?? 'All Services',
                            style: TextStyle(
                              color: _selectedServiceType != null
                                  ? CupertinoTheme.of(context).primaryColor
                                  : CupertinoColors.systemGrey,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) => CupertinoActionSheet(
                            title: const Text('Select Service Type'),
                            actions: [
                              CupertinoActionSheetAction(
                                child: const Text('All Services'),
                                onPressed: () {
                                  setState(() => _selectedServiceType = null);
                                  Navigator.pop(context);
                                },
                              ),
                              ...ServiceType.values.map(
                                (type) => CupertinoActionSheetAction(
                                  child: Text(type.label),
                                  onPressed: () {
                                    setState(() => _selectedServiceType = type);
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ],
                            cancelButton: CupertinoActionSheetAction(
                              isDestructiveAction: true,
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 24,
                    color: CupertinoColors.systemGrey4,
                  ),
                  Expanded(
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.calendar,
                            size: 20,
                            color: _selectedTimeRange != 'All Time'
                                ? CupertinoTheme.of(context).primaryColor
                                : CupertinoColors.systemGrey,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _selectedTimeRange,
                            style: TextStyle(
                              color: _selectedTimeRange != 'All Time'
                                  ? CupertinoTheme.of(context).primaryColor
                                  : CupertinoColors.systemGrey,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) => CupertinoActionSheet(
                            title: const Text('Select Time Range'),
                            actions: _timeRanges
                                .map(
                                  (range) => CupertinoActionSheetAction(
                                    child: Text(range),
                                    onPressed: () {
                                      setState(() => _selectedTimeRange = range);
                                      Navigator.pop(context);
                                    },
                                  ),
                                )
                                .toList(),
                            cancelButton: CupertinoActionSheetAction(
                              isDestructiveAction: true,
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Service History List
            Expanded(
              child: _completedBookings.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.clock,
                            size: 64,
                            color: CupertinoColors.systemGrey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No service history found',
                            style: TextStyle(
                              color: CupertinoColors.systemGrey,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: _completedBookings.length,
                      itemBuilder: (context, index) {
                        final booking = _completedBookings[index];
                        final review = mockReviews[booking.id];
                        final dateFormat = DateFormat('MMM d, y');

                        return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: CupertinoColors.systemBackground,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: CupertinoColors.systemGrey.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: CupertinoColors.systemGrey6,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        CupertinoIcons.car_detailed,
                                        size: 24,
                                        color: CupertinoColors.systemGrey
                                            .withOpacity(0.3),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            booking.vendor.name,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            booking.servicePackage.name,
                                            style: const TextStyle(
                                              color: CupertinoColors.systemGrey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '\$${booking.totalPrice.toStringAsFixed(2)}',
                                          style: TextStyle(
                                            color: CupertinoTheme.of(context)
                                                .primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          dateFormat.format(booking.dateTime),
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
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: const BoxDecoration(
                                  color: CupertinoColors.systemGrey6,
                                  borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(12),
                                  ),
                                ),
                                child: review != null
                                    ? Row(
                                        children: [
                                          ...List.generate(5, (index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.only(right: 4),
                                              child: Icon(
                                                index < review.rating
                                                    ? CupertinoIcons.star_fill
                                                    : CupertinoIcons.star,
                                                color:
                                                    CupertinoColors.systemYellow,
                                                size: 16,
                                              ),
                                            );
                                          }),
                                          const SizedBox(width: 8),
                                          if (review.comment != null)
                                            Expanded(
                                              child: Text(
                                                review.comment!,
                                                style: const TextStyle(
                                                  color:
                                                      CupertinoColors.systemGrey,
                                                  fontSize: 12,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          const Icon(
                                            CupertinoIcons.star,
                                            size: 16,
                                            color: CupertinoColors.systemGrey,
                                          ),
                                          const SizedBox(width: 8),
                                          const Expanded(
                                            child: Text(
                                              'Rate this service',
                                              style: TextStyle(
                                                color: CupertinoColors.systemGrey,
                                              ),
                                            ),
                                          ),
                                          CupertinoButton(
                                            padding: EdgeInsets.zero,
                                            child: const Text('Rate Now'),
                                            onPressed: () =>
                                                _showRatingDialog(booking),
                                          ),
                                        ],
                                      ),
                              ),
                            ],
                          ),
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
