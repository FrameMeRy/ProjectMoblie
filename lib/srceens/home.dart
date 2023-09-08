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
        return Dismissible(
          key: UniqueKey(),
          child: Card(
            child: ListTile(
              leading: Image.network("${product.photo}"),
              title: Text("${product.namep}"),
              subtitle: Text("ราคา ${product.pricep}  บาท"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserInfo(),
                        settings: RouteSettings(arguments: product)));
              },
              trailing: IconButton(
                onPressed: () async {
                  addNewcart(
                    product.namep!, 
                    product.detailp!, 
                    product.pricep!, 
                    product.photo!,
                    product.count!
                    
                  );
                },
                icon: Icon(Icons.trolley),
              ),
            ),
          ),
          onDismissed: (direction) {
            removeUsers(product);
          },
          background: Container(
            color: Colors.red,
            margin: EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.centerRight,
            child: Icon(Icons.delete, color: Colors.white),
          ),
        );
      },
    );
  }

  Future<void> addNewcart(String namep, String detailp, String pricep, String photo ,String count) async {
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
        title: Text("Product Page"),
        backgroundColor: Colors.pink,
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
            UserAccountsDrawerHeader(
              accountName: Text(accountName,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              accountEmail: Text(accountEmail,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(accountUrl),
                backgroundColor: Colors.white,
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://png.pngtree.com/thumb_back/fh260/background/20200731/pngtree-blue-carbon-background-with-sport-style-and-golden-light-image_371487.jpg"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.grey.withOpacity(0.8),
                    BlendMode.darken,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.login),
              title: Text("Login"),
              onTap: () {
                Navigator.pushNamed(context, Login.routeName);
              },
            ),
            ListTile(
              leading: Icon(Icons.attach_money),
              title: Text("Product"),
              onTap: () {
                Navigator.pushNamed(context, Home.routeName);
              },
            ),
            ListTile(
              leading: Icon(Icons.trolley),
              title: Text("cart"),
              onTap: () {
                Navigator.pushNamed(context, Cartpage.routeName);
              },
            )
          ]),
    );
  }
}
