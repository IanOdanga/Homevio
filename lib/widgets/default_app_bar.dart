import 'package:flutter/material.dart';
import 'package:homevio/constants.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String? title;
  final Widget? child;
  final action;
  const DefaultAppBar({
    Key? key, this.title, this.child, this.action,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title!, style: const TextStyle(color: Constants.kPrimaryColor)),
      centerTitle: true,
      backgroundColor: Constants.kPrimaryLightColor,
      elevation: Constants.kRadius,
      automaticallyImplyLeading: false,
      iconTheme: const IconThemeData(color: Constants.kPrimaryColor),
      leading: child,
      actions: action,
    );
  }
}