import 'package:flutter/material.dart';
import '../../../../constants/app_assets.dart';
import 'package:lottie/lottie.dart';

class CustomScreenUpperSection extends StatelessWidget {
  const CustomScreenUpperSection({
    super.key,
    required this.name,
    required this.email,
    required this.image,
    required this.onTap,
  });

  final String name;
  final String email;
  final String image;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: image.isNotEmpty
                        ? Stack(
                            alignment: Alignment.center,
                            children: [
                              Lottie.asset(
                                'assets/animations/profile persons.json',
                                width: 160,
                                height: 160,
                                fit: BoxFit.cover,
                              ),
                              Image.network(
                                image,
                                width: 160,
                                height: 160,
                                fit: BoxFit.cover,
                              ),
                            ],
                          )
                        : Image.asset(
                            Assets.mixCafeCustomerImage,
                            width: 160,
                            height: 160,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),

                Positioned(
                  bottom: 5,
                  right: 5,
                  child: GestureDetector(
                    onTap: onTap,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 196, 110, 13),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: theme.scaffoldBackgroundColor,
                          width: 3,
                        ),
                      ),
                      child: Icon(Icons.edit, color: Colors.white, size: 18),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              name,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              email,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                letterSpacing: 0.1,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? const Color.fromARGB(255, 196, 110, 13).withOpacity(0.9)
                    : const Color.fromARGB(255, 196, 110, 13).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Customer',
                style: TextStyle(
                  color: isDarkMode
                      ? Colors.white
                      : const Color.fromARGB(255, 196, 110, 13),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
