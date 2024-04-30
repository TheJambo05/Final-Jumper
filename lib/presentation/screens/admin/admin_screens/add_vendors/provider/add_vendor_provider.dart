import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/logic/cubits/user_cubit/user_cubit.dart';
import 'package:jumper/logic/cubits/user_cubit/user_state.dart';

class AddVendorProvider with ChangeNotifier {
  final BuildContext context;
  AddVendorProvider(this.context) {
    _listenToUserCubit();
  }

  bool isLoading = false;
  String error = "";

  final roleController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cPasswordController = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  StreamSubscription? _userSubscription;

  void _listenToUserCubit() {
    _userSubscription =
        BlocProvider.of<UserCubit>(context).stream.listen((userState) {
      if (userState is UserLoadingState) {
        isLoading = true;
        error = "";
        notifyListeners();
      } else if (userState is UserErrorState) {
        isLoading = false;
        error = userState.message;
        notifyListeners();
      } else {
        isLoading = false;
        error = "";
        notifyListeners();
      }
    });
  }

  void createAccount() async {
    if (!formKey.currentState!.validate()) return;

    String role = roleController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String fullName = fullNameController.text.trim();
    String phoneNumber = phoneNumberController.text.trim();
    String address = addressController.text.trim();
    String city = cityController.text.trim();
    BlocProvider.of<UserCubit>(context).createVendor(
      role: role,
      email: email,
      password: password,
      fullName: fullName,
      phoneNumber: phoneNumber,
      address: address,
      city: city,
    );
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    super.dispose();
  }
}