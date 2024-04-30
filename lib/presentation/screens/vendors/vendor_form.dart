import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:jumper/presentation/screens/vendors/providers/vendor_form_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/user/gap_widget.dart';
import '../../widgets/user/primary_button.dart';
import '../../widgets/user/primary_textfield.dart';

class VendorFormScreen extends StatefulWidget {
  const VendorFormScreen({Key? key}) : super(key: key);

  static const String routeName = "vendor_form";

  @override
  State<VendorFormScreen> createState() => _VendorFormScreenState();
}

class _VendorFormScreenState extends State<VendorFormScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<VendorFormProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Professional Account Form"),
      ),
      body: SafeArea(
        child: Form(
          key: provider.formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 5, 16, 16),
            children: [
              (provider.error != "")
                  ? Text(
                      provider.error,
                      style: const TextStyle(color: Colors.red),
                    )
                  : const SizedBox(),
              const GapWidget(size: 5),
              PrimaryTextField(
                  controller: provider.fullNameController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Your Name is required!";
                    }
                    return null;
                  },
                  labelText: "Your Name"),
              const GapWidget(),
              PrimaryTextField(
                  controller: provider.emailController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Email address is required!";
                    }

                    if (!EmailValidator.validate(value.trim())) {
                      return "Invalid email address";
                    }

                    return null;
                  },
                  labelText: "Email Address"),
              const GapWidget(),
              PrimaryTextField(
                  controller: provider.addressController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Address is required!";
                    }
                    return null;
                  },
                  labelText: "Your Address"),
              const GapWidget(),
              PrimaryTextField(
                  controller: provider.cityController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Your City name is required!";
                    }
                    return null;
                  },
                  labelText: "Current City"),
              const GapWidget(),
              PrimaryTextField(
                  controller: provider.phoneNumberController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Phone Number is required!";
                    }
                    return null;
                  },
                  labelText: "Contact Number"),
              const GapWidget(),
              PrimaryTextField(
                  controller: provider.passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Password is required!";
                    }
                    return null;
                  },
                  labelText: "Password"),
              const GapWidget(),
              PrimaryTextField(
                  controller: provider.cPasswordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Confirm your password!";
                    }

                    if (value.trim() !=
                        provider.passwordController.text.trim()) {
                      return "Passwords do not match!";
                    }

                    return null;
                  },
                  labelText: "Confirm Password"),
              const GapWidget(),
              PrimaryButton(
                onPressed: () {
                  provider.createAccount();
                  _showSuccessDialog(context);
                },
                text: (provider.isLoading) ? "..." : "Send Form",
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Your form has been submitted successfully!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
