
import 'package:ev_homes_customer/component/emi_calculator.dart';
import 'package:ev_homes_customer/core/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class WhatsNewCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  const WhatsNewCard({
    super.key,
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EmiCalculator(),
            ),
          );
        },
        child: Container(
          width: 180,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imageUrl,
                  height: 220,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                child: Text(
                  title,
                  style: ThemeTexts.subtitle2,
                ),
              ),
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 4, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'View Now',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Manrope',
                        color: Colors.black54,
                      ),
                    ),
                    Icon(
                      FluentIcons.chevron_right_24_regular,
                      color: Colors.black54,
                      size: 15,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
