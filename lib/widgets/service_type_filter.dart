import 'package:flutter/cupertino.dart';
import '../models/vendor.dart';

class ServiceTypeFilter extends StatelessWidget {
  final List<ServiceType> selectedTypes;
  final Function(ServiceType) onToggle;

  const ServiceTypeFilter({
    super.key,
    required this.selectedTypes,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: ServiceType.values.length,
        itemBuilder: (context, index) {
          final type = ServiceType.values[index];
          final isSelected = selectedTypes.contains(type);
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 16 : 8,
              right: index == ServiceType.values.length - 1 ? 16 : 0,
            ),
            child: GestureDetector(
              onTap: () => onToggle(type),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: isSelected
                      ? CupertinoTheme.of(context).primaryColor
                      : CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    type.label,
                    style: TextStyle(
                      color: isSelected
                          ? CupertinoColors.white
                          : CupertinoColors.label,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
