import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const ProductCard({
    Key? key,
    required this.product,
    required this.onDelete,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4.0,
      child: ListTile(
        onTap: onTap,
        leading: Image.network(
          product.image,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(
          product.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          '\u{20B9}${product.price.toStringAsFixed(2)}',
          style: const TextStyle(color: Colors.green, fontSize: 16),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.blueGrey),
          onPressed: () {
            onDelete();
          },
        ),
      ),
    );
  }
}


