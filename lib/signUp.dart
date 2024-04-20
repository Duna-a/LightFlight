import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/FlightBookingHomePage.dart';
import 'package:flutter_application_1/resources/auth_method.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // GlobalKey for Form

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _cardNumberController.dispose();
    super.dispose();
  }

  void registerUser() async {
    if (_formKey.currentState!.validate()) {
      // Validates the form
      String resp = await AuthMethods().registerUser(
        email: _emailController.text,
        name: _nameController.text,
        password: _passwordController.text,
        cardInfo: _cardNumberController.text,
      );
      if (resp == 'success') {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => FlightBookingHomePage.noParams()),
        );
      } else {
        // Handle registration failure
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registration Failed: $resp')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF3F9FB),
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Color(0xFF1BAEC6),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text("Sign Up",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    SizedBox(height: 20),
                    Text("Sign up to your account",
                        style:
                            TextStyle(fontSize: 15, color: Colors.grey[700])),
                  ],
                ),
                Column(
                  children: <Widget>[
                    inputFile(label: "Name:", controller: _nameController),
                    inputFile(
                        label: "Email:",
                        controller: _emailController,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        }),
                    inputFile(
                        label: "Password:",
                        obsecureText: true,
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        }),
                    inputFile(
                        label: "Card Number:",
                        controller: _cardNumberController),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 30, left: 3),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: registerUser,
                    color: Color.fromARGB(255, 104, 204, 220),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: Text("Sign Up",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Already have an account?",
                        style: TextStyle(color: Colors.black)),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed('/login');
                      },
                      child: Text(" Log in",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Color(0xFF1BAEC6))),
                    ),
                  ],
                ),
                SizedBox(height: 100)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget inputFile(
      {required String label,
      bool obsecureText = false,
      required TextEditingController controller,
      String? Function(String?)? validator}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.black87)),
        SizedBox(height: 5),
        TextFormField(
          controller: controller,
          obscureText: obsecureText,
          validator: validator,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
