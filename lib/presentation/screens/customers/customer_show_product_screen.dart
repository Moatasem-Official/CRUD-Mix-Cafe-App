import 'package:flutter/material.dart';
import '../../../constants/app_assets.dart';
import '../../widgets/customer/customer_show_product_details/custom_back_botton.dart';
import '../../widgets/customer/customer_show_product_details/custom_bottom_button.dart';
import '../../widgets/customer/customer_show_product_details/custom_product_details_container.dart';

class CustomerShowProductScreen extends StatelessWidget {
  const CustomerShowProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomButton(),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                Assets.mixCafeCustomerFoodImage,
                height: 280,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(top: 40, left: 16, child: CustomBackBotton()),
            ],
          ),
          Expanded(
            child: Transform.translate(
              offset: const Offset(0, -24),
              child: CustomProductDetailsContainer(),
            ),
          ),
        ],
      ),
    );
  }
}
