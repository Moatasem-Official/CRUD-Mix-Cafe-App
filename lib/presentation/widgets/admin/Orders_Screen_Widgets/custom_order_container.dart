import 'package:flutter/material.dart';
import '../../../../constants/app_assets.dart';

class CustomOrderContainerTemplete extends StatelessWidget {
  CustomOrderContainerTemplete({
    super.key,
    required this.customerName,
    required this.orderId,
    required this.date,
    required this.status,
    required this.time,
    required this.onPressed,
  });

  final String customerName;
  final String orderId;
  final String date;
  final String time;
  final String status;
  final Function() onPressed;

  var isVip = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- العنوان وصورة العميل والحالة ---
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // صورة العميل
              CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage(
                  Assets.mixCafeAdminImage,
                ), // أو NetworkImage
                backgroundColor: Colors.grey.shade200,
              ),
              const SizedBox(width: 12),

              // اسم العميل + تفاصيل الطلب
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          customerName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 6),
                        if (isVip)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.amber.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'VIP',
                              style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Order ID: $orderId',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),

              // بادج الحالة
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: status == 'Pending'
                      ? const Color(0xFFFFF4D6)
                      : status == 'In Progress'
                      ? const Color(0xFFE0F0FF)
                      : const Color(0xFFE6FFED),
                  border: Border.all(
                    color: status == 'Pending'
                        ? const Color(0xFFF9C400)
                        : status == 'In Progress'
                        ? const Color(0xFFAECBFF)
                        : const Color(0xFFB7E8C1),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: status == 'Pending'
                        ? const Color(0xFFC58F00)
                        : status == 'In Progress'
                        ? const Color(0xFF4285F4)
                        : const Color(0xFF34A853),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // التاريخ والوقت
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 18,
                color: Colors.grey.shade400,
              ),
              const SizedBox(width: 6),
              Text(
                'Date: $date',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade400),
              ),
              const SizedBox(width: 12),
              Icon(Icons.access_time, size: 18, color: Colors.grey.shade400),
              const SizedBox(width: 6),
              Text(
                time,
                style: TextStyle(fontSize: 13, color: Colors.grey.shade400),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              style: ButtonStyle(
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                padding: WidgetStateProperty.all(EdgeInsets.zero),
              ),
              onPressed: onPressed,
              child: Row(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'View Details',
                    style: TextStyle(
                      color: Colors.brown,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: Colors.brown,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
