import 'package:flutter/material.dart';
import 'package:assignment_liveintuition/Provider/auth_rovider.dart';
import 'package:assignment_liveintuition/Screens/sign_in.dart';
import 'package:provider/provider.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        Consumer<AuthProvider>(
          builder: (context, authProvider, _) {
            final buttonText = authProvider.isLoggedIn ? 'Logout' : 'Sign In';
            return TextButton(
              onPressed: () {
                if (authProvider.isLoggedIn) {
                  authProvider.logout();
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInPage()),
                  );
                }
              },
              child: Text(buttonText),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
