import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/presentation/screens/admin/admin_panel.dart';
import 'package:jumper/presentation/screens/vendors/home/vendors_home.dart';
import '../auth/login_screen.dart';
import '../home/home_screen.dart';
import '../../../logic/cubits/user_cubit/user_cubit.dart';
import '../../../logic/cubits/user_cubit/user_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = "splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void goToNextScreen() {
    UserState userState = BlocProvider.of<UserCubit>(context).state;

    // Clear the navigation stack
    Navigator.popUntil(context, (route) => route.isFirst);

    // Navigate based on user role and state
    if (userState is UserLoggedInState) {
      String role = userState.userModel.role!;
      switch (role) {
        case 'admin':
          Navigator.pushReplacementNamed(context, AdminPanel.routeName);
          break;
        case 'vendor':
          Navigator.pushReplacementNamed(context, VendorsHome.routeName);
          break;
        default:
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          break;
      }
    } else if (userState is UserLoggedOutState || userState is UserErrorState) {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 100), () {
      goToNextScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        goToNextScreen();
      },
      child: const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
