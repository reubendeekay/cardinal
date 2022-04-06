import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:real_estate/controllers/auth_controller.dart';
import 'package:real_estate/screens/widgets/authentication/auth_tab.dart';
import 'package:real_estate/screens/widgets/authentication/login_form.dart';
import 'package:real_estate/screens/widgets/authentication/register_form.dart';
import 'package:real_estate/utils/constants.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  String active = "login";

  void setActive(String val) {
    setState(() {
      active = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: AuthController.instance.loading,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  ClipRect(
                    child: Transform.scale(
                      scale: 1.5,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.25,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/pattern.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    child: Container(
                      constraints: const BoxConstraints(minWidth: 200.0),
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.18,
                      child: const Text(
                        "Welcome back",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      color: Constants.primaryColor,
                    ),
                  )
                ],
              ),
              AuthTab(
                active: active,
                setActive: setActive,
              ),
              const SizedBox(
                height: 40.0,
              ),
              AnimatedCrossFade(
                firstChild: const LoginForm(),
                secondChild: const RegisterForm(),
                crossFadeState: active == "register"
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
