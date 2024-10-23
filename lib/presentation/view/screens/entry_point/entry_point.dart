import 'dart:math';
import 'package:flutter/material.dart';
import 'package:my_personal_project/constants.dart';
import 'package:my_personal_project/utils/rive_utils.dart';
import 'package:rive/rive.dart';
import '../../../../data/models/rive_assets/rive_assets.dart';
import '../../../components/side_menu/side_menu.dart';
import '../../../widgets/menu_btn.dart';
import '../../../components/animated_bar/animated__bar.dart';
import '../home/home_screen.dart';


class EntryPoint extends StatefulWidget {
  final String userEmail; // Field to store the user email
  final String userName;
  final String userPhotoUrl;
  const EntryPoint({super.key, required this.userEmail, required this.userName, required this.userPhotoUrl});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> with SingleTickerProviderStateMixin {
  RiveAssets selectedBottomNav = bottomNavs.first;
  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scalAnimation;

  int selectedIndex = 0; // Track the selected page index
  late SMIBool isSideBarClosed;
  bool isSideMenuClose = true;

  // List of pages corresponding to bottom navigation
  final List<Widget> pages = [
    const HomePage(),
    Container(color: Colors.white,child: const Center(child: Text('Search' , style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),),),
    Container(color: Colors.white,child: const Center(child: Text('History' , style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),),),
    Container(color: Colors.white,child: const Center(child: Text('Notifications' , style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),),),
    Container(color: Colors.white,child: const Center(child: Text('Account' , style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),),),
  ];

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
      setState(() {});
    });

    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn),
    );
    scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn),
    );

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: selectedIndex == 0
          ? buildHomePageStack() // Render Stack for HomePage (first index)
          : pages[selectedIndex], // Render other pages directly
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  /// Stack layout with animations for HomePage (first index)
  Widget buildHomePageStack() {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 200),
          curve: Curves.fastOutSlowIn,
          left: isSideMenuClose ? -295 : 0,
          height: MediaQuery.of(context).size.height,
          width: 295,
          child:  SideMenu(
            userEmail: widget.userEmail,
            userName: widget.userName,
            userPhotoUrl: widget.userPhotoUrl,

          ),
        ),
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(animation.value - 30 * animation.value * pi / 180),
          child: Transform.translate(
            offset: Offset(animation.value * 265, 0),
            child: Transform.scale(
              scale: scalAnimation.value,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: const HomePage(),
              ),
            ),
          ),
        ),
        AnimatedPositioned(
          top: 16,
          left: isSideMenuClose ? 0 : 220,
          curve: Curves.fastOutSlowIn,
          duration: const Duration(milliseconds: 200),
          child: MenuBtn(
            riveOnInit: (artboard) {
              StateMachineController controller = RiveUtils.getRiveController(
                artboard,
                stateMachine: 'State Machine',
              );
              isSideBarClosed = controller.findSMI('isOpen') as SMIBool;
              isSideBarClosed.value = true;
            },
            press: () {
              isSideBarClosed.value = !isSideBarClosed.value;
              if (isSideMenuClose) {
                _animationController.forward();
              } else {
                _animationController.reverse();
              }
              setState(() {
                isSideMenuClose = isSideBarClosed.value;
              });
            },
          ),
        ),
      ],
    );
  }

  /// Bottom Navigation Bar
  Widget buildBottomNavigationBar() {
    return Transform.translate(
      offset: Offset(0, 100 * animation.value),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          decoration: BoxDecoration(
            color: backgroundColor2.withOpacity(0.8),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              bottomNavs.length,
                  (index) => GestureDetector(
                onTap: () {
                  bottomNavs[index].input!.change(true);
                  if (bottomNavs[index] != selectedBottomNav) {
                    setState(() {
                      selectedBottomNav = bottomNavs[index];
                      selectedIndex = index; // Update selected page index
                    });
                  }
                  Future.delayed(const Duration(seconds: 1), () {
                    bottomNavs[index].input!.change(false);
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedBar(
                      isActive: bottomNavs[index] == selectedBottomNav,
                    ),
                    SizedBox(
                      height: 36,
                      width: 36,
                      child: Opacity(
                        opacity: bottomNavs[index] == selectedBottomNav ? 1 : 0.5,
                        child: RiveAnimation.asset(
                          bottomNavs.first.src,
                          artboard: bottomNavs[index].artboard,
                          onInit: (artboard) {
                            final controller = RiveUtils.getRiveController(
                              artboard,
                              stateMachine: bottomNavs[index].stateMachine,
                            );
                            bottomNavs[index].input =
                            controller.findSMI("active") as SMIBool;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
