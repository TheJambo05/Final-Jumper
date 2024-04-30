import 'package:jumper/data/models/vendor/vendor_model.dart';

abstract class VendorState {}

class VendorInitialState extends VendorState {}

class VendorLoadingState extends VendorState {}

class VendorLoggedInState extends VendorState {
  final VendorModel vendorModel;
  VendorLoggedInState(this.vendorModel);
}

class VendorLoggedOutState extends VendorState {}

class VendorErrorState extends VendorState {
  final String message;
  VendorErrorState(this.message);
}
