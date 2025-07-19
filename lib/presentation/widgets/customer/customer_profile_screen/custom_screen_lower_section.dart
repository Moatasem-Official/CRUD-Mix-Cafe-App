import 'package:flutter/material.dart';
import 'package:mix_cafe_app/presentation/widgets/customer/customer_profile_screen/custom_account_support_row_item.dart';

class CustomScreenLowerSection extends StatelessWidget {
  const CustomScreenLowerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Support',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, '/aboutMixCafeScreen'),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, top: 16, right: 8),
                    child: CustomAccountSupportRowItem(
                      title: 'About Mix Cafe',
                      backgroundColor: const Color.fromARGB(255, 225, 225, 225),
                      iconColor: const Color.fromARGB(255, 216, 165, 52),
                      textColor: Colors.black,
                      icon: Icons.info_outline_rounded,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(
                  color: Color.fromARGB(255, 227, 227, 227),
                  height: .5,
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, '/contactSupportScreen'),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: CustomAccountSupportRowItem(
                      title: 'Contact Support',
                      backgroundColor: const Color.fromARGB(255, 225, 225, 225),
                      iconColor: const Color.fromARGB(255, 216, 165, 52),
                      textColor: Colors.black,
                      icon: Icons.support_agent_rounded,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
