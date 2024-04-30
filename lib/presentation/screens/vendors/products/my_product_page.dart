import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jumper/core/api.dart';
import 'package:jumper/core/design.dart';
import 'package:jumper/data/models/product/product_model.dart';
import 'package:jumper/logic/services/formatter.dart';
import 'package:jumper/presentation/screens/admin/admin_screens/products/edit_products.dart';
import 'package:jumper/presentation/screens/product/product_screen.dart';
import 'package:jumper/presentation/widgets/user/gap_widget.dart';

class MyProductPage extends StatefulWidget {
  final List<ProductModel> products;

  const MyProductPage({Key? key, required this.products}) : super(key: key);

  @override
  _MyProductPageState createState() => _MyProductPageState();
}

class _MyProductPageState extends State<MyProductPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Your Products",
                  style: TextStyles.heading2,
                ),
              ],
            ),
            const GapWidget(),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75,
                ),
                itemCount: widget.products.length,
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemBuilder: (context, index) {
                  final product = widget.products[index];

                  return CupertinoButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        EditProductDetailsScreen.routeName,
                        arguments: product,
                      );
                      // Navigator.pushNamed(
                      //   context,
                      //   ProductDetailsScreen.routeName,
                      //   arguments: product,
                      // );
                    },
                    padding: EdgeInsets.zero,
                    child: Card(
                      elevation: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AspectRatio(
                            aspectRatio: 1,
                            child: CachedNetworkImage(
                              imageUrl: product.images != null &&
                                      product.images!.isNotEmpty
                                  ? "$finalUrl${product.images}"
                                  : 'http://placehold.it/200x200',
                              width: MediaQuery.of(context).size.width / 2,
                              fit: BoxFit.contain,
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Center(child: Icon(Icons.error)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title ?? 'Product Title',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  Formatter.formatPrice(product.price!),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
