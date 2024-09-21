
import 'package:ev_homes_customer/core/constant.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class CustomAppBar extends StatelessWidget {
  final VoidCallback onSearchPressed;
  final VoidCallback onProfilePressed;

  const CustomAppBar({
    required this.onSearchPressed,
    required this.onProfilePressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 0, 0),
          child: Image.asset(
            Constant.logoIcon,
            height: 40,
          ),
        ),
        Row(
          children: [
            IconButton(
              padding: const EdgeInsetsDirectional.fromSTEB(30, 50, 20, 30),
              style: IconButton.styleFrom(
                shape: const CircleBorder(),
              ),
              onPressed: onSearchPressed,
              icon: const Icon(FluentIcons.search_24_regular),
            ),
            IconButton(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 20, 30),
              onPressed: onProfilePressed,
              icon: const Icon(FluentIcons.person_24_regular),
            ),
          ],
        ),
      ],
    );
  }
}
