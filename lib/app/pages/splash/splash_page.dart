import 'package:flutter/material.dart';

import '../../core/config/env/env.dart';
import '../../core/ui/helpers/size_externsions.dart';
import '../../core/ui/widgets/delivery_button.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Column(
        children: [
          Container(),
          DeliveryButton(
            label: Env.i['backend_base_url'] ?? '',
            onPressed: () {},
            width: 300,
            height: 124,
          ),
          Text(MediaQuery.of(context).size.width.toString()),
          Text(context.screenWidth.toString()),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Text'),
          )
        ],
      ),
    );
  }
}
