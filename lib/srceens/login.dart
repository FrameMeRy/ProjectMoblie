import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import '../models/configure.dart';
import '../models/users.dart';
import 'home.dart';
import 'add_user.dart';
import 'package:email_validator/email_validator.dart';

class Login extends StatefulWidget {
  static const routeName = "/login";
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  Users user = Users();

  Future<void> login(Users user) async {
    var params = {"email": user.name, "password": user.password};
    var url = Uri.http(Configure.server, "users", params);
    var resp = await http.get(url);
    print(resp.body);

    List<Users> login_result = usersFromJson(resp.body);
    print(login_result.length);
    if (login_result.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Username  or Password invalid")));
    } else {
      Configure.login = login_result[0];
      Navigator.pushNamed(context, Home.routeName);
    }
    return;
  }

  Widget textHeader(String headerText) {
    return Center(
      child: Text(
        headerText,
        style: TextStyle(
          fontSize: 35.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textHeader(
            "Login"), // Set the app bar title using your textHeader widget
        backgroundColor: Colors.pink, // Set the background color of the app bar
      ),
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Positioned.fill(
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5),
                  BlendMode.dstATop,
                ),
                child: Image.network(
                  "https://wallpapercave.com/wp/wp3359189.jpg?fbclid=IwAR1vQ6KDiq12SlGrd_Vpn8EhzZqLnDoMieI35cBfQZ7j6rrRFl8e4d7MX0Q",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100.0,
                    ),
                    emailInputField(),
                    SizedBox(
                      height: 20.0,
                    ),
                    passwordInputField(),
                    SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Center the buttons horizontally
                      children: [
                        submitButton(),
                        SizedBox(
                          width: 10.0,
                        ),
                        registerlink(),
                        SizedBox(
                          width: 10.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget fnameInputField() {
    return TextFormField(
      initialValue: "Ratchanon Chukiattakerng",
      decoration:
          InputDecoration(labelText: "Fullname", icon: Icon(Icons.person)),
      validator: (value) {
        if (value!.isEmpty) {
          return "This field is required";
        }
        return null;
      },
    );
  }

  Widget emailInputField() {
    return TextFormField(
      initialValue: "a@gmail.com",
      decoration: InputDecoration(
          labelText: "Email",
          icon: Icon(Icons.email, color: Colors.white),
          filled: true,
          fillColor: Colors.white),
      validator: (value) {
        if (value!.isEmpty) {
          return "this field is required";
        }
        if (!EmailValidator.validate(value)) {
          return "It isn't email format";
        }
        return null;
      },
      onSaved: (newValue) => user.name = newValue,
    );
  }

  Widget passwordInputField() {
    return TextFormField(
      initialValue: "1q2w3e4r",
      obscureText: true,
      decoration: InputDecoration(
          labelText: "Password",
          icon: Icon(Icons.lock, color: Colors.white),
          filled: true,
          fillColor: Colors.white),
      validator: (value) {
        if (value!.isEmpty) {
          return "this field is required";
        }
        return null;
      },
      onSaved: (newValue) => user.password = newValue,
    );
  }

  Widget submitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formkey.currentState!.validate()) {
          _formkey.currentState!.save();
          print(user.toJson().toString());
          login(user);
        }
      },
      child: Text("Login"),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.pink),
      ),
    );
  }

  Widget backButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, Home.routeName);
      },
      child: Text("Back"),
    );
  }

  Widget registerlink() {
    return ElevatedButton(
      child: const Text("Sign Up"),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserForm()),
        );
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
            Colors.pink), // Change the button color to pink
      ),
    );
  }
}
