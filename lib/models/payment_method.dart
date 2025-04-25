import 'package:flutter/cupertino.dart';

enum PaymentMethod {
  card(
    'Credit/Debit Card',
    CupertinoIcons.creditcard,
    'Visa ending in 4242',
  ),
  applePay(
    'Apple Pay',
    CupertinoIcons.device_phone_portrait,
    'Pay with your iPhone',
  ),
  cash(
    'Cash',
    CupertinoIcons.money_dollar,
    'Pay at location',
  );

  final String label;
  final IconData icon;
  final String description;

  const PaymentMethod(this.label, this.icon, this.description);
}
