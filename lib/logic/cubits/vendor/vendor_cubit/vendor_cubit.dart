import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/data/models/vendor/vendor_model.dart';
import 'package:jumper/data/repositories/vendor_repository.dart';
import 'package:jumper/logic/cubits/vendor/vendor_cubit/vendor_state.dart';
import 'package:jumper/logic/services/preferences.dart';

class VendorCubit extends Cubit<VendorState> {
  VendorCubit() : super(VendorInitialState()) {
    _initialize();
  }

  final VendorRepository _vendorRepository = VendorRepository();

  void _initialize() async {
    final userDetails = await Preferences.fetchUserDetails();
    String? email = userDetails["email"];
    String? password = userDetails["password"];

    if (email == null || password == null) {
      emit(VendorLoggedOutState());
    } else {
      signIn(email: email, password: password);
    }
  }

  void _emitLoggedInState(
      {required VendorModel vendorModel,
      required String email,
      required String password}) async {
    await Preferences.saveUserDetails(email, password);
    emit(VendorLoggedInState(vendorModel));
  }

  void signIn({required String email, required String password}) async {
    emit(VendorLoadingState());
    try {
      VendorModel vendorModel =
          await _vendorRepository.signIn(email: email, password: password);
      _emitLoggedInState(
          vendorModel: vendorModel, email: email, password: password);
    } catch (ex) {
      emit(VendorErrorState(ex.toString()));
    }
  }

  void createAccount({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
    required String address,
    required String city,
  }) async {
    emit(VendorLoadingState());
    try {
      VendorModel vendorModel = await _vendorRepository.createAccount(
        email: email,
        password: password,
        fullName: fullName,
        phoneNumber: phoneNumber,
        address: address,
        city: city,
      );
      _emitLoggedInState(
          vendorModel: vendorModel, email: email, password: password);
    } catch (ex) {
      emit(VendorErrorState(ex.toString()));
    }
  }

  Future<bool> updateUser(VendorModel vendorModel) async {
    emit(VendorLoadingState());
    try {
      VendorModel updatedVendor =
          await _vendorRepository.updateVendor(vendorModel);
      emit(VendorLoggedInState(updatedVendor));
      return true;
    } catch (ex) {
      emit(VendorErrorState(ex.toString()));
      return false;
    }
  }

  Future<bool> changePassword(VendorModel vendorModel) async {
    emit(VendorLoadingState());
    try {
      VendorModel updatedVendor =
          await _vendorRepository.updateVendor(vendorModel);
      emit(VendorLoggedInState(updatedVendor));
      return true;
    } catch (ex) {
      emit(VendorErrorState(ex.toString()));
      return false;
    }
  }

  void signOut() async {
    await Preferences.clear();
    emit(VendorLoggedOutState());
  }
}
