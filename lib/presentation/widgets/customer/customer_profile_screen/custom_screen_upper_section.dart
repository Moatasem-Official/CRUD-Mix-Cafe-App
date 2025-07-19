import 'package:flutter/material.dart';
import 'package:mix_cafe_app/constants/app_assets.dart';

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
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: isDarkMode
                        ? Colors.grey.shade700
                        : Colors.grey.shade300,
                    backgroundImage: image.isEmpty
                        ? AssetImage(Assets.mixCafeCustomerImage)
                        : NetworkImage(image) as ImageProvider,
                    onBackgroundImageError: (exception, stackTrace) =>
                        const Icon(Icons.person, size: 60),
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
