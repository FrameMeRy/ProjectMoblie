import 'package:flutter/material.dart';
import 'home.dart';

class Login extends StatefulWidget {
  static const routeName = '/login';

  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
        color: Colors.white,
        child: Stack(
          children: [
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
                      height: 50.0,
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
      initialValue: "",
      decoration: InputDecoration(
        labelText: "Email",
        icon: Icon(Icons.email, color: Colors.white),
        filled: true, // เปิดใช้งานการเติมสีพื้นหลัง
        fillColor: Colors.white, // ตั้งค่าสีพื้นหลังเป็นสีขาว
      ),
    );
  }

  Widget passwordInputField() {
    return TextFormField(
      initialValue: "",
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        icon: Icon(Icons.lock, color: Colors.white),
        filled: true, // เปิดใช้งานการเติมสีพื้นหลัง
        fillColor: Colors.white, // ตั้งค่าสีพื้นหลังเป็นสีขาว
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "this field is required";
        }
        return null;
      },
    );
  }

  Widget submitButton() {
    return ElevatedButton(
      onPressed: () {},
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
      onTap: () {},
    );
  }
}
