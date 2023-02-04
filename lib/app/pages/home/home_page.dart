import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/ui/base_state/base_state.dart';
import '../../core/ui/widgets/delivery_app_bar.dart';
import 'home_controller.dart';
import 'home_state.dart';
import 'widgets/delivery_product_tile.dart';
import 'widgets/shpping_bag_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeController> {
  @override
  void onReady() {
    controller.loadingProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppBar(),
      body: BlocConsumer<HomeController, HomeState>(
        listener: (BuildContext context, state) {
          state.status.matchAny(
            any: hideLodaer,
            loading: showLodaer,
            error: () {
              hideLodaer();
              messageError(state.errorMessage ?? 'Erro não informado');
            },
          );
        },
        buildWhen: (previous, current) => current.status.matchAny(
          any: () => false,
          initial: () => true,
          loaded: () => true,
        ),
        builder: (BuildContext context, state) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    final productModel = state.products[index];
                    final order = state.shoppingBag
                        .where((order) => order.productModel == productModel);

                    return DeliveryProductTile(
                      productModel: productModel,
                      orderProductDto: order.isNotEmpty ? order.first : null,
                    );
                  },
                ),
              ),
              Visibility(
                visible: state.shoppingBag.isNotEmpty,
                child: ShppingBagWidget(
                  bag: state.shoppingBag,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
