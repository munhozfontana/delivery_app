import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extensions/formatter_extensions.dart';
import '../../../core/ui/styles/colors_app.dart';
import '../../../core/ui/styles/text_styles.dart';
import '../../../core/ui/widgets/delivery_increment_decrement_button.dart';
import '../../../dto/order_product_dto.dart';
import '../order_controller.dart';

class OrderProductTitle extends StatelessWidget {
  final int index;
  final OrderProductDto orderProductDto;

  const OrderProductTitle({
    Key? key,
    required this.index,
    required this.orderProductDto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productModel = orderProductDto.productModel;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Image.network(
            productModel.image,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productModel.name,
                    style:
                        context.textStyles.textRegular.copyWith(fontSize: 16),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        (productModel.price * orderProductDto.amount).toCurreny,
                        style: context.textStyles.textRegular.copyWith(
                          fontSize: 14,
                          color: context.colors.second,
                        ),
                      ),
                      DeliveryIncrementDecrementButton.compat(
                        amout: orderProductDto.amount,
                        incrementTab: () {
                          context
                              .read<OrderController>()
                              .incrementProduct(index);
                        },
                        decrementTab: () {
                          context
                              .read<OrderController>()
                              .decrementProduct(index);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
