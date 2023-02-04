import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/exceptions/repository_exceptions.dart';
import '../../core/rest_client/custom_dio.dart';
import '../../dto/order_dto.dart';
import '../../models/payment_type_model.dart';
import 'order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final CustomDio dio;

  OrderRepositoryImpl({
    required this.dio,
  });

  @override
  Future<List<PaymentTypeModel>> getAllPaymentsType() async {
    try {
      final result = await dio.auth().get('/payment-types');
      return result.data
          .map<PaymentTypeModel>((p) => PaymentTypeModel.fromMap(p))
          .toList();
    } on DioError catch (e, s) {
      log('Erro ao buscar as formas de pagamento', error: e, stackTrace: s);
      throw RepositoryExceptions(
        message: 'Erro ao buscar as formas de pagamento',
      );
    }
  }

  @override
  Future<void> saveOrder(OrderDto orderDto) async {
    try {
      await dio.auth().post('/orders', data: {
        'products': orderDto.products
            .map((e) => {
                  'id': e.productModel.id,
                  'amount': e.amount,
                  'total_price': e.totalPrice,
                })
            .toList(),
        'user_id': '#userAuthRef',
        'address': orderDto.address,
        'CPF': orderDto.document,
        'payment_method_id': orderDto.paymentMethodId,
      });
    } on DioError catch (e, s) {
      log('Erro ao registrar pedido', error: e, stackTrace: s);
      throw RepositoryExceptions(
        message: 'Erro ao registrar pedido',
      );
    }
  }
}
