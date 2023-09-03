import 'dart:convert';
import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:pj/models/configure.dart';
import '../models/users.dart';
import 'package:http/http.dart' as http;

class UserForm extends StatefulWidget {
  static const String routeName = '/newusers';
  const UserForm({super.key});
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formkey = GlobalKey<FormState>();
  // Users user = Users();
  late Users user;

  @override
  Widget build(BuildContext context) {
    try{
      user = ModalRoute.of(context)!.settings.arguments as Users;
      print(user.name);
    } catch (e){
      user = Users();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('User Form'),
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              fnameInputField(),
              emailInputField(),
              passwordInputField(),
              genderFormInput(),
              SizedBox(height: 10.0),
              submitButton(),
            ],
          ),
        ),
      ),
    );
  }

 Future<void> addNewUser(user) async{
    var url = Uri.http(Configure.server, "users");
    var resp = await http.post(url,
        headers: <String, String>{ 'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toJson()));
    var rs = usersFromJson("[${resp.body}]");

    if (rs.length == 1){
      Navigator.pop(context, "refresh");
    }
    return;
  }

  Widget fnameInputField() {
    return TextFormField(
      initialValue: user.name,
      decoration: InputDecoration(
        labelText: 'Full name',
        icon: Icon(Icons.person),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
      onSaved: (newValue) => user.name = newValue,
    );
  }

  Widget emailInputField() {
    return TextFormField(
      initialValue: user.user,
      decoration: InputDecoration(
        labelText: 'Email',
        icon: Icon(Icons.email),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
      onSaved: (newValue) => user.user = newValue,
    );
  }

  Widget passwordInputField() {
    return TextFormField(
      initialValue: user.password,
      obscureText: true,
      decoration:
          InputDecoration(labelText: 'Password', icon: Icon(Icons.lock)),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
      onSaved: (newValue) => user.password = newValue,
    );
  }

  Widget genderFormInput() {
    var initGen = "None";
    try{
      if (!user.gender!.isNull){
        initGen = user.gender!;
      }
       }catch(e){
        initGen = "None";
    }
    return DropdownButtonFormField(
      decoration:
          InputDecoration(labelText: "Gender:", icon: Icon(Icons.person)),
      value: initGen,
      items: Configure.gender.map((String val) {
        return DropdownMenuItem(
          value: val,
          child: Text(val),
        );
      }).toList(),
      onChanged: (value) {
        user.gender = value;
      },
      onSaved: (newValue) => user.gender,
    );
  }
  Future<void> updateData(user) async{
    var url = Uri.http(Configure.server, "users/${user.id}");
    var resp = await http.put(url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(user.toJson()));
    var rs = usersFromJson("[${resp.body}]");
    if (rs.length == 1){
      Navigator.pop(context, "refresh");
    }
  }

  Widget submitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formkey.currentState!.validate()) {
          _formkey.currentState!.save();
          print(user.toJson().toString());
          addNewUser(user);
          if (user.id == null){
            addNewUser(user);
          } else{
            updateData(user);
          }
        }
      },
      child: Text('Submit'),
    );
  }
}