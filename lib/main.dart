import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/bindings/all_bindings.dart';
import 'package:real_estate/firebase_options.dart';
import 'package:real_estate/providers/location_provider.dart';
import 'package:real_estate/providers/property_provider.dart';
import 'package:real_estate/utils/constants.dart';
import 'package:real_estate/utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Container(
        color: Constants.primaryColor,
        child: Center(
            child: SizedBox(
          height: 400,
          child: Lottie.asset(
            'assets/squid.json',
          ),
        )));
  };
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const RealEstateApp());
}

class RealEstateApp extends StatelessWidget {
  const RealEstateApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PropertyProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: () => (GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialBinding: AllControllerBinding(),

          title: 'Real Estate App',
          theme: ThemeData(
            primaryColor: Constants.primaryColor,
            scaffoldBackgroundColor: const Color.fromRGBO(247, 249, 255, 1),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: GoogleFonts.poppinsTextTheme(),
          ),
          // initialRoute:  "/authentication",
          onGenerateRoute: onGenerateRoute,
        )),
      ),
    );
  }
}
