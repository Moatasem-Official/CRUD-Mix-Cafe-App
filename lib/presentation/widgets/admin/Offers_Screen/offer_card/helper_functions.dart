import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mix_cafe_app/data/model/offer_model.dart';

class HelperFunctions {
  static OfferStatus status(Offer offer) {
    final now = DateTime.now();
    if (now.isAfter(offer.endDate)) {
      return OfferStatus.Expired;
    } else if (now.isBefore(offer.startDate)) {
      return OfferStatus.Scheduled;
    } else {
      return OfferStatus.Active;
    }
  }

  static Color statusColor(OfferStatus status) {
    switch (status) {
      case OfferStatus.Active:
        return Colors.green.shade600;
      case OfferStatus.Scheduled:
        return Colors.orange.shade700;
      case OfferStatus.Expired:
        return Colors.red.shade700;
    }
  }

  static IconData statusIcon(OfferStatus status) {
    switch (status) {
      case OfferStatus.Active:
        return Icons.play_circle_fill;
      case OfferStatus.Scheduled:
        return Icons.timer_outlined;
      case OfferStatus.Expired:
        return Icons.cancel;
    }
  }

  static String timeDifferenceString(OfferStatus status, Offer offer) {
    final now = DateTime.now();
    if (status == OfferStatus.Scheduled) {
      final difference = offer.startDate.difference(now);
      if (difference.inDays > 0) return 'يبدأ خلال ${difference.inDays} يوم';
      if (difference.inHours > 0) return 'يبدأ خلال ${difference.inHours} ساعة';
      return 'يبدأ قريباً';
    } else if (status == OfferStatus.Active) {
      final difference = offer.endDate.difference(now);
      if (difference.inDays > 0) return 'ينتهي خلال ${difference.inDays} يوم';
      if (difference.inHours > 0)
        return 'ينتهي خلال ${difference.inHours} ساعة';
      return 'ينتهي قريباً';
    }
    return 'انتهى العرض';
  }
}
