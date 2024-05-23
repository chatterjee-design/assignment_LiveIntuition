import 'package:assignment_liveintuition/Provider/auth_rovider.dart';
import 'package:assignment_liveintuition/Screens/quotes.dart';
import 'package:assignment_liveintuition/Screens/sign_up.dart';
import 'package:assignment_liveintuition/Ui_elements/custome_button.dart';
import 'package:assignment_liveintuition/layout/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    print(authProvider.isLoggedIn);
    return Scaffold(
      appBar: CustomAppbar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Image.asset(
                  'assets/girl-with-phone.png',
                  width: 400,
                  height: 400,
                  fit: BoxFit.cover,
                ),
              ),
              const Text(
                'Welcome Buddies!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 5.0,
                ),
              ),
            ],
          ),
          CustomButton(
            text: authProvider.isLoggedIn? "Call Api" :'Sign Up',
            onPressed: () {

              Navigator.push(
                context,
                authProvider.isLoggedIn?
                MaterialPageRoute(builder: (context) => QuotePage()):
                MaterialPageRoute(builder: (context) => SignupPage()),
              );
              // print('Button Pressed');
            },
          ),
        ],
      ),
    );
  }
}
