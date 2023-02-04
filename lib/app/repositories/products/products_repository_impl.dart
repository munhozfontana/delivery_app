import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/exceptions/repository_exceptions.dart';
import '../../core/rest_client/custom_dio.dart';
import '../../models/product_model.dart';
import 'products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final CustomDio dio;

  ProductsRepositoryImpl({
    required this.dio,
  });

  @override
  Future<List<ProductModel>> findAll() async {
    try {
      final result = await dio.unauth().get('/products');
      return result.data
          .map<ProductModel>((item) => ProductModel.fromMap(item))
          .toList();
    } on DioError catch (e, s) {
      log(
        'Erro ao buscar produtos',
        error: e,
        stackTrace: s,
      );
      throw RepositoryExceptions(message: 'Erro ao buscar produtos');
    }
  }
}
