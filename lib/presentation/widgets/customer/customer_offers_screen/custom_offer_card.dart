import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mix_cafe_app/data/model/offer_model.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Offers_Screen/offer_card/helper_functions.dart';
import 'package:mix_cafe_app/presentation/widgets/customer/customer_offers_screen/custom_offer_status_badge.dart';

class OfferCard extends StatefulWidget {
  const OfferCard({super.key, required this.offer});
  final Offer offer;

  @override
  State<OfferCard> createState() => _OfferCardState();
}

class _OfferCardState extends State<OfferCard> {
  late Duration _remaining;
  late final OfferStatus _status;
  late final DateTime _target;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _status = HelperFunctions.status(widget.offer);
    _target = _status == OfferStatus.Scheduled
        ? widget.offer.startDate
        : widget.offer.endDate;

    _remaining = _target.difference(DateTime.now());
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final newRemaining = _target.difference(DateTime.now());

      if (mounted) {
        setState(() {
          _remaining = newRemaining.isNegative ? Duration.zero : newRemaining;
        });
      }

      if (newRemaining.isNegative) {
        _timer?.cancel();
      }
    });
  }

  String _formatDuration(Duration d) {
    final days = d.inDays;
    final hours = d.inHours % 24;
    final minutes = d.inMinutes % 60;
    final seconds = d.inSeconds % 60;

    String result = '';
    if (days > 0) result += '${days}d ';
    if (hours > 0) result += '${hours}h ';
    if (minutes > 0) result += '${minutes}m ';
    result += '${seconds}s';

    return result;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color mainColor = const Color.fromARGB(255, 165, 101, 56);
    final offer = widget.offer;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.pushNamed(
          context,
          '/customerOfferDetailsScreen',
          arguments: offer,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // صورة العرض
              SizedBox(
                height: 180,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    offer.imageUrl ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Center(child: Icon(Icons.image_not_supported)),
                    loadingBuilder: (_, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // شارة الحالة
                    Align(
                      alignment: Alignment.topLeft,
                      child: OfferStatusBadge(offer: offer),
                    ),
                    const SizedBox(height: 10),

                    // العنوان
                    Text(
                      offer.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: mainColor,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // الوصف
                    Text(
                      offer.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // الوقت التنازلي
                    Row(
                      children: [
                        const Icon(
                          Icons.timer_outlined,
                          size: 18,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _status == OfferStatus.Scheduled
                              ? 'Starts in: ${_formatDuration(_remaining)}'
                              : _status == OfferStatus.Active
                              ? 'Ends in: ${_formatDuration(_remaining)}'
                              : 'Offer Ended',
                          style: TextStyle(color: mainColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
