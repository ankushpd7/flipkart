import 'package:flipkart/core/storage_helper.dart';
import 'package:flipkart/model/product_model.dart';
import 'package:flipkart/screen/add_product_screen.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  StorageHelper storageHelper = StorageHelper();
  List<Product> productList = [];

  @override
  void initState() {
    loadProducts();
    super.initState();
  }

  Future loadProducts() async {
    productList = await storageHelper.getProducts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddProductScreen();
          }));
          loadProducts();
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index) {
          final product = productList[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: Image.network(
                product.imageUrl ?? '',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(product.name),
              subtitle: Text(
                product.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Text('\$${product.price.toStringAsFixed(2)}'),
            ),
          );
        },
      ),
    );
  }
}
