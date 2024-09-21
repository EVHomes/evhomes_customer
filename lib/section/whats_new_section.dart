
import 'package:ev_homes_customer/component/whats%20_new_card.dart';
import 'package:ev_homes_customer/core/theme_colors.dart';
import 'package:flutter/material.dart';

class WhatsNewSection extends StatelessWidget {
  const WhatsNewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
        child: Text(
          'Additional features',
          style: ThemeTexts.title3,
        ),
      ),
      const SizedBox(height: 10),
      Container(
        margin: const EdgeInsets.all(15),
        height: 271,
        child: const WhatsNewCard(
          imageUrl: 'assets/images/emi.jpg',
          title: 'Emi calculator',
        ),
      ),
    ]);
  }
}
