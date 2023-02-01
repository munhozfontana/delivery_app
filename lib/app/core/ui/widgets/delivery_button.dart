import 'package:flutter/material.dart';

class DeliveryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  final double? width;
  final double? height;

  const DeliveryButton({
    super.key,
    this.width,
    this.height,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
