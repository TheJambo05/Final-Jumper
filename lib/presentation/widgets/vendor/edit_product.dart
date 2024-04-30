import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/presentation/screens/user/change_password/change_password.dart';
import 'package:jumper/presentation/widgets/user/link_button.dart';
import '../../../core/design.dart';
import '../../../data/models/user/user_model.dart';
import '../../../logic/cubits/user_cubit/user_cubit.dart';
import '../../../logic/cubits/user_cubit/user_state.dart';
import '../../widgets/user/gap_widget.dart';
import '../../widgets/user/primary_button.dart';
import '../../widgets/user/primary_textfield.dart';

class EditProduct extends StatefulWidget {
  const EditProduct({super.key});

  static const routeName = "edit_product";

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Product"),
      ),
      body: SafeArea(
          child: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
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
          return editProduct(state.userModel);
        }

        return const Center(
          child: Text("An error occured!"),
        );
      })),
    );
  }

  Widget editProduct(UserModel userModel) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text("Personal Details",
            style: TextStyles.body1.copyWith(fontWeight: FontWeight.bold)),
        const GapWidget(
          size: -10,
        ),
        PrimaryTextField(
          initialValue: userModel.fullName,
          onChanged: (value) {
            userModel.fullName = value;
          },
          labelText: "Full Name",
        ),
        const GapWidget(),
        PrimaryTextField(
          initialValue: userModel.phoneNumber,
          onChanged: (value) {
            userModel.phoneNumber = value;
          },
          labelText: "Phone Number",
        ),
        const GapWidget(size: 20),
        Text("Address",
            style: TextStyles.body1.copyWith(fontWeight: FontWeight.bold)),
        const GapWidget(
          size: -10,
        ),
        PrimaryTextField(
          initialValue: userModel.address,
          onChanged: (value) {
            userModel.address = value;
          },
          labelText: "Address",
        ),
        const GapWidget(),
        PrimaryTextField(
          initialValue: userModel.city,
          onChanged: (value) {
            userModel.city = value;
          },
          labelText: "City",
        ),
        // LinkButton(
        //     onPressed: () {
        //       Navigator.pushNamed(context, ChangePasswordScreen.routeName);
        //     },
        //     text: "Change Password"),
        const GapWidget(),
        const GapWidget(),
        PrimaryButton(
            onPressed: () async {
              bool success = await BlocProvider.of<UserCubit>(context)
                  .updateUser(userModel);
              if (success) {
                Navigator.pop(context);
              }
            },
            text: "Save"),
      ],
    );
  }
}