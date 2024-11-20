import 'package:flutter/material.dart';
import '../models/product_model.dart';

class DetailsScreen extends StatelessWidget {
  final Product product;

  DetailsScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child:
                  Image.network(product.image, height: 200, fit: BoxFit.cover),
            ),
            const SizedBox(height: 16),
            Text(product.title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(product.description),
                    const SizedBox(height: 8),
                    Text('Price: \$${product.price}',
                    style: const TextStyle(color: Colors.green, fontSize: 18)),
                    const SizedBox(height: 8),
                    Text('Category: ${product.category}'),
        ],
        ),
      ),
    );
  }
}
