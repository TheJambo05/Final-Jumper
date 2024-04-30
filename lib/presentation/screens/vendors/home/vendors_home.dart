import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:jumper/logic/cubits/cart_cubit/cart_state.dart';
import 'package:jumper/logic/cubits/user_cubit/user_cubit.dart';
import 'package:jumper/logic/cubits/user_cubit/user_state.dart';
import 'package:jumper/presentation/screens/cart/cart_screen.dart';
import 'package:jumper/presentation/screens/home/product_screen.dart';
import 'package:jumper/presentation/screens/home/profile_screen.dart';
import 'package:jumper/presentation/screens/splash/splash_screen.dart';
import 'package:jumper/presentation/screens/vendors/add_products_screen.dart';
import 'package:jumper/presentation/screens/vendors/products/vendor_products.dart';
import 'package:jumper/presentation/widgets/user/side_drawer.dart';

class VendorsHome extends StatefulWidget {
  const VendorsHome({super.key});

  static const String routeName = "vendors";

  @override
  State<VendorsHome> createState() => _VendorsHomeState();
}

class _VendorsHomeState extends State<VendorsHome> {
  int currentIndex = 0;
  List<Widget> screens = const [
    AddProductScreen(),
    ProductScreen(),
    // VendorProductScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserLoggedOutState) {
          Navigator.pushReplacementNamed(context, SplashScreen.routeName);
        }
      },
      child: Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: 'Products',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
