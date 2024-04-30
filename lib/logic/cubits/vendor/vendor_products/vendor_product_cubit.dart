import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/data/repositories/product_repository.dart';
import 'package:jumper/logic/cubits/user_cubit/user_cubit.dart';
import 'package:jumper/logic/cubits/user_cubit/user_state.dart';
import 'package:jumper/logic/cubits/vendor/vendor_products/vendor_product_state.dart';

class VendorProductCubit extends Cubit<VendorProductState> {
  final UserCubit _userCubit;
  StreamSubscription? _userSubscription;

  final _productRepository = ProductRepository();

  VendorProductCubit(this._userCubit) : super(VendorProductInitialState()) {
    // Listen to changes in the UserCubit state
    _userSubscription = _userCubit.stream.listen(_handleUserState);
  }

  void _handleUserState(UserState userState) {
    if (userState is UserLoggedInState) {
      _loadVendorProducts(userState.userModel.sId!);
    } else {
      emit(VendorProductInitialState());
    }
  }

  void _loadVendorProducts(String userId) async {
    emit(VendorProductLoadingState(state.userProducts));
    try {
      final products = await _productRepository.fetchProductsByUserId(userId);
      emit(VendorProductLoadedState(products));
    } catch (ex) {
      emit(VendorProductErrorState(ex.toString(), state.userProducts));
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
