import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../../dto/order_product_dto.dart';
import '../../repositories/products_repository.dart';
import 'home_state.dart';

class HomeController extends Cubit<HomeState> {
  final ProductsRepository _productsRepository;

  HomeController(
    this._productsRepository,
  ) : super(const HomeState.initial());

  Future<void> loadingProducts() async {
    emit(state.copyWith(status: HomeStateStatus.loading));
    try {
      await Future.delayed(const Duration(seconds: 2));
      final products = await _productsRepository.findAll();
      emit(state.copyWith(status: HomeStateStatus.loaded, products: products));
    } catch (e, s) {
      log('Erro ao buscar produtos', error: e, stackTrace: s);
      emit(
        state.copyWith(
            status: HomeStateStatus.error,
            errorMessage: 'Erro ao buscar produtos'),
      );
    }
  }

  void addOrUpdatebag(OrderProductDto orderProduct) {
    var shoppingBag = [...state.shoppingBag];

    final index = shoppingBag.indexWhere((orderProductItem) =>
        orderProductItem.productModel == orderProduct.productModel);

    if (index > -1) {
      if (orderProduct.amount == 0) {
        shoppingBag.removeAt(index);
      } else {
        shoppingBag[index] = orderProduct;
      }
    } else {
      shoppingBag.add(orderProduct);
    }

    emit(state.copyWith(shoppingBag: shoppingBag));
  }
}
