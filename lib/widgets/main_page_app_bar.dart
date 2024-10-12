import 'package:flutter/material.dart';

class MainPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onHeartPressed;
  final VoidCallback onBellPressed;
  final String title;

  const MainPageAppBar({
    super.key,
    required this.title,
    required this.onHeartPressed,
    required this.onBellPressed,
  });

  final iconSize = 30.0;
  final iconColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
      actions: [
        InkWell(
          onTap: onBellPressed,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.notifications, size: iconSize, color: iconColor),
          ),
        ),
      ],
      leading: InkWell(
        onTap: onHeartPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.favorite, size: iconSize, color: iconColor),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
