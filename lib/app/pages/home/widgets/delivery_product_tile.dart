import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extensions/formatter_extensions.dart';
import '../../../core/ui/styles/colors_app.dart';
import '../../../core/ui/styles/text_styles.dart';
import '../../../dto/order_product_dto.dart';
import '../../../models/product_model.dart';
import '../home_controller.dart';

class DeliveryProductTile extends StatelessWidget {
  final ProductModel productModel;
  final OrderProductDto? orderProductDto;

  const DeliveryProductTile({
    Key? key,
    required this.productModel,
    this.orderProductDto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final controller = context.read<HomeController>();
        final orderProductResult = await Navigator.of(context).pushNamed(
          '/productDetail',
          arguments: {'product': productModel, 'order': orderProductDto},
        );

        if (orderProductResult != null) {
          controller.addOrUpdatebag(orderProductResult as OrderProductDto);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      productModel.name,
                      style: context.textStyles.textExtraBold
                          .copyWith(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      productModel.name,
                      style:
                          context.textStyles.textRegular.copyWith(fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      productModel.price.toCurreny,
                      style: context.textStyles.textMedium.copyWith(
                        fontSize: 12,
                        color: context.colors.second,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FadeInImage.assetNetwork(
              placeholder: 'assets/images/loading.gif',
              image: productModel.image,
              width: 100,
              height: 100,
              fit: BoxFit.contain,
            )
          ],
        ),
      ),
    );
  }
}
