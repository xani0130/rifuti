import 'package:flutter/material.dart';
import 'package:go_pool/language/languageCubit.dart';
import 'package:go_pool/screens/auth/login/login.dart';
import 'package:go_pool/screens/auth/login/login_page.dart';
import 'package:go_pool/screens/home/home/home.dart';
import 'package:go_pool/theme/colors.dart';

class YesNoPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shadowColor: Colors.white,
      title: Text(
        'Confirmation',
        style: TextStyle(
          color: primaryColor,
        ),
      ),
      content: Text(
        'Do you want to go to the home page?',
        style: TextStyle(
          color: primaryColor,
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => LoginPage())); // Close the dialog
            // Navigate to the home page or perform any action on "Yes"
            // Add your navigation logic here
          },
          child: Text(
            'Yes',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
            // Stay on the current screen or perform any action on "No"
            // Add your logic for staying on the current screen
          },
          child: Text(
            'No',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
