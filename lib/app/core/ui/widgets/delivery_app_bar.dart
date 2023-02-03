import 'package:flutter/material.dart';

class DeliveryAppBar extends AppBar {
  DeliveryAppBar({
    super.key,
    super.elevation = .5,
  }) : super(
          title: Image.asset(
            'assets/images/logo.png',
            width: 80,
          ),
        );
}
