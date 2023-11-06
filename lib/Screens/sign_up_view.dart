import 'package:firebase_project_flutter/custom%20widgets/textfield.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});

  var focusNode = FocusNode();

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: ListView(
      children: [
        const Text(
          "Welcome to Sign Up View",
          textScaleFactor: 1.2,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              decorationStyle: TextDecorationStyle.dotted),
        ),
        const SizedBox(
          height: 20,
        ),
        TextField_widget(
          text: "Username",
          controller: nameController,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          focusNode: focusNode,

        )
      ],
    )));
  }
}
