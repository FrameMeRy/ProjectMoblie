import 'package:flutter/material.dart';
import 'package:pj/models/users.dart';

class UserInfo extends StatelessWidget {

  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    
    Users user = ModalRoute.of(context)!.settings.arguments as Users;
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Info"),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Card(
          child: ListView(
            children: [
             ListTile(title: Text("Full name"),subtitle: Text("${user.name}"),),
             ListTile(title: Text("Email"),subtitle: Text("${user.email}"),),
             ListTile(title: Text("Account number"),subtitle: Text("${user.accnumber}"),),
             ListTile(title: Text("Address"),subtitle: Text("${user.address}"),),
             ListTile(title: Text("Gender"),subtitle: Text("${user.gender}"),),
            ],
          ),
        ),
      ),
    );
  }
}