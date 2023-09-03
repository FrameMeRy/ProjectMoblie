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
            color: Colors.white, // ตั้งค่าสีพื้นหลังของ Container เป็นสีขาว
            child: Stack(children: [
              Positioned.fill(
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), // ปรับระดับของความจางในนี้
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
                        textHeader("Login"),
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
            ])));
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
            context, MaterialPageRoute(builder: (context) => UserForm()));
      },
    );
  }
}
