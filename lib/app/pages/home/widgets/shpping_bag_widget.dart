import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/extensions/formatter_extensions.dart';
import '../../../core/ui/helpers/size_externsions.dart';
import '../../../core/ui/styles/text_styles.dart';
import '../../../dto/order_product_dto.dart';

class ShppingBagWidget extends StatelessWidget {
  final List<OrderProductDto> bag;

  const ShppingBagWidget({
    super.key,
    required this.bag,
  });

  Future<void> _goOrder(BuildContext context) async {
    final navigator = Navigator.of(context);
    final sp = await SharedPreferences.getInstance();

    if (sp.containsKey('accessToken')) {
      final loginResult = navigator.pushNamed('/auth/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    var totalBat = bag
        .fold<double>(0.0, (total, element) => total += element.totalPrice)
        .toCurreny;

    return Container(
      width: context.screenWidth,
      height: 90,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: ElevatedButton(
          onPressed: () {
            _goOrder(context);
          },
          child: Stack(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.shopping_cart_outlined),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Ver Sacola',
                  style:
                      context.textStyles.textExtraBold.copyWith(fontSize: 14),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  totalBat,
                  style:
                      context.textStyles.textExtraBold.copyWith(fontSize: 11),
                ),
              ),
            ],
          )),
    );
  }
}