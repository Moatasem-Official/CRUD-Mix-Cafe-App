import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Analytics_Home_Screen_Widgets/custom_analysis_container.dart';

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
            analysisNumber: '1,000',
            title: 'Orders',
          ),
          CustomAnalysisContainer(
            icon: FontAwesomeIcons.chartBar,
            analysisNumber: '1,000 \$',
            title: 'Sales',
          ),
          CustomAnalysisContainer(
            icon: FontAwesomeIcons.users,
            analysisNumber: '1,000',
            title: 'Users',
          ),
        ],
      ),
    );
  }
}
