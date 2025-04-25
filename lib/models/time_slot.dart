class TimeSlot {
  final DateTime dateTime;
  final bool isAvailable;
  final double price;
  final String label;

  const TimeSlot({
    required this.dateTime,
    required this.isAvailable,
    required this.price,
    required this.label,
  });
}

List<TimeSlot> generateMockTimeSlots() {
  final now = DateTime.now();
  final slots = <TimeSlot>[];
  
  // Today's slots
  for (var hour = 9; hour <= 17; hour += 2) {
    slots.add(
      TimeSlot(
        dateTime: DateTime(now.year, now.month, now.day, hour),
        isAvailable: true,
        price: 4000,
        label: 'Today, ${hour > 12 ? '${hour - 12} PM' : '$hour AM'}',
      ),
    );
  }

  // Tomorrow's slots
  // final tomorrow = now.add(const Duration(days: 1));
  // for (var hour = 9; hour <= 17; hour += 2) {
  //   slots.add(
  //     TimeSlot(
  //       dateTime: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, hour),
  //       isAvailable: true,
  //       price: 24.99, // Discount for advance booking
  //       label: 'Tomorrow, ${hour > 12 ? '${hour - 12} PM' : '$hour AM'}',
  //     ),
  //   );
  // }

  return slots;
}
