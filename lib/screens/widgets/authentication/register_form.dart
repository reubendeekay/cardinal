import 'package:flutter/material.dart';
import 'package:real_estate/controllers/auth_controller.dart';
import 'package:real_estate/screens/widgets/input/input_widget.dart';
import 'package:real_estate/screens/widgets/buttons/primary_button.dart';
import 'package:real_estate/utils/validators.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final formKey = GlobalKey<FormState>();
  late String phoneNumber;
  late String fullName;
  late String password;
  late String confirmPassword;
  late String email;
  @override
  Widget build(BuildContext context) {
    Future _register() async {
      final form = formKey.currentState;
      if (form!.validate()) {
        form.save();
        try {
          await AuthController.instance
              .createUser(fullName, email, password, phoneNumber);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.toString()),
          ));
        }
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InputWidget(
              obscureText: false,
              hintText: "Full Name",
              onChanged: (value) {
                setState(() {
                  fullName = value;
                });
              },
              validator: null,
              prefixIcon: Icons.person, //FlutterIcons.person_outline_mdi,
            ),
            const SizedBox(height: 15.0),
            InputWidget(
              obscureText: false,
              hintText: "Email Address",
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
              validator: validateEmail,
              prefixIcon: Icons.mail, //FlutterIcons.mail_ant,
            ),
            const SizedBox(height: 15.0),
            InputWidget(
                obscureText: false,
                hintText: "Phone Number",
                onChanged: (value) {
                  setState(() {
                    phoneNumber = value;
                  });
                },
                validator: validatePhoneNumber,
                prefixIcon: Icons.phone //FlutterIcons.phone_call_fea,
                ),
            const SizedBox(height: 15.0),
            InputWidget(
                obscureText: true,
                hintText: "Password",
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                validator: validatePassword,
                prefixIcon: Icons.lock //FlutterIcons.lock_ant,
                ),
            const SizedBox(height: 25.0),
            InputWidget(
                obscureText: true,
                hintText: "Confirm Password",
                onChanged: (value) {
                  setState(() {
                    confirmPassword = value;
                  });
                },
                validator: (String? value) {
                  validateConfirmPassword(password, confirmPassword);
                  return null;
                },
                prefixIcon: Icons.lock //FlutterIcons.lock_ant,
                ),
            const SizedBox(height: 25.0),
            PrimaryButton(
              text: "Register",
              onPressed: () async {
                _register();
              },
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
