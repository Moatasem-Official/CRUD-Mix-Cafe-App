import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mix_cafe_app/bussines_logic/cubits/customer/Offers_Screen/cubit/customer_offers_screen_cubit.dart';
import 'package:mix_cafe_app/data/model/offer_model.dart';
import 'package:mix_cafe_app/presentation/widgets/customer/customer_offers_screen/custom_offer_card.dart';

class CustomerOffersScreen extends StatefulWidget {
  const CustomerOffersScreen({super.key});

  @override
  State<CustomerOffersScreen> createState() => _CustomerOffersScreenState();
}

class _CustomerOffersScreenState extends State<CustomerOffersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CustomerOffersScreenCubit>().getOffers();
  }

  @override
  Widget build(BuildContext context) {
    final Color mainColor = const Color.fromARGB(255, 165, 101, 56);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Available Offers',
          style: TextStyle(color: mainColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocBuilder<CustomerOffersScreenCubit, CustomerOffersScreenState>(
        builder: (context, state) {
          if (state is CustomerOffersScreenLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CustomerOffersScreenSuccess) {
            final List<Offer> offers = state.offers;

            if (offers.isEmpty) {
              return const Center(
                child: Text(
                  'No offers available At The Moment.',
                  style: TextStyle(fontSize: 16),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: offers.length,
              itemBuilder: (context, index) {
                return OfferCard(offer: offers[index]);
              },
            );
          } else if (state is CustomerOffersScreenError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
