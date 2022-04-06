import 'package:flutter/material.dart';
import 'package:real_estate/screens/widgets/buttons/primary_button.dart';
import 'package:real_estate/utils/constants.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      alignment: Alignment(0, -0.9),
                      image: AssetImage(
                        "assets/images/welcome.png",
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 25.0,
                      ),
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: "Discover\n",
                              style: TextStyle(
                                fontSize: 28.0,
                                fontWeight: FontWeight.w800,
                                color: Constants.blackColor,
                              ),
                            ),
                            TextSpan(
                              text: "the best property.",
                              style: TextStyle(
                                fontSize: 28.0,
                                height: 1.3,
                                color: Constants.blackColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const Text(
                        "Find the best property you want by your location or neighbourhood",
                        style: TextStyle(
                          height: 1.70,
                          color: Color.fromRGBO(110, 121, 136, 1),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      PrimaryButton(
                        text: "Get Started",
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
