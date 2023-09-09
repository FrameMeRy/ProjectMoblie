import 'package:http/http.dart' as http;
import 'package:pj/models/configure.dart';
import 'package:flutter/material.dart';
import 'package:pj/srceens/login.dart';
import 'package:pj/srceens/receipt.dart';
import '../models/cart.dart';
import 'home.dart';
import 'package:pj/models/users.dart';
import 'info.dart';

class Cartpage extends StatefulWidget {
  static const routeName = '/cart';
  const Cartpage({super.key});

  @override
  State<Cartpage> createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage> {
  List<Cart> _cartList = [];
  Future<void> getUsers() async {
    var url = Uri.http(Configure.server, "Cart");
    var resp = await http.get(url);
    setState(() {
      _cartList = cartFromJson(resp.body);
      mainBody = showUsers();
    });
    return;
  }

  Future<void> removeUsers(cart) async {
    var url = Uri.http(Configure.server, "cart/${cart.id}");
    var resp = await http.delete(url);
    print(resp.body);
    return;
  }



  Widget showUsers() {
    return ListView.builder(
      itemCount: _cartList.length,
      itemBuilder: (context, index) {
        Cart cart = _cartList[index] as Cart;
        return Dismissible(
          key: UniqueKey(),
          child: Card(
            child: ListTile(
              leading: Image.network("${cart.photoc}"),
              title: Text("${cart.namec}"),
              subtitle: Text("ราคา ${cart.pricec}  บาท"),
              trailing: Text("จำนวน ${cart.countc} ตัว"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserInfo(),
                        settings: RouteSettings(arguments: cart)));
              },
            ),
          ),
          onDismissed: (direction) {
            removeUsers(cart);
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
        title: Text("Cart Page"),
        backgroundColor: Colors.pink,
      ),
      drawer: SideMenu(),
      body: mainBody,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Receipt.routeName);
        },
        child: Icon(Icons.shopping_cart_sharp),
        backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
        "https://scontent.fbkk5-6.fna.fbcdn.net/v/t1.6435-1/158393181_2823294271244454_5311566327709872153_n.jpg?stp=dst-jpg_p240x240&_nc_cat=102&ccb=1-7&_nc_sid=7206a8&_nc_eui2=AeErpvhXA4uGnEi0ZHlT4jjer__oCP0DY_Cv_-gI_QNj8A7xnZRkq69hhUN565T086IdDYJEsC1lx5kg8RsSdAv5&_nc_ohc=nyKWEvewsKUAX87eVhf&_nc_ht=scontent.fbkk5-6.fna&oh=00_AfAxKxqR3_vGnUPh50ZJAi5-lr1ja6oQtdlLY4A3rhvTcw&oe=6519657B";

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
