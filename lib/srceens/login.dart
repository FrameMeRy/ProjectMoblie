import 'package:http/http.dart' as http;
import 'package:pj/models/configure.dart';
import 'package:flutter/material.dart';
import 'package:pj/models/users.dart';
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
          fontSize: 50.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textHeader("Login"),
                emailInputField(),
                passwordInputField(),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    submitButton(),
                    SizedBox(
                      width: 10.0,
                    ),
                    backButton(),
                    SizedBox(
                      width: 10.0,
                    ),
                    registerlink()
                  ],
                ),
              ],
            )),
      ),
    );
  }

  Widget fnameInputField() {
    return TextFormField(
      initialValue: "Ratchanon Chukiattakerng",
      decoration:
          InputDecoration(
            labelText: "Fullname", 
            icon: Icon(Icons.person)),
      validator: (value){
        if (value!.isEmpty){
          return "This field is required";
        }
        return null;
      },
    );
  }

  Widget emailInputField() {
    return TextFormField(
      initialValue: "",
      decoration: InputDecoration(labelText: "Email", icon: Icon(Icons.email)),
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
      initialValue: "",
      obscureText: true,
      decoration:
          InputDecoration(labelText: "Password", icon: Icon(Icons.lock)),
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
      child: Text("login"),
    );
  }

  Widget backButton() {
    return ElevatedButton(
      onPressed: () {
         Navigator.pushNamed(context, Home.routeName);
      },
      child: Text("back"),
    );
  }

 

  Widget registerlink() {
    return InkWell(
      child: const Text("Sigh Up"),
      onTap: () {
         Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserForm()));
      },
    );
  }
}




