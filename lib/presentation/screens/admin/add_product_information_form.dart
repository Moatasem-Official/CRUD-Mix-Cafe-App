import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mix_cafe_app/bussines_logic/cubits/admin/categories_screen/cubit/categories_cubit.dart';
import 'package:mix_cafe_app/data/helpers/custom_snack_bar.dart';
import 'package:mix_cafe_app/data/helpers/when_loading_widget.dart';
import '../../../controllers/product_form_controller.dart';
import '../../widgets/admin/Products_Screen_Widgets/add_product_info_widgets/custom_add_product_info_form.dart';

class ProductInformationForm extends StatefulWidget {
  const ProductInformationForm({super.key, required this.categoryId});

  final int categoryId;

  @override
  State<ProductInformationForm> createState() => _ProductInformationFormState();
}

class _ProductInformationFormState extends State<ProductInformationForm> {
  late final ProductFormController _formController;
  @override
  void initState() {
    super.initState();
    _formController = ProductFormController();
  }

  @override
  void dispose() {
    _formController.dispose();
    super.dispose();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocListener<CategoriesCubit, CategoriesState>(
          listener: (context, state) {
            if (state is AddProductLoading) {
              setState(() {
                isLoading = true;
              });
            } else if (state is AddProductSuccess) {
              setState(() {
                isLoading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(
                  message: state.message,
                  title: 'Success',
                  contentType: ContentType.success,
                ),
              );
              Navigator.of(context).pop();
            } else if (state is AddProductError) {
              setState(() {
                isLoading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(
                  message: state.errorMessage,
                  title: 'Error',
                  contentType: ContentType.failure,
                ),
              );
            }
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: AppBar(
                surfaceTintColor: Colors.transparent,
                backgroundColor: Colors.white, // كابتشينو ناعم
                centerTitle: true,
                title: const Text(
                  'Product Information',
                  style: TextStyle(
                    color: Color.fromARGB(255, 165, 101, 56),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Color.fromARGB(255, 165, 101, 56),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  CustomAddProductInformationForm(
                    controller: _formController,
                    onHasDiscountSwitchChanged: (value) {
                      setState(() {
                        _formController.isHasDiscount = value;
                      });
                    },
                    onIsFeaturedSwitchChanged: (value) {
                      setState(() {
                        _formController.isFeatured = value;
                      });
                    },
                    onIsNewSwitchChanged: (value) {
                      setState(() {
                        _formController.isNew = value;
                      });
                    },
                    onIsBestSwitchChanged: (value) {
                      setState(() {
                        _formController.isBest = value;
                      });
                    },
                    onImageSelected: (image) {
                      setState(() {
                        _formController.imageUrl = image;
                      });
                    },
                    onStartDatePicked: (onStartDatePicked) {
                      setState(() {
                        _formController.startDate = onStartDatePicked;
                        _formController.startDateController.text =
                            "${onStartDatePicked.year}-${onStartDatePicked.month.toString().padLeft(2, '0')}-${onStartDatePicked.day.toString().padLeft(2, '0')}";
                      });
                    },
                    onEndDatePicked: (onEndDatePicked) {
                      setState(() {
                        _formController.endDate = onEndDatePicked;
                        _formController.endDateController.text =
                            "${onEndDatePicked.year}-${onEndDatePicked.month.toString().padLeft(2, '0')}-${onEndDatePicked.day.toString().padLeft(2, '0')}";
                      });
                    },
                    onStartTimePicked: (onStartTimePicked) {
                      setState(() {
                        _formController.timeStartPicked = onStartTimePicked;
                        _formController.startTimeController.text =
                            onStartTimePicked.format(context);
                      });
                    },
                    onEndTimePicked: (onEndTimePicked) {
                      setState(() {
                        _formController.timeEndPicked = onEndTimePicked;
                        _formController.endTimeController.text = onEndTimePicked
                            .format(context);
                      });
                    },
                    categoryId: widget.categoryId,
                    onAddProduct: () {
                      if (_formController.formKey.currentState!.validate()) {
                        _formController.formKey.currentState!.save();
                        if (_formController.imageUrl == null ||
                            _formController.imageUrl!.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please select an image for the product.',
                              ),
                            ),
                          );
                          return;
                        }
                        context.read<CategoriesCubit>().addProduct(
                          categoryId: widget
                              .categoryId, // يجب تعديل هذا حسب الفئة المختارة
                          name: _formController.nameController.text,
                          description: _formController.descController.text,
                          price: double.parse(
                            _formController.priceController.text,
                          ),
                          quantity: int.parse(
                            _formController.quantityController.text,
                          ),
                          image: _formController.imageUrl ?? '',
                          startDiscountDate:
                              _formController.startDateController.text,
                          endDiscountDate:
                              _formController.endDateController.text,
                          startDiscountTime:
                              _formController.startTimeController.text,
                          endDiscountTime:
                              _formController.endTimeController.text,
                          discountPercentage: double.tryParse(
                            _formController.discountPercentageController.text,
                          ),
                          hasDiscount: _formController.isHasDiscount,
                          isAvailable: _formController.isAvailable,
                          isFeatured: _formController.isFeatured,
                          isNew: _formController.isNew,
                          isBestSeller: _formController.isBest,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        isLoading ? const WhenLoadingLogInWidget() : const SizedBox.shrink(),
      ],
    );
  }
}
