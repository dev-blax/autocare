import 'package:flutter/cupertino.dart';
import '../models/payment_method.dart';

class PaymentMethodSelector extends StatelessWidget {
  final PaymentMethod selectedMethod;
  final Function(PaymentMethod) onSelect;

  const PaymentMethodSelector({
    super.key,
    required this.selectedMethod,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: PaymentMethod.values.map((method) {
        final isSelected = method == selectedMethod;
        return GestureDetector(
          onTap: () => onSelect(method),
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected
                  ? CupertinoTheme.of(context).primaryColor.withOpacity(0.1)
                  : CupertinoColors.systemBackground,
              border: Border.all(
                color: isSelected
                    ? CupertinoTheme.of(context).primaryColor
                    : CupertinoColors.systemGrey4,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  method.icon,
                  color: isSelected
                      ? CupertinoTheme.of(context).primaryColor
                      : CupertinoColors.label,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        method.label,
                        style: TextStyle(
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      Text(
                        method.description,
                        style: const TextStyle(
                          fontSize: 12,
                          color: CupertinoColors.systemGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  const Icon(
                    CupertinoIcons.checkmark_alt,
                    color: CupertinoColors.systemGreen,
                  ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
