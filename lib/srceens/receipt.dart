import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pj/srceens/success.dart';
import '../models/cart.dart';
import '../models/configure.dart';
import '../models/users.dart';
import 'package:intl/intl.dart';

class Receipt extends StatefulWidget {
  static const routeName = '/receipt';
  const Receipt({super.key});

  @override
  State<Receipt> createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {
  List<Cart> _cartList = [];
  Future<void> getUsers() async {
    var url = Uri.http(Configure.server, "cart");
    var resp = await http.get(url);
    setState(() {
      _cartList = cartFromJson(resp.body);
      mainBody = showUsers();
    });
    return;
  }

  Future<void> removeUsers(List<Cart> cartList) async {
    for (var cart in cartList) {
      var url = Uri.http(Configure.server, "cart/${cart.id}");
      var resp = await http.delete(url);
      print(resp.body);
    }
  }

  Widget showUsers() {
    int totalItemCount = 0;
    int totalPrice = 0;

    for (var cart in _cartList) {
      totalItemCount += int.parse(cart.countc!);
      totalPrice += int.parse(cart.countc!) * int.parse(cart.pricec!);
    }

    // Format totalPrice with commas
    final formatter = NumberFormat("#,###");
    String formattedPrice = formatter.format(totalPrice);

    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Center(
              child: Column(
                children: [
                  Text("รวมจำนวน ${totalItemCount} ตัว",
                      style: TextStyle(fontSize: 40)),
                  Text("รวมราคา ${formattedPrice} บาท",
                      style: TextStyle(fontSize: 40)),
                  Image.network(
                    "https://cdn.pic.in.th/file/picinth/334654851_946473650130401_724856826467276888_n.jpeg",
                    width: 200,
                    height: 600,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget mainBody = Container();
  @override
  void initState() {
    super.initState();
    Users user = Configure.login;
    if (user.id != null) {
      getUsers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'RECEIPT',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 2
              ..color = Colors.white,
            shadows: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(2, 2),
                blurRadius: 4,
              ),
            ],
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.red,
                Colors.orange,
                Colors.yellow,
                Colors.green,
                Colors.blue,
                Colors.indigo,
                Colors.purple,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: mainBody,
      floatingActionButton: Container(
        width: 200,
        height: 50,
        child: ElevatedButton(
          onPressed: () async {
            await removeUsers(_cartList);
            Navigator.pushNamed(context, Successpage.routeName);
          },
          child: Text(
            'ยืนยัน',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
