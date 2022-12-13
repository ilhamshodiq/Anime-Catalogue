import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:mobile_prak_uas_anime_catalogue/models/model_user.dart';
import 'package:mobile_prak_uas_anime_catalogue/views/homescreen.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPass = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  User? model;

  void login(String email, password) async {
    try {
      var response = await Dio().get('http://10.0.2.2:3000/users');

      var panjang_data = response.data.length;
      if (response.statusCode == 200) {
        for (var i = 0; i <= panjang_data; i++) {
          if (email == response.data[i]['email'] &&
              password == response.data[i]['password']) {
            print("Login success");
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreenPage(
                          nama: response.data[i]['name'],
                        )));
            break;
          }
        }
      } else {
        final snackBar = const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            'Login failed',
            style: TextStyle(
              fontFamily: 'Poppins-Regular',
              color: Colors.white,
            ),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      final snackBar = SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text(
          e.toString(),
          style: const TextStyle(
            fontFamily: 'Poppins-Regular',
            color: Colors.white,
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 60),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Irasshaimase!",
                  style: TextStyle(
                    fontSize: 40,
                    color: Color.fromRGBO(129, 59, 231, 1),
                  ),
                ),
                const SizedBox(height: 4),
                const Text("Login to your account..",
                    style: TextStyle(
                      color: Color.fromRGBO(129, 59, 231, 1),
                      fontSize: 16,
                    )),
                const SizedBox(height: 25),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "* Required";
                    } else
                      return null;
                  },
                  controller: controllerEmail,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  decoration: const InputDecoration(
                    labelText: "Email Address",
                    hintText: "Email Address",
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                    hintStyle: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "* Required";
                    } else
                      return null;
                  },
                  obscureText: true,
                  controller: controllerPass,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  decoration: const InputDecoration(
                    labelText: "Password",
                    hintText: "Password",
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                    hintStyle: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Forgot password?",
                    style: TextStyle(
                      color: Color.fromRGBO(129, 59, 231, 1),
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                    login(controllerEmail.text, controllerPass.text);
                  },
                  child: const Text("SIGN IN",
                      style: TextStyle(
                        fontFamily: 'Poppins SemiBold',
                        fontSize: 18,
                      )),
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(129, 59, 231, 1),
                      minimumSize: const Size.fromHeight(55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(129, 59, 231, 1),
                        )),
                    const SizedBox(width: 7),
                    GestureDetector(
                      onTap: () {},
                      child: const Text("Sign up",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(129, 59, 231, 1),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
