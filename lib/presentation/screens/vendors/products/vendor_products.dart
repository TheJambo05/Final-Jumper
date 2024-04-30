import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/logic/cubits/vendor/vendor_products/vendor_product_cubit.dart';
import 'package:jumper/logic/cubits/vendor/vendor_products/vendor_product_state.dart';
import 'package:jumper/presentation/screens/vendors/products/my_product_page.dart';

class VendorProductScreen extends StatefulWidget {
  const VendorProductScreen({Key? key}) : super(key: key);

  @override
  State<VendorProductScreen> createState() => _VendorProductScreenState();
}

class _VendorProductScreenState extends State<VendorProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<VendorProductCubit, VendorProductState>(
        builder: (context, state) {
          if (state is VendorProductLoadingState &&
              state.userProducts.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is VendorProductErrorState && state.userProducts.isEmpty) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state is VendorProductLoadedState && state.userProducts.isEmpty) {
            return const Center(child: Text("Products will show up here.."));
          }

          return MyProductPage(products: state.userProducts);
        },
      ),
    );
  }
}
