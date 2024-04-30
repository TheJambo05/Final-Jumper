import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/presentation/screens/auth/login_screen.dart';
import 'package:jumper/presentation/screens/vendors/vendor_form.dart';
import 'package:jumper/presentation/widgets/user/gap_widget.dart';
import '../../../core/design.dart';
import '../../../data/models/user/user_model.dart';
import '../../../logic/cubits/user_cubit/user_cubit.dart';
import '../../../logic/cubits/user_cubit/user_state.dart';
import '../../widgets/user/link_button.dart';
import '../order/my_order_screen.dart';
import '../user/edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const String routeName = "profile_screen";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
      if (state is UserLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state is UserErrorState) {
        return Center(
          child: Text(state.message),
        );
      }

      if (state is UserLoggedInState) {
        return userProfile(state.userModel);
      }

      return const Center(
        child: Text("An error occured!"),
      );
    });
  }

  Widget userProfile(UserModel userModel) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage("assets/CV.jpg"),
                radius: 45,
              ),
              const GapWidget(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${userModel.fullName}", style: TextStyles.heading3),
                  Text(
                    "${userModel.email}",
                    style: TextStyles.body2,
                  ),
                  LinkButton(
                    onPressed: () {
                      Navigator.pushNamed(context, EditProfileScreen.routeName);
                    },
                    text: "Edit Profile",
                  ),
                ],
              ),
            ],
          ),
          const GapWidget(),
          const Divider(),
          ListTile(
              onTap: () {
                Navigator.pushNamed(context, MyOrderScreen.routeName);
              },
              contentPadding: EdgeInsets.zero,
              leading: const Icon(CupertinoIcons.cube_box_fill),
              title: Text(
                "My Orders",
                style: TextStyles.body1,
              )),
          ListTile(
              onTap: () {
                Navigator.pushNamed(context, VendorFormScreen.routeName);
              },
              contentPadding: EdgeInsets.zero,
              leading: const Icon(CupertinoIcons.person_2_alt),
              title: Text(
                "Professional Account Form",
                style: TextStyles.body1,
              )),
          ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Confirmation"),
                      content: const Text("Are you sure you want to Logout?"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: const Text(
                            "No",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            BlocProvider.of<UserCubit>(context).signOut();
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              LoginScreen.routeName,
                              (route) => false,
                            );
                          },
                          child: const Text(
                            "Yes",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.red, fontSize: 20),
              )),
        ],
      ),
    );
  }
}
