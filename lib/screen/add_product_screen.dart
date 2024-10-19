import 'package:flipkart/core/storage_helper.dart';
import 'package:flipkart/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final StorageHelper storageHelper = StorageHelper();

  void _addProduct() async {
    String id = Uuid().v4(); // Generate a unique ID for the product
    String name = _nameController.text;
    String description = _descriptionController.text;
    String imageUrl = _imageUrlController.text;
    double price = double.tryParse(_priceController.text) ?? 0.0;

    if (name.isNotEmpty && description.isNotEmpty && price > 0) {
      Product product = Product(
        id: id,
        name: name,
        description: description,
        imageUrl: imageUrl.isEmpty
            ? 'https://via.placeholder.com/150'
            : imageUrl, // Default image if not provided
        price: price,
      );

      await storageHelper.saveProduct(product);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('product added successfully'),
        ),
      );
      Navigator.pop(context); // Go back to the previous screen after saving
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Input all fields'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _imageUrlController,
              decoration: InputDecoration(labelText: 'Image URL (optional)'),
            ),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addProduct,
              child: Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
