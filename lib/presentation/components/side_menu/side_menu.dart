import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_personal_project/presentation/view/side_menu_screens/about_us_screen/about_us_screen.dart';
import 'package:my_personal_project/presentation/view/side_menu_screens/favorites_screen/favorites_screen.dart';
import 'package:my_personal_project/presentation/view/side_menu_screens/help_screen/help_screen.dart';
import 'package:my_personal_project/presentation/view/side_menu_screens/history_screen/history_screen.dart';
import 'package:my_personal_project/presentation/view/side_menu_screens/notification_screen/notification_screen.dart';
import 'package:rive/rive.dart';
import '../../../data/controller/auth_controlller/user_controller/user_controller.dart';
import '../../view/side_menu_screens/settings_screen/settings_screen.dart';
import '../../view/side_menu_screens/user_profile/profile_screen.dart';
import 'info_card.dart';
import '../../../data/models/rive_assets/rive_assets.dart';
import 'package:my_personal_project/utils/rive_utils.dart';
import 'side_menu_ttile.dart';

class SideMenu extends StatefulWidget {
  final String userEmail;
  final String userName;
  final String userPhotoUrl;

  const SideMenu({
    super.key,
    required this.userEmail,
    required this.userName,
    required this.userPhotoUrl,
  });

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final UserController _userController = Get.find<UserController>();
  RiveAssets selectedMenu = sideMenus.first;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 30),
      child: Container(
        width: 295,
        height: screenHeight, // Adjust size based on height
        color: const Color(0xFF17203A),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoCard(
              name: widget.userName,
              email: widget.userEmail,
              photoUrl: widget.userPhotoUrl,
            ),
            // Scrollable content section
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle(context, 'Browse'),
                    ..._buildMenuTiles(sideMenus),
                    const SizedBox(height: 16),

                    _buildSectionTitle(context, 'History'),
                    ..._buildMenuTiles(sideMenus2),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10,),
            ..._buildMenuTiles(sideMenus3),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, top:15.0, bottom: 16.0),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
          color: Colors.white70,
        ),
      ),
    );
  }

  List<Widget> _buildMenuTiles(List<RiveAssets> menus) {
    return menus.map((menu) {
      return SideMenuTile(
        menu: menu,
        press: () async {
          _activateMenu(menu);

          // Navigate based on the menu title
          switch (menu.title.trim()) {

            case 'Profile':
              await Future.delayed(const Duration(milliseconds: 300));
              Get.to(()=>  ProfileScreen(
                userEmail: widget.userEmail,
                userName: widget.userName,
                userPhotoUrl: widget.userPhotoUrl,
              ));
              break;

            case 'Settings':
              await Future.delayed(const Duration(milliseconds: 300));
              Get.to(()=> const SettingsScreen());
              break;

            case 'Favorites':
              await Future.delayed(const Duration(milliseconds: 300));
              Get.to(()=> const FavoritesScreen());
              break;

            case 'About Us':
              await Future.delayed(const Duration(milliseconds: 300));
              Get.to(()=> const AboutUsScreen());
              break;

            case 'Help':
              await Future.delayed(const Duration(milliseconds: 300));
              Get.to(()=> const HelpScreen());
              break;

            case 'Transaction History':
              await Future.delayed(const Duration(milliseconds: 300));
              Get.to(()=> const HistoryScreen());
              break;

            case 'Notification':
              await Future.delayed(const Duration(milliseconds: 300));
              Get.to(()=> const NotificationScreen());
              break;

            case 'Logout':
              await Future.delayed(const Duration(milliseconds: 300));
              _userController.showLogoutDialog(context);
              break;

            default:
              Get.snackbar('Coming Soon', 'This feature is not yet available.');
          }
        },
        riveOnInit: (artboard) {
          final controller = RiveUtils.getRiveController(
            artboard,
            stateMachine: menu.stateMachine,
          );
          menu.input = controller.findSMI('active') as SMIBool;
        },
        isActive: selectedMenu == menu,
      );
    }).toList();
  }

  void _activateMenu(RiveAssets menu) {
    setState(() {
      selectedMenu = menu;
    });

    menu.input?.change(true);
    Future.delayed(const Duration(seconds: 2), () {
      menu.input?.change(false);
    });
  }
}
