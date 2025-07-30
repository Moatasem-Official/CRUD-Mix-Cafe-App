// 2. The Admin Offer Card Widget

import 'package:flutter/material.dart';
import 'package:mix_cafe_app/data/model/offer_model.dart';

class AdminOfferCard extends StatelessWidget {
  final Offer offer;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const AdminOfferCard({
    super.key,
    required this.offer,
    required this.onEdit,
    required this.onDelete,
  });

  // Helper to determine the offer status
  OfferStatus get _status {
    final now = DateTime.now();
    if (now.isAfter(offer.endDate)) {
      return OfferStatus.Expired;
    } else if (now.isBefore(offer.startDate)) {
      return OfferStatus.Scheduled;
    } else {
      return OfferStatus.Active;
    }
  }

  // Helper to get the right color for the status
  Color get _statusColor {
    switch (_status) {
      case OfferStatus.Active:
        return Colors.green.shade600;
      case OfferStatus.Scheduled:
        return Colors.orange.shade700;
      case OfferStatus.Expired:
        return Colors.red.shade700;
    }
  }

  // Helper to get the right icon for the status
  IconData get _statusIcon {
    switch (_status) {
      case OfferStatus.Active:
        return Icons.play_circle_fill;
      case OfferStatus.Scheduled:
        return Icons.timer_outlined;
      case OfferStatus.Expired:
        return Icons.cancel;
    }
  }

  // Helper for dynamic time difference string
  String get _timeDifferenceString {
    final now = DateTime.now();
    if (_status == OfferStatus.Scheduled) {
      final difference = offer.startDate.difference(now);
      if (difference.inDays > 0) return 'يبدأ خلال ${difference.inDays} يوم';
      if (difference.inHours > 0) return 'يبدأ خلال ${difference.inHours} ساعة';
      return 'يبدأ قريباً';
    } else if (_status == OfferStatus.Active) {
      final difference = offer.endDate.difference(now);
      if (difference.inDays > 0) return 'ينتهي خلال ${difference.inDays} يوم';
      if (difference.inHours > 0)
        return 'ينتهي خلال ${difference.inHours} ساعة';
      return 'ينتهي قريباً';
    }
    return 'انتهى العرض';
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color.fromARGB(255, 165, 101, 56);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.antiAlias, // To clip the image
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Image Header with Badges ---
          Stack(
            children: [
              Image.network(
                offer.imageUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                // Simple loading and error widgets
                loadingBuilder: (context, child, progress) => progress == null
                    ? child
                    : Container(
                        height: 180,
                        color: Colors.grey[200],
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 180,
                  color: Colors.grey[200],
                  child: const Icon(
                    Icons.broken_image,
                    size: 50,
                    color: Colors.grey,
                  ),
                ),
              ),
              // Status Badge
              Positioned(
                top: 12,
                left: 12,
                child: Chip(
                  avatar: Icon(_statusIcon, color: Colors.white, size: 18),
                  label: Text(
                    _status.name.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  backgroundColor: _statusColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                ),
              ),
            ],
          ),

          // --- Content Section ---
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  offer.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  offer.description,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Divider(height: 24, thickness: 1),
                // --- Status & Timer Row ---
                Row(
                  children: [
                    Icon(Icons.hourglass_bottom, color: _statusColor, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _timeDifferenceString,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: _statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),

          // --- Action Buttons ---
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            color: Colors.grey.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: onEdit,
                  icon: Icon(Icons.edit, size: 20, color: primaryColor),
                  label: Text('تعديل', style: TextStyle(color: primaryColor)),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: onDelete,
                  icon: Icon(
                    Icons.delete_outline,
                    size: 20,
                    color: Colors.red.shade700,
                  ),
                  label: Text(
                    'حذف',
                    style: TextStyle(color: Colors.red.shade700),
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
