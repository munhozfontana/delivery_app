import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/exceptions/repository_exceptions.dart';
import '../../core/exceptions/unauthorized_exeception.dart';
import '../../core/rest_client/custom_dio.dart';
import '../../models/auth_model.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final CustomDio dio;

  AuthRepositoryImpl({
    required this.dio,
  });

  @override
  Future<AuthModel> login(String email, String password) async {
    try {
      final result = await dio.unauth().post('/auth', data: {
        'email': email,
        'password': password,
      });

      return AuthModel.fromMap(result.data);
    } on DioError catch (e, s) {
      log('Erro ao relaizar login', error: e, stackTrace: s);

      if (e.response?.statusCode == 403) {
        log('Permissão negada', error: e, stackTrace: s);
        throw UnauthorizedExeception();
      }

      throw RepositoryExceptions(message: 'Erro ao relaizar login');
    }
  }

  @override
  Future<void> register(String name, String email, String password) async {
    try {
      await dio.unauth().post('/users', data: {
        'name': name,
        'email': email,
        'password': password,
      });
    } on DioError catch (e, s) {
      log('Erro ao registrar usuário', error: e, stackTrace: s);
      throw RepositoryExceptions(message: 'Erro ao reigstrar usuário');
    }
  }
}
