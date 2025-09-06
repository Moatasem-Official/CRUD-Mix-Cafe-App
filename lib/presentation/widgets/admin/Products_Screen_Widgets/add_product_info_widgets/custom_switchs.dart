import 'package:flutter/material.dart';

class ProductPropertiesCard extends StatelessWidget {
  final bool isNew;
  final bool isFeatured;
  final bool isBest;
  final bool hasDiscount;
  final Function(bool) onIsNewChanged;
  final Function(bool) onIsFeaturedChanged;
  final Function(bool) onIsBestChanged;
  final Function(bool) onHasDiscountChanged;

  const ProductPropertiesCard({
    super.key,
    required this.isNew,
    required this.isFeatured,
    required this.isBest,
    required this.hasDiscount,
    required this.onIsNewChanged,
    required this.onIsFeaturedChanged,
    required this.onIsBestChanged,
    required this.onHasDiscountChanged,
  });

  static const Color primaryBrown = Color(0xFF8B5E3C);
  static const Color textBrown = Color(0xFF8B4513);
  static const Color inactiveThumb = Color(0xFFD7B899);
  static const Color inactiveTrack = Color(0xFFF3E3D3);
  static const Color trackOutline = Color(0xFFDCC6B1);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Color.fromARGB(255, 255, 250, 245),
      margin: EdgeInsetsDirectional.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSwitchTile(
              title: 'Is New ?',
              icon: Icons.new_releases_outlined,
              value: isNew,
              onChanged: onIsNewChanged,
            ),
            const Divider(indent: 16, endIndent: 16),
            _buildSwitchTile(
              title: 'Is Featured ?',
              icon: Icons.star_border,
              value: isFeatured,
              onChanged: onIsFeaturedChanged,
            ),
            const Divider(indent: 16, endIndent: 16),
            _buildSwitchTile(
              title: 'Is Best Seller ?',
              icon: Icons.thumb_up_alt_outlined,
              value: isBest,
              onChanged: onIsBestChanged,
            ),
            const Divider(indent: 16, endIndent: 16),
            _buildSwitchTile(
              title: 'Has Discount ?',
              icon: Icons.local_offer_outlined,
              value: hasDiscount,
              onChanged: onHasDiscountChanged,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textBrown,
        ),
      ),
      secondary: Icon(icon, color: primaryBrown),
      value: value,
      onChanged: onChanged,
      activeColor: primaryBrown,
      inactiveThumbColor: inactiveThumb,
      inactiveTrackColor: inactiveTrack,
      trackOutlineColor: WidgetStateProperty.all(trackOutline),
    );
  }
}
