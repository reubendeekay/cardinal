import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/controllers/user_controller.dart';
import 'package:real_estate/models/users.dart';
import 'package:real_estate/screens/add_property.dart';
import 'package:real_estate/screens/authentication/authentication.dart';
import 'package:real_estate/screens/user_profile.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel user = UserController.instance.user;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top + 20),
          const Text(
            'Settings',
            style: TextStyle(
                color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          settingTile(
            title: 'Account',
            onTap: () => Get.to(() => const UserProfile(
                  isFromDrawer: false,
                )),
            icon: Icons.person_outline,
          ),
          settingTile(
            title: 'Saved Game IDs',
            // onTap: () => Get.to(() => const SavedGameIds()),
            icon: Icons.gamepad_outlined,
          ),
          // settingTile(
          //   title: 'Favourite Games',
          //   icon: Icons.favorite_border,
          //   onTap: () => Get.to(() => const FavouritesScreen()),
          // ),
          // settingTile(
          //   title: 'Blocked Accounts',
          //   icon: Icons.block,
          // ),
          // if (user.isAdmin!)
          settingTile(
            title: 'Add Property',
            icon: Icons.security,
            onTap: () => Get.to(() => const AddPropertyScreen()),
          ),
          // settingTile(
          //   title: 'Privacy Policy',
          //   icon: Icons.lock_outline,
          // ),
          settingTile(
            title: 'Terms of Service',
            icon: Icons.lock_open,
            // onTap: () => Get.to(() => MyPdfViewer())
          ),
          settingTile(
            title: 'Community Guidelines',
            icon: Icons.drag_indicator_outlined,
            // onTap: () => Get.to(() => MyPdfViewer())
          ),

          settingTile(
              title: 'Support',
              icon: Icons.help_outline,
              onTap: () {
                String? encodeQueryParameters(Map<String, String> params) {
                  return params.entries
                      .map((e) =>
                          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                      .join('&');
                }

                final Uri emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: 'funchill42@gmail.com',
                  query: encodeQueryParameters(<String, String>{
                    'subject': 'FUNCHILL Support Query',
                  }),
                );
                launch(emailLaunchUri.toString());
              }),
          settingTile(
              title: 'Logout',
              icon: Icons.exit_to_app,
              onTap: () async {
                Get.off(() => const Authentication());
                await FirebaseAuth.instance.signOut();
              }),
          const SizedBox(height: 60),
        ],
      ),
    );
  }

  Widget settingTile({
    String? title,
    IconData? icon,
    Function? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      child: GestureDetector(
        onTap: () => onTap!(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Row(
            children: [
              Icon(
                icon ?? Icons.settings,
                size: 22,
              ),
              const SizedBox(width: 10),
              Text(
                title ?? 'Settings',
                style: const TextStyle(fontSize: 15, color: Colors.white),
              ),
              const Spacer(),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
