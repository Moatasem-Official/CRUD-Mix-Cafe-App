import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bussines_logic/cubits/admin/offers_screen/cubit/offers_screen_cubit.dart';
import '../../../data/model/offer_model.dart';
import '../../../data/services/cloudinary/cloudinary_services.dart';
import '../../widgets/admin/Add_Offer_Screen/custom_add_offer_button.dart';
import '../../widgets/admin/Add_Offer_Screen/custom_build_image_picker.dart';
import '../../widgets/admin/Add_Offer_Screen/custom_build_section.dart';
import '../../widgets/admin/Add_Offer_Screen/helper_functions.dart';
import '../../widgets/admin/Add_Offer_Screen/main_offer_details_section.dart';
import '../../widgets/admin/Add_Offer_Screen/offer_start_end_date_time_section.dart';

class AdminAddOfferScreen extends StatefulWidget {
  const AdminAddOfferScreen({super.key});

  @override
  State<AdminAddOfferScreen> createState() => _AdminAddOfferScreenState();
}

// Add SingleTickerProviderStateMixin for animation
class _AdminAddOfferScreenState extends State<AdminAddOfferScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _discountController = TextEditingController();

  // State variables
  DateTime? _startDate;
  DateTime? _endDate;
  File? _offerImage;

  // Animation
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _discountController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Add New Offer',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color.fromARGB(255, 165, 101, 56),
            letterSpacing: 1.1,
          ),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color.fromARGB(255, 165, 101, 56),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MainOfferDetailsSection(
                  titleController: _titleController,
                  descriptionController: _descriptionController,
                ),
                const SizedBox(height: 20),
                OfferStartEndDateTimeSection(
                  startDate: _startDate,
                  endDate: _endDate,
                  onEndDateSelected: (date) => setState(() {
                    _endDate = date;
                  }),
                  onStartDateSelected: (date) => setState(() {
                    _startDate = date;
                  }),
                ),
                const SizedBox(height: 20),
                CustomBuildSection(
                  title: 'Offer Image',
                  icon: Icons.image,
                  child: CustomBuildImagePicker(
                    offerImage: _offerImage,
                    onImagePicked: (image) => setState(() {
                      _offerImage = image;
                    }),
                  ),
                ),
                const SizedBox(height: 30),
                Builder(
                  builder: (context) => CustomAddOfferButton(
                    onAddOffer: () async {
                      final isValid = await HelperFunctions.submitOffer(
                        context,
                        _formKey,
                        _startDate,
                        _endDate,
                        _offerImage,
                      );

                      if (!isValid) return;

                      final cloudinary = CloudinaryServices();

                      try {
                        final imageUrl = await cloudinary
                            .uploadImageToCloudinary(_offerImage!);

                        if (imageUrl == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Failed To Upload Image'),
                            ),
                          );
                          return;
                        }

                        final offer = Offer(
                          id: '',
                          title: _titleController.text.trim(),
                          description: _descriptionController.text.trim(),
                          startDate: _startDate!,
                          endDate: _endDate!,
                          imageUrl: imageUrl,
                        );

                        await context.read<OffersScreenCubit>().addOffer(
                          offer: offer,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Offer Added Successfully"),
                          ),
                        );
                        Navigator.pop(context);
                      } catch (e) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text('Error: $e')));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
