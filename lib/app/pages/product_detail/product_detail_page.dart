import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/extensions/formatter_extensions.dart';
import '../../core/ui/base_state/base_state.dart';
import '../../core/ui/helpers/size_externsions.dart';
import '../../core/ui/styles/text_styles.dart';
import '../../core/ui/widgets/delivery_app_bar.dart';
import '../../core/ui/widgets/delivery_increment_decrement_button.dart';
import '../../dto/order_product_dto.dart';
import '../../models/product_model.dart';
import 'product_detail_controller.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductModel productModel;
  final OrderProductDto? orderProductDto;

  const ProductDetailPage({
    super.key,
    required this.productModel,
    this.orderProductDto,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState
    extends BaseState<ProductDetailPage, ProductDetailController> {
  @override
  void initState() {
    super.initState();
    final amount = widget.orderProductDto?.amount ?? 1;
    controller.initial(amount, widget.orderProductDto != null);
  }

  _showConfirmDelete(int amount) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Deseja excluir o produto?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancelar',
                style: context.textStyles.textBold.copyWith(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Confirmar',
                style: context.textStyles.textBold,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppBar(),
      body: Column(
        children: [
          Container(
            width: context.screenWidth,
            height: context.percentHeight(.4),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.productModel.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              widget.productModel.name,
              style: context.textStyles.textExtraBold.copyWith(fontSize: 22),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Text(widget.productModel.description),
              ),
            ),
          ),
          const Divider(),
          BlocBuilder<ProductDetailController, int>(
            builder: (context, amount) {
              return Row(
                children: [
                  Container(
                    width: context.percentWidth(.5),
                    height: 68,
                    padding: const EdgeInsets.all(8),
                    child: DeliveryIncrementDecrementButton(
                      amout: amount,
                      decrementTab: controller.decrement,
                      incrementTab: controller.increment,
                    ),
                  ),
                  Container(
                    width: context.percentWidth(.5),
                    height: 68,
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton(
                      style: amount == 0
                          ? ElevatedButton.styleFrom(
                              backgroundColor: Colors.red)
                          : null,
                      onPressed: () {
                        if (amount == 0) {
                          _showConfirmDelete(amount);
                        } else {
                          Navigator.of(context).pop(OrderProductDto(
                            productModel: widget.productModel,
                            amount: amount,
                          ));
                        }
                      },
                      child: Visibility(
                        visible: amount > 0,
                        replacement: const Text('Excluir produtos'),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Adicionar',
                              style: context.textStyles.textExtraBold.copyWith(
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            AutoSizeText(
                              (widget.productModel.price * amount).toCurreny,
                              maxFontSize: 13,
                              minFontSize: 8,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: context.textStyles.textExtraBold,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
