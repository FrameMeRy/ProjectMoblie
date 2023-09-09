import 'package:flutter/material.dart';
import 'package:pj/srceens/home.dart';

class Successpage extends StatefulWidget {
  static const routeName = '/success';

    const Successpage({super.key});


  @override
  State<Successpage> createState() => _SuccesspageState();
}

class _SuccesspageState extends State<Successpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "ขอบคุณที่ใช้บริการ",
              style: TextStyle(fontSize: 60),
            ),
            Image.network(
              'https://cf.shopee.co.th/file/684884e2cfaa2bfa51fb45c302f2e542',
              width: 500,
              height: 200,
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        width: 200,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, Home.routeName);
          },
          child: Text(
            'Home',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
