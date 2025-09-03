import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bussines_logic/cubits/admin/offers_screen/cubit/offers_screen_cubit.dart';
import '../../widgets/admin/Offers_Screen/offer_card/offer_card.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<OffersScreenCubit>(context).getOffers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 165, 101, 56),
        onPressed: () =>
            Navigator.of(context).pushNamed('/adminAddOfferScreen'),
        child: Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        title: const Text(
          "إدارة العروض",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 165, 101, 56),
        surfaceTintColor: Color.fromARGB(255, 165, 101, 56),
      ),
      body: BlocBuilder<OffersScreenCubit, OffersScreenState>(
        builder: (context, state) {
          if (state is OffersScreenLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 165, 101, 56),
              ),
            );
          }
          if (state is OffersScreenSuccess) {
            if (state.offers.isEmpty) {
              return Center(child: Text('لا يوجد عروض في الوقت الحالي'));
            }
            return ListView.builder(
              itemCount: state.offers.length,
              itemBuilder: (context, index) {
                return AdminOfferCard(
                  offer: state.offers[index],
                  onEdit: () {
                    Navigator.of(context).pushNamed(
                      '/editOfferForm',
                      arguments: state.offers[index],
                    );
                  },
                  onDelete: () async {
                    await context.read<OffersScreenCubit>().deleteOffer(
                      state.offers[index].id,
                    );
                  },
                );
              },
            );
          }
          if (state is OffersScreenError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
