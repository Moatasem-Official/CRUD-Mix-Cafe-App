import 'package:flutter/material.dart';
import 'package:mix_cafe_app/data/model/product_model.dart';
import '../../../constants/app_assets.dart';
import '../../widgets/customer/customer_show_product_details/custom_back_botton.dart';
import '../../widgets/customer/customer_show_product_details/custom_bottom_button.dart';
import '../../widgets/customer/customer_show_product_details/custom_product_details_container.dart';

class CustomerShowProductScreen extends StatelessWidget {
  const CustomerShowProductScreen({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomButton(),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              FadeInImage.assetNetwork(
                placeholder: 'assets/animations/Animation - 1751639954708.gif',
                width: double.infinity,
                height: 280,
                fit: BoxFit.cover,
                image: productModel.imageUrl,
              ),
              Positioned(top: 40, left: 16, child: CustomBackBotton()),
            ],
          ),
          Expanded(
            child: Transform.translate(
              offset: const Offset(0, -24),
              child: CustomProductDetailsContainer(product: productModel),
            ),
          ),
        ],
      ),
    );
  }
}
