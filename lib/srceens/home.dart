import 'dart:convert';
import 'package:pj/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:pj/models/configure.dart';
import 'package:flutter/material.dart';
import '../models/cart.dart';
import 'login.dart';
import 'package:pj/models/users.dart';
import 'info.dart';
import 'cart.dart';

class Home extends StatefulWidget {
  static const routeName = '/';
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Product> _productList = [];
  Future<void> getUsers() async {
    var url = Uri.http(Configure.server, "Product");
    var resp = await http.get(url);
    setState(() {
      _productList = productFromJson(resp.body);
      mainBody = showUsers();
    });
    return;
  }

  Future<void> removeUsers(product) async {
    var url = Uri.http(Configure.server, "product/${product.id}");
    var resp = await http.delete(url);
    print(resp.body);
    return;
  }

  Future<void> addNewUser(user) async {
    var url = Uri.http(Configure.server, "users");
    var resp = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toJson()));
    var rs = productFromJson("[${resp.body}]");

    if (rs.length == 1) {
      Navigator.pop(context);
    }
    return;
  }

  Widget showUsers() {
    return ListView.builder(
      itemCount: _productList.length,
      itemBuilder: (context, index) {
        Product product = _productList[index] as Product;
        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: ListTile(
              leading: Container(
                width: 65,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  image: DecorationImage(
                    image: NetworkImage("${product.photo}"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              title: Text(
                "${product.namep}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "Price: ${product.pricep} บาท",
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserInfo(),
                    settings: RouteSettings(arguments: product),
                  ),
                );
              },
              trailing: IconButton(
                onPressed: () async {
                  addNewcart(
                    product.namep!,
                    product.detailp!,
                    product.pricep!,
                    product.photo!,
                    product.count!,
                  );
                },
                icon: Icon(Icons.shopping_cart),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> addNewcart(String namep, String detailp, String pricep,
      String photo, String count) async {
    try {
      var url = Uri.http(Configure.server, "cart");
      var dataWithoutId = {
        "namec": namep,
        "detailc": detailp,
        "pricec": pricep,
        "photoc": photo,
        "countc": count,
      };
      var resp = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(dataWithoutId),
      );
      if (resp.statusCode == 200) {
        var rs = cartFromJson("[${resp.body}]");
        if (rs.length == 1) {
          Navigator.pop(context, "refresh");
        }
      } else {
        print("Error: ${resp.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PRODUCT PAGE',
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
      drawer: SideMenu(),
      body: mainBody,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     String result = await Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => UserForm()));
      //     if (result == "refresh") {
      //       getUsers();
      //     }
      //   },
      //   child: const Icon(Icons.person_add_alt_1),
      // ),
    );
  }
}

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    String accountName = "N/A";
    String accountEmail = "N/A";
    String accountUrl =
        "https://img.freepik.com/free-photo/cute-ai-generated-cartoon-bunny_23-2150288870.jpg";
    Users user = Configure.login;
    if (user.id != null) {
      accountName = user.name!;
      accountEmail = user.email!;
    }
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "https://png.pngtree.com/thumb_back/fh260/background/20200714/pngtree-modern-double-color-futuristic-neon-background-image_351866.jpg",
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.grey.withOpacity(0.8),
                  BlendMode.darken,
                ),
              ),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: UserAccountsDrawerHeader(
              accountName: Text(
                accountName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              accountEmail: Text(
                accountEmail,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(accountUrl),
                backgroundColor: Colors.white,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent, // Playful color
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.5), // Shadow color
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ListTile(
              leading: Icon(Icons.login, color: Colors.white), // Icon color
              title: Text(
                "Login",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white, // Text color
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, Login.routeName);
              },
            ),
          ),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.orangeAccent, // Playful color
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withOpacity(0.5), // Shadow color
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ListTile(
              leading:
                  Icon(Icons.attach_money, color: Colors.white), // Icon color
              title: Text(
                "Product",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white, // Text color
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, Home.routeName);
              },
            ),
          ),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.greenAccent, // Playful color
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(0.5), // Shadow color
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ListTile(
              leading:
                  Icon(Icons.shopping_cart, color: Colors.white), // Icon color
              title: Text(
                "Cart",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white, // Text color
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, Cartpage.routeName);
              },
            ),
          ),
        ],
      ),
    );
  }
}
