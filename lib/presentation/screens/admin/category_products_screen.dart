import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bussines_logic/cubits/admin/categories_screen/cubit/categories_cubit.dart';
import 'add_product_information_form.dart';
import '../../widgets/admin/Products_Screen_Widgets/custom_product_templete.dart';

class CategoryProductsScreen extends StatefulWidget {
  const CategoryProductsScreen({super.key, required this.categoryId});

  final int categoryId;

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen>
    with AutomaticKeepAliveClientMixin<CategoryProductsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CategoriesCubit>().getProducts(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16, right: 16),
        child: FloatingActionButton.extended(
          heroTag: 'fab-${widget.categoryId}',
          backgroundColor: const Color(0xFFA0522D),
          elevation: 4,
          icon: const Icon(Icons.add, size: 22, color: Colors.white),
          label: const Text(
            "إضافة منتج",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<CategoriesCubit>(),
                  child: ProductInformationForm(categoryId: widget.categoryId),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<CategoriesCubit>().getProducts(widget.categoryId);
        },
        color: const Color(0xFFA0522D),
        backgroundColor: const Color.fromARGB(255, 255, 226, 212),
        strokeWidth: 2,
        child: BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, state) {
            if (state is CategoriesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CategoriesEmpty) {
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 200),
                  Center(child: Text('لا يوجد منتجات')),
                ],
              );
            } else if (state is CategoriesError) {
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 200),
                  Center(child: Text('حدث خطأ أثناء تحميل المنتجات')),
                ],
              );
            } else if (state is CategoriesLoaded) {
              final products = context.read<CategoriesCubit>().products;

              return ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(8),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return CustomProductTemplate(
                    productName: products[index].name,
                    productDescription: products[index].description,
                    productPrice: products[index].price,
                    imagePath: products[index].imageUrl,
                    isHasDiscount: products[index].hasDiscount,
                    discountPrice: products[index].discountedPrice,
                    onDelete: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
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
                                      .read<CategoriesCubit>()
                                      .deleteProduct(
                                        products[index].id,
                                        widget.categoryId,
                                      );
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              );
            } else {
              return const Center(child: Text('لم يتم تحميل البيانات بعد'));
            }
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
