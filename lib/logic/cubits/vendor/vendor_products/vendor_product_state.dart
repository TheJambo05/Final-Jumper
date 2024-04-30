import 'package:jumper/data/models/product/product_model.dart';

abstract class VendorProductState {
  final List<ProductModel> userProducts;
  VendorProductState(this.userProducts);
}

class VendorProductInitialState extends VendorProductState {
  VendorProductInitialState() : super([]);
}

class VendorProductLoadingState extends VendorProductState {
  VendorProductLoadingState(super.userProducts);
}

class VendorProductLoadedState extends VendorProductState {
  VendorProductLoadedState(super.userProducts);
}

class VendorProductAddedState extends VendorProductState {
  VendorProductAddedState(super.userProducts);
}

class VendorProductErrorState extends VendorProductState {
  final String message;
  VendorProductErrorState(this.message, super.userProducts);
}
