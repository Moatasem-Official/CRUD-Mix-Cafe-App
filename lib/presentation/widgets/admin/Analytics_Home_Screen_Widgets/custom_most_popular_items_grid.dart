import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mix_cafe_app/bussines_logic/cubits/customer/home_screen/cubit/home_screen_cubit.dart';
import 'package:mix_cafe_app/data/model/product_model.dart';
import 'most_popular_items_card/custom_most_popular_items_card.dart';
import 'dart:math';

class CustomMostPopularItemsGrid extends StatelessWidget {
  const CustomMostPopularItemsGrid({super.key, required this.items});

  final List<ProductModel> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Wrap(
        runSpacing: 10,
        children: List.generate(
          min(4, items.length),
          (index) => SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Padding(
              padding: EdgeInsets.only(
                left: index == 0 || index == 2 ? 15 : 8,
                right: index == 0 || index == 2 ? 0 : 15,
              ),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  '/customerShowProductDetails',
                  arguments: items[index],
                ),
                child: MostPopularItemsCard(
                  name: items[index].name,
                  description: items[index].description,
                  price: items[index].price,
                  imagePath: items[index].imageUrl,
                  onDelete: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('تأكيد'),
                        content: const Text('هل تريد حذف هذا المنتج؟'),
                        actions: [
                          TextButton(
                            child: const Text('لا'),
                            onPressed: () => Navigator.pop(context),
                          ),
                          TextButton(
                            child: const Text('نعم'),
                            onPressed: () async {
                              Navigator.pop(context);
                              await context
                                  .read<HomeScreenCubit>()
                                  .deleteProduct(
                                    items[index].id,
                                    items[index].category == 'Sandwichs'
                                        ? 0
                                        : items[index].category == 'Pizzas'
                                        ? 1
                                        : items[index].category == 'Crepes'
                                        ? 2
                                        : items[index].category == 'Meals'
                                        ? 3
                                        : items[index].category == 'Drinks'
                                        ? 4
                                        : items[index].category == 'Desserts'
                                        ? 5
                                        : 0,
                                  );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  onEdit: () {
                    // Handle edit
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
