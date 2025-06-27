import 'package:flutter/material.dart';

class MostPopularItemsCard extends StatelessWidget {
  const MostPopularItemsCard({
    super.key,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
  });

  final String name;
  final String description;
  final String price;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 12.0,
      ), // Padding for separation
      child: Container(
        width: double.infinity, // Card takes full width
        decoration: BoxDecoration(
          color: const Color(
            0xFF6F4E37,
          ), // Very dark brown/almost black-brown for a sleek look
          borderRadius: BorderRadius.circular(
            18,
          ), // Slightly less rounded than previous
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(
                0.4,
              ), // Deeper shadow for strong contrast
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section - positioned more subtly
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(18),
              ),
              child: Image.asset(
                imagePath,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            // Text Content Section
            Padding(
              padding: const EdgeInsets.all(16.0), // Consistent padding inside
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(
                        255,
                        236,
                        233,
                        231,
                      ), // Lighter brown for name
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    maxLines: 3,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.brown[300], // Medium brown for description
                      overflow: TextOverflow.ellipsis,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "$price EGP",
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors
                              .white, // White for price for clear visibility
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
