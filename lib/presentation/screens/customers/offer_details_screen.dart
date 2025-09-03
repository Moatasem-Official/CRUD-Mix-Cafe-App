import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../data/model/offer_model.dart';
import '../../widgets/admin/Offers_Screen/offer_card/helper_functions.dart';
import '../../widgets/customer/customer_offers_screen/custom_offer_status_badge.dart';

class CustomerOfferDetailsScreen extends StatelessWidget {
  final Offer offer;
  const CustomerOfferDetailsScreen({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    final mainColor = const Color(0xFFA56538);
    final startDate = DateFormat(
      'yyyy/MM/dd – hh:mm a',
    ).format(offer.startDate);
    final endDate = DateFormat('yyyy/MM/dd – hh:mm a').format(offer.endDate);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Offer Details',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: mainColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          // ✅ صورة العرض
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(24),
            ),
            child: Image.network(
              offer.imageUrl ?? '',
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Center(
                child: Icon(Icons.image_not_supported, size: 60),
              ),
              loadingBuilder: (_, child, progress) => progress == null
                  ? child
                  : const Center(
                      child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 165, 101, 56),
                      ),
                    ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ✅ حالة العرض
                OfferStatusBadge(offer: offer),
                const SizedBox(height: 16),

                // ✅ عنوان العرض
                Text(
                  offer.title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: mainColor,
                  ),
                ),
                const SizedBox(height: 12),

                // ✅ وصف العرض
                Text(
                  offer.description,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),

                // ✅ التواريخ
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.calendar_today,
                          size: 18,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 15,
                              height: 1.4,
                              fontFamily: 'Arial',
                            ),
                            children: [
                              const TextSpan(
                                text: 'From: ',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: '$startDate\n',
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const TextSpan(
                                text: 'To: ',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: endDate,
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // ✅ زر طلب العرض
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed:
                        HelperFunctions.status(offer) != OfferStatus.Active
                        ? null
                        : () {
                            // هنا تنادي دالة الطلب
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Offer requested successfully !'),
                              ),
                            );
                          },
                    icon: const Icon(Icons.local_offer, color: Colors.white),
                    label: const Text(
                      'Request Offer',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
