import 'package:fakestore/utils/toast.dart';
import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';
import '../widgets/product_card.dart';
import 'create_product_dialogue.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Product>> _products;

  @override
  void initState() {
    super.initState();
    _products = ApiService().fetchProducts();
  }

  void _refreshProducts() {
    setState(() {
      _products = ApiService().fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAKE STORE'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        titleTextStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: FutureBuilder<List<Product>>(
        future: _products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products available.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final product = snapshot.data![index];
                return ProductCard(
                  product: product,
                  onDelete: () {
                    ApiService().deleteProduct(product.id).then((value) {
                      _refreshProducts();
                      ToastMessage.showToast(
                          context, 'Product deleted successfully');
                    }).catchError((error) {
                      ToastMessage.showToast(
                          context, 'Failed to delete product: $error');
                    });
                  },
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(product: product),
                      ),
                    );
                    _refreshProducts();
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        child: const Icon(Icons.add, color: Colors.white,),
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) => CreateProductDialog(
              onProductCreated: _refreshProducts,
              
            ),
          );
        },
      ),
    );
  }
}
