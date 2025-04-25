import 'package:flutter/cupertino.dart';
import '../models/time_slot.dart';

class TimeSlotPicker extends StatelessWidget {
  final List<TimeSlot> timeSlots;
  final TimeSlot? selectedSlot;
  final Function(TimeSlot) onSelect;

  const TimeSlotPicker({
    super.key,
    required this.timeSlots,
    required this.selectedSlot,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: timeSlots.length,
        itemBuilder: (context, index) {
          final slot = timeSlots[index];
          final isSelected = selectedSlot == slot;

          return GestureDetector(
            onTap: () => onSelect(slot),
            child: Container(
              width: 120,
              margin: EdgeInsets.only(
                left: index == 0 ? 16 : 8,
                right: index == timeSlots.length - 1 ? 16 : 0,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? CupertinoTheme.of(context).primaryColor
                    : CupertinoColors.systemBackground,
                border: Border.all(
                  color: isSelected
                      ? CupertinoTheme.of(context).primaryColor
                      : CupertinoColors.systemGrey4,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    slot.label,
                    style: TextStyle(
                      color: isSelected
                          ? CupertinoColors.white
                          : CupertinoColors.label,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tsh ${slot.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: isSelected
                          ? CupertinoColors.white
                          : CupertinoTheme.of(context).primaryColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
