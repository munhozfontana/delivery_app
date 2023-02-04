import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailController extends Cubit<int> {
  ProductDetailController() : super(1);

  late final bool _hasHoder;

  initial(int amount, bool hasOrder) {
    _hasHoder = hasOrder;
    emit(amount);
  }

  increment() => emit(state + 1);
  decrement() {
    if (state > (_hasHoder ? 0 : 1)) {
      emit(state - 1);
    }
  }
}
