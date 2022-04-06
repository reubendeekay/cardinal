import 'package:flutter/material.dart';
import 'package:real_estate/controllers/auth_controller.dart';
import 'package:real_estate/screens/widgets/input/input_widget.dart';
import 'package:real_estate/screens/widgets/buttons/primary_button.dart';
import 'package:real_estate/utils/validators.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  @override
  Widget build(BuildContext context) {
    Future _login() async {
      final form = formKey.currentState;
      if (form!.validate()) {
        form.save();
        await AuthController.instance.signIn(_email, _password);
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
              hintText: "Email Address",
              onChanged: (val) {
                setState(() {
                  _email = val;
                });
              },
              prefixIcon: Icons.email,
              validator: validateEmail,
            ),
            const SizedBox(height: 15.0),
            InputWidget(
              obscureText: true,
              hintText: "Password",
              onChanged: (val) {
                setState(() {
                  _password = val;
                });
              },
              prefixIcon: Icons.lock,
              validator: validatePassword,
            ),
            const SizedBox(height: 25.0),

            //LOGIN BUTTON
            PrimaryButton(
              text: "Login",
              onPressed: () {
                _login();
              },
            ),
            const SizedBox(height: 10.0),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Reset Password",
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            // Row(
            //   children: <Widget>[
            //     Expanded(child: Divider()),
            //     Padding(
            //       padding: const EdgeInsets.all(12.0),
            //       child: Text(
            //         "OR",
            //         style: TextStyle(),
            //       ),
            //     ),
            //     Expanded(child: Divider()),
            //   ],
            // ),
            // SizedBox(
            //   height: 15.0,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     GestureDetector(
            //       onTap: () {},
            //       child: Container(
            //         padding: EdgeInsets.symmetric(horizontal: 14.0),
            //         height: ScreenUtil().setHeight(53.0),
            //         width: 150.0,
            //         decoration: BoxDecoration(
            //           color: Colors.white,
            //         ),
            //         child: Row(
            //           children: [
            //             SvgPicture.asset(
            //               "assets/svg/google.svg",
            //               width: 30.0,
            //             ),
            //             SizedBox(
            //               width: 10.0,
            //             ),
            //             Text(
            //               "Google",
            //               style: TextStyle(
            //                 color: Color.fromRGBO(105, 108, 121, 1),
            //               ),
            //             )
            //           ],
            //         ),
            //       ),
            //     ),
            //     SizedBox(
            //       width: 10.0,
            //     ),
            //     GestureDetector(
            //       onTap: () {},
            //       child: Container(
            //         padding: EdgeInsets.symmetric(horizontal: 14.0),
            //         height: ScreenUtil().setHeight(53.0),
            //         width: 150.0,
            //         decoration: BoxDecoration(
            //           color: Colors.white,
            //         ),
            //         child: Row(
            //           children: [
            //             SvgPicture.asset(
            //               "assets/svg/facebook.svg",
            //               width: 30.0,
            //             ),
            //             SizedBox(
            //               width: 10.0,
            //             ),
            //             Text(
            //               "Facebook",
            //               style: TextStyle(
            //                 color: Color.fromRGBO(105, 108, 121, 1),
            //               ),
            //             )
            //           ],
            //         ),
            //       ),
            //     )
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
