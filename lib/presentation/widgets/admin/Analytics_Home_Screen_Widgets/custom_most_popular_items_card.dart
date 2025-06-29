import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
  final double price;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          18,
        ), // Slightly less rounded than previous
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section - positioned more subtly
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            child: Image.asset(
              imagePath,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Text Content Section
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(18),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 165, 101, 56),
              ),
              child: Padding(
                padding: const EdgeInsets.all(
                  16.0,
                ), // Consistent padding inside
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
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 14,
                        color: const Color.fromARGB(
                          255,
                          218,
                          181,
                          168,
                        ), // Medium brown for description
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
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: 4.5,
                          itemBuilder: (context, index) =>
                              Icon(Icons.star, color: Colors.amber),
                          itemCount: 5,
                          itemSize: 20.0,
                          direction: Axis.horizontal,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "4.5",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white, // White for rating
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 20,
                      itemBuilder: (context, _) =>
                          Icon(Icons.star, color: Colors.amber),
                      onRatingUpdate: (rating) {
                        print(rating); // تقدر تحفظها أو تبعتها لـ backend
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
