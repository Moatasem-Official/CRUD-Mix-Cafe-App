import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String body;
  final DateTime timestamp;
  final bool isRead;

  const NotificationCard({
    super.key,
    required this.title,
    required this.body,
    required this.timestamp,
    required this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    final timeAgo = _formatTimeAgo(timestamp);

    return Container(
      margin: const EdgeInsetsDirectional.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      padding: const EdgeInsetsDirectional.all(16),
      decoration: BoxDecoration(
        color: isRead
            ? const Color(0xFFFDFDFD)
            : const Color.fromARGB(255, 255, 252, 248),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // أيقونة ناعمة
          Icon(
            isRead
                ? Icons.mark_email_read_outlined
                : Icons.mark_email_unread_outlined,
            color: const Color(0xFF6F4E37),
            size: 28,
          ),
          const SizedBox(width: 12),

          // النصوص
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // العنوان
                Text(
                  title,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4E342E),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 6),

                // المحتوى
                Text(
                  body,
                  maxLines: 3,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.4,
                    color: Color(0xFF333333),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 10),

                // الوقت
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      timeAgo,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimeAgo(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inSeconds < 60) return 'Now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} Minutes Ago';
    if (diff.inHours < 24) return '${diff.inHours} Hours Ago';
    return DateFormat('yyyy-MM-dd – HH:mm').format(date);
  }
}
