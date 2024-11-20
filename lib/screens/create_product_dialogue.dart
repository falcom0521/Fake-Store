
import 'package:fakestore/utils/toast.dart';
import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';

class CreateProductDialog extends StatefulWidget {
  final VoidCallback onProductCreated;

  CreateProductDialog({required this.onProductCreated});

  @override
  _CreateProductDialogState createState() => _CreateProductDialogState();
}

class _CreateProductDialogState extends State<CreateProductDialog> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  double _price = 0.0;
  String _category = '';
  final _image = 'https://via.placeholder.com/150';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text('Create New Product')),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title :'),
                onSaved: (value) => _title = value ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description :'),
                onSaved: (value) => _description = value ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price :'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _price = double.parse(value ?? '0'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Category :'),
                onSaved: (value) => _category = value ?? '',
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel', style: TextStyle(color: Colors.blueGrey),),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey,
            foregroundColor: Colors.white
          ),

          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              ApiService()
                  .createProduct(Product(
                id: 0,
                title: _title,
                price: _price,
                description: _description,
                image: _image,
                category: _category,
              ))
                  .then((_) {
                widget.onProductCreated();
                  ToastMessage.showToast(context, 'Product added successfully');
                Navigator.pop(context);
                //  ToastMessage.show(message: ' succfully updated');
              });
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
