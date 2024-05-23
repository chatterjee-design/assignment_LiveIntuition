import 'package:assignment_liveintuition/Provider/auth_rovider.dart';
import 'package:assignment_liveintuition/Screens/homepage.dart';
import 'package:assignment_liveintuition/Ui_elements/custome_button.dart';
import 'package:assignment_liveintuition/layout/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SignupForm(),
      ),
    );
  }
}

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, _) => authProvider.isLoading
            ? CircularProgressIndicator()
            : Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "SIGN UP",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 10.0,
                ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                ),
                obscureText: true,
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an accout?",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: 5,),
                  Text(
                    "Sign in",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 60),
              CustomButton(
                text: "Save",
                onPressed: () async {
                  await authProvider.register(
                    _emailController.text.trim(),
                    _passwordController.text.trim(),
                  );
                  if (authProvider.isLoggedIn) {
                    print(authProvider.isLoggedIn);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
