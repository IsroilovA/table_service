import 'package:flutter/material.dart';
import 'package:table_service/data/models/product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({required this.product, required this.onTap, super.key});

  final Product product;
  final void Function(Product product) onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(product);
      },
      child: Card(
        child: ListTile(
          contentPadding: const EdgeInsets.all(8),
          horizontalTitleGap: 0,
          leading: Image.network(
            "https://www.foodiesfeed.com/wp-content/uploads/2023/06/burger-with-melted-cheese.jpg",
            width: 70,
          ),
          title: Text(product.name),
          trailing: Text(product.getPrice),
        ),
      ),
    );
  }
}
