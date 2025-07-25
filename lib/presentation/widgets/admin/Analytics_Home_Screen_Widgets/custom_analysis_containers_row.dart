import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'custom_analysis_container.dart';

class CustomAnalysisContainersRow extends StatelessWidget {
  const CustomAnalysisContainersRow({
    super.key,
    required this.ordersNumber,
    required this.salesNumber,
    required this.usersNumber,
  });

  final String ordersNumber;
  final String salesNumber;
  final String usersNumber;

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
            analysisNumber: formatLargeNumber(ordersNumber),
            title: 'Orders',
          ),
          CustomAnalysisContainer(
            icon: FontAwesomeIcons.chartBar,
            analysisNumber: '${formatLargeNumber(salesNumber)} \$',
            title: 'Sales',
          ),
          CustomAnalysisContainer(
            icon: FontAwesomeIcons.users,
            analysisNumber: formatLargeNumber(usersNumber),
            title: 'Users',
          ),
        ],
      ),
    );
  }

  String formatLargeNumber(String numberString) {
    try {
      double number = double.parse(numberString.replaceAll(' \$', ''));
      if (number >= 1000000) {
        return '${(number / 1000000).toStringAsFixed(1)}M';
      } else if (number >= 1000) {
        return '${(number / 1000).toStringAsFixed(1)}k';
      } else {
        return number.toStringAsFixed(0);
      }
    } catch (e) {
      return numberString; // Return original string if parsing fails
    }
  }
}
