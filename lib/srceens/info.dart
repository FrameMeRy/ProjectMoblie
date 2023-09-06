import 'package:flutter/material.dart';
import 'package:pj/models/product.dart';

class UserInfo extends StatelessWidget {

  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    
    Product product = ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Info"),
        backgroundColor: Colors.pink,

      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Center(
          child: Card(
            child: Center(
              child: ListView(
                children: [
                 ListTile(title: Image.network("${product.photo}"),),
                 ListTile(title: Text("ชื่อของไดโนเสาร์"),subtitle: Text("${product.namep}"),),
                 ListTile(title: Text("รายละเอียด"),subtitle: Text("${product.detailp}"),),
                 ListTile(title: Text("ราคา"),subtitle: Text("${product.pricep}"),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}