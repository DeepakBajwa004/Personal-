
import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  final IconData leadingIcon;
  final IconData? trailingIcon;
  final String title;
  final String? subtitle;
  final Color backgroundColor;
  final VoidCallback? onTap;

  const ProfileTile({
    super.key,
    required this.leadingIcon,
    required this.title,
    this.trailingIcon,
    this.subtitle,
    this.backgroundColor = Colors.grey,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap, // Optional tap callback
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: backgroundColor.withOpacity(0.2),
        ),
        child: Icon(leadingIcon, color: Colors.blue,size: 25,),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing:  Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: backgroundColor.withOpacity(0.2),
        ),
        child:  trailingIcon != null ? Icon(trailingIcon,size: 20,) : null,
      ),
    );
  }
}
