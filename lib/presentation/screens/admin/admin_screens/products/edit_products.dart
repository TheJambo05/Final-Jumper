import 'package:flutter/material.dart';
import 'package:jumper/presentation/widgets/user/primary_button.dart';
import 'package:jumper/presentation/widgets/user/primary_textfield.dart';

class EditProductDetailsScreen extends StatefulWidget {
  const EditProductDetailsScreen({Key? key}) : super(key: key);

  static const routeName = "edit_product_details";

  @override
  State<EditProductDetailsScreen> createState() =>
      _EditProductDetailsScreenState();
}

class _EditProductDetailsScreenState extends State<EditProductDetailsScreen> {
  final TextEditingController _nameController =
      TextEditingController(text: "Gucci");
  final TextEditingController _emailController = TextEditingController(
      text:
          "Classic sneakers with timeless style, offering comfort and versatility…");
  final TextEditingController _phoneController =
      TextEditingController(text: "6000");
  final TextEditingController _addressController =
      TextEditingController(text: "Pokhara");
  final TextEditingController _roleController =
      TextEditingController(text: "user");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gucci"),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {
              // Show a confirmation dialog before deleting the product
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Delete Product'),
                    content: const Text(
                        'Are you sure you want to delete this product?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          // Implement the logic to delete the product here
                          // This might involve updating a database or calling a network request
                          // Show a message confirming the deletion
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Product deleted successfully!')));
                          // Optionally navigate back to the previous screen or refresh the data
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: const Text('Yes'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: const Text('No'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: SizedBox(
                height: 300,
                child: Image(
                  image: AssetImage("assets/LV heels.jpg"),
                ),
              ),
            ),
            const SizedBox(height: 20),
            PrimaryTextField(
              labelText: "Title",
              controller: _nameController,
            ),
            const SizedBox(height: 20),
            PrimaryTextField(
              labelText: "Description",
              controller: _emailController,
            ),
            const SizedBox(height: 20),
            PrimaryTextField(
              labelText: "Price",
              controller: _phoneController,
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              text: "Save",
              onPressed: () {
                // You can replicate the save logic here or handle other specific actions
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _roleController.dispose();
    super.dispose();
  }
}
