import 'package:flutter/material.dart';
import 'package:mix_cafe_app/data/model/product_model.dart';

class CustomTitleOfPopularItems extends StatelessWidget {
  const CustomTitleOfPopularItems({super.key, required this.items});

  final List<ProductModel> items;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Best Seller Items',
              style: TextStyle(
                color: Color.fromARGB(255, 165, 101, 56),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        items.length > 4
            ? FittedBox(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        overlayColor: Colors.transparent,
                      ),
                      onPressed: () => Navigator.of(context).pushNamed(
                        '/customerSeeAllProductsScreen',
                        arguments: items,
                      ),
                      child: Row(
                        spacing: 5,
                        children: [
                          const Text(
                            'View All',
                            style: TextStyle(
                              color: Color.fromARGB(255, 175, 134, 105),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                            color: Color(0xFF6F4E37),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
