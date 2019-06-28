import 'package:flutter/material.dart';

class ThickDivider extends StatelessWidget implements PreferredSizeWidget {
  const ThickDivider();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).accentColor.withOpacity(.3);

    return Container(
      alignment: Alignment.center,
      child: Container(
        height: 2,
        color: color,
      ),
      height: 16,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(16);
}
