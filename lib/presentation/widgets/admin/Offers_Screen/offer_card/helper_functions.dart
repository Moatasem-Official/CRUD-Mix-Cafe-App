import 'dart:ui';

import 'package:flutter/material.dart';
import '../../../../../data/model/offer_model.dart';

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
    Duration difference;

    if (status == OfferStatus.Scheduled) {
      difference = offer.startDate.difference(now);
      if (difference.isNegative) return 'يبدأ قريباً';
    } else if (status == OfferStatus.Active) {
      difference = offer.endDate.difference(now);
      if (difference.isNegative) return 'ينتهي قريباً';
    } else {
      return 'انتهى العرض';
    }

    final days = difference.inDays;
    final hours = difference.inHours % 24;
    final minutes = difference.inMinutes % 60;

    String result = '';

    if (days > 0) result += '$days يوم ';
    if (hours > 0) result += '$hours ساعة ';
    if (minutes > 0) result += '$minutes دقيقة';

    if (result.isEmpty) result = 'أقل من دقيقة';

    if (status == OfferStatus.Scheduled) {
      return 'يبدأ خلال $result';
    } else {
      return 'ينتهي خلال $result';
    }
  }
}
