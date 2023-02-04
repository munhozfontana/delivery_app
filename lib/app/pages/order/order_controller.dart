import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dto/order_dto.dart';
import '../../dto/order_product_dto.dart';
import '../../repositories/order/order_repository.dart';
import 'order_state.dart';

class OrderController extends Cubit<OrderState> {
  final OrderRepository _orderRepository;

  OrderController(
    this._orderRepository,
  ) : super(const OrderState.initial());

  Future<void> load(List<OrderProductDto> products) async {
    try {
      emit(state.copyWith(
        status: OrderStatus.loading,
      ));

      final paymentTypes = await _orderRepository.getAllPaymentsType();

      emit(state.copyWith(
        orderProducts: products,
        status: OrderStatus.loaded,
        paymentTypes: paymentTypes,
      ));
    } catch (e, s) {
      log('Erro ao buscar pagina', error: e, stackTrace: s);
      emit(state.copyWith(
        status: OrderStatus.error,
        errorMessage: 'Erro ao buscar pagina',
      ));
    }
  }

  void incrementProduct(int index) {
    final orders = [...state.orderProducts];
    final order = orders[index];
    orders[index] = order.copyWith(amount: order.amount + 1);
    _refreshOrder(orders);
  }

  void decrementProduct(int index) {
    final orders = [...state.orderProducts];
    final order = orders[index];
    final amount = order.amount;

    if (amount == 1) {
      if (state.status != OrderStatus.confirmRemoveProduct) {
        emit(OrderConfirmDeleteProductState(
          orderProduct: order,
          index: index,
          status: OrderStatus.confirmRemoveProduct,
          orderProducts: state.orderProducts,
          paymentTypes: state.paymentTypes,
          errorMessage: state.errorMessage,
        ));
        return;
      } else {
        orders.removeAt(index);
      }
    } else {
      orders[index] = order.copyWith(amount: order.amount - 1);
    }

    if (orders.isEmpty) {
      emit(state.copyWith(
        status: OrderStatus.emptyBag,
      ));
      return;
    }

    _refreshOrder(orders);
  }

  void _refreshOrder(List<OrderProductDto> orders) {
    emit(state.copyWith(
      status: OrderStatus.updateOrder,
      orderProducts: orders,
    ));
  }

  void cancelDeleteProcess() {
    emit(state.copyWith(
      status: OrderStatus.loaded,
    ));
  }

  emptyBag() {
    emit(state.copyWith(
      status: OrderStatus.emptyBag,
    ));
  }

  Future<void> saveOrder(
    String address,
    String document,
    int paymentMethodId,
  ) async {
    emit(state.copyWith(status: OrderStatus.loading));
    await _orderRepository.saveOrder(
      OrderDto(
          products: state.orderProducts,
          address: address,
          document: document,
          paymentMethodId: paymentMethodId),
    );
    emit(state.copyWith(status: OrderStatus.success));
  }
}
