import 'package:flutter/material.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Categories_Screen_Widgets/custom_adding_category_form.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Categories_Screen_Widgets/custom_categ_listview_builder.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Categories_Screen_Widgets/custom_categories_appbar.dart';

class CategoriesManagmentScreen extends StatefulWidget {
  const CategoriesManagmentScreen({super.key});

  @override
  State<CategoriesManagmentScreen> createState() =>
      _CategoriesManagmentScreenState();
}

class _CategoriesManagmentScreenState extends State<CategoriesManagmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomCategoriesAppBar(
        title: 'Categories',
        buttonText: 'Add Category',
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return const CustomAddingCategoryForm();
            },
          );
        },
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomCategoriesListViewBuilder(
              onTab: () => Navigator.pushNamed(
                context,
                '/categoryProducts',
                arguments: 'categoryName',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
