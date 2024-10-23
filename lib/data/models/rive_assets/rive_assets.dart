
import 'package:rive/rive.dart';

class RiveAssets {
  final String artboard , stateMachine , title , src ;
  late SMIBool? input;

  RiveAssets(this.src, {required this.artboard, required this.stateMachine, required this.title, this.input});
  set setInput (SMIBool status) {
    input =  status;
  }
}

List<RiveAssets>  bottomNavs = [
  RiveAssets('assets/RiveAssets/icons.riv', artboard: 'HOME', stateMachine: 'HOME_interactivity', title: 'Home'),
  RiveAssets('assets/RiveAssets/icons.riv', artboard: 'SEARCH', stateMachine: 'SEARCH_Interactivity', title: 'Search'),
  RiveAssets('assets/RiveAssets/icons.riv', artboard: 'TIMER', stateMachine: 'TIMER_Interactivity', title: 'History'),
  RiveAssets('assets/RiveAssets/icons.riv', artboard: 'BELL', stateMachine: 'BELL_Interactivity', title: 'Notification'),
  RiveAssets('assets/RiveAssets/icons.riv', artboard: 'USER', stateMachine: 'USER_Interactivity', title: 'Profile'),
];


List<RiveAssets>  sideMenus = [
  RiveAssets('assets/RiveAssets/icons.riv', artboard: 'USER', stateMachine: 'USER_Interactivity', title: 'Profile'),
  RiveAssets('assets/RiveAssets/icons.riv', artboard: 'SETTINGS', stateMachine: 'SETTINGS_Interactivity', title: 'Settings'),
  RiveAssets('assets/RiveAssets/icons.riv', artboard: 'LIKE/STAR', stateMachine: 'STAR_Interactivity', title: 'Favorites'),
  RiveAssets('assets/RiveAssets/icons.riv', artboard: 'HOME', stateMachine: 'HOME_interactivity', title: 'About Us'),
  RiveAssets('assets/RiveAssets/icons.riv', artboard: 'CHAT', stateMachine: 'CHAT_Interactivity', title: 'Help'),
];

List<RiveAssets>  sideMenus2 = [
  RiveAssets('assets/RiveAssets/icons.riv', artboard: 'TIMER', stateMachine: 'TIMER_Interactivity', title: 'History'),
  RiveAssets('assets/RiveAssets/icons.riv', artboard: 'BELL', stateMachine: 'BELL_Interactivity', title: 'Notification'),
];


List<RiveAssets>  sideMenus3 = [
  RiveAssets('assets/RiveAssets/icons.riv', artboard: 'USER', stateMachine: 'USER_Interactivity', title: 'Logout '),
];