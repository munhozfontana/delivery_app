import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/rest_client/custom_dio.dart';

class ApplicationBinding extends StatelessWidget {
  final Widget? child;

  const ApplicationBinding({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => CustomDio(),
        )
      ],
      child: child,
    );
  }
}
