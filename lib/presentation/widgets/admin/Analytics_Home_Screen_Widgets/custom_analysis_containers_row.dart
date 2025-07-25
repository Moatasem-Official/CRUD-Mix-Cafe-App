import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'custom_analysis_container.dart';

class CustomAnalysisContainersRow extends StatelessWidget {
  const CustomAnalysisContainersRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
      child: Row(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomAnalysisContainer(
            icon: FontAwesomeIcons.cartShopping,
            index: 0,
            title: 'Orders',
          ),
          CustomAnalysisContainer(
            icon: FontAwesomeIcons.chartBar,
            index: 1,
            title: 'Sales',
          ),
          CustomAnalysisContainer(
            icon: FontAwesomeIcons.users,
            index: 2,
            title: 'Users',
          ),
        ],
      ),
    );
  }
}
