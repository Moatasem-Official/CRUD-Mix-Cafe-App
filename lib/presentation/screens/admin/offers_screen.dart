import 'package:flutter/material.dart';
import 'package:mix_cafe_app/data/model/offer_model.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Offers_Screen/offer_card/offer_card.dart';

class OffersScreen extends StatelessWidget {
  OffersScreen({super.key});
  // Example of how to use the card in a list

  // Dummy data for demonstration
  final Offer sampleOffer = Offer(
    id: '123',
    title: 'عرض الصيف الخيالي',
    description:
        'خصومات تصل إلى 70% على جميع الملابس الصيفية. لا تفوت الفرصة الآن واحصل على أفضل الإطلالات!',
    imageUrl:
        'https://images.pexels.com/photos/102129/pexels-photo-102129.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', // Use a real image URL
    startDate: DateTime.now().subtract(const Duration(days: 2)), // Active
    endDate: DateTime.now().add(const Duration(days: 5)),
  );

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
      body: ListView.builder(
        itemCount: 5, // Replace with your offers list length
        itemBuilder: (context, index) {
          return AdminOfferCard(
            offer:
                sampleOffer, // Replace with your actual offer object from the list
            onEdit: () {
              print('Editing offer ${sampleOffer.id}');
            },
            onDelete: () {
              print('Deleting offer ${sampleOffer.id}');
            },
          );
        },
      ),
    );
  }
}
