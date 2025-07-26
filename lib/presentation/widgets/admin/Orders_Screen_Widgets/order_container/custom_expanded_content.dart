import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class CustomExpandedContent extends StatelessWidget {
  const CustomExpandedContent({
    super.key,
    required this.orderId,
    required this.date,
    required this.time,
    required this.isExpanded,
    required this.onPressed,
  });

  final String orderId;
  final String date;
  final String time;
  final bool isExpanded;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
        opacity: isExpanded ? 1.0 : 0.0,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            children: [
              const Divider(color: Colors.white24),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ORDER ID',
                        style: GoogleFonts.poppins(
                          color: Colors.white54,
                          fontSize: 10,
                          letterSpacing: 1,
                        ),
                      ),
                      Text(
                        '#$orderId',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'TIME',
                        style: GoogleFonts.poppins(
                          color: Colors.white54,
                          fontSize: 10,
                          letterSpacing: 1,
                        ),
                      ),
                      Text(
                        '$date - $time',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: onPressed,
                  icon: Text(
                    'View Details',
                    style: GoogleFonts.poppins(color: const Color(0xFFFFD700)),
                  ),
                  label: const Icon(
                    IconlyLight.arrow_right_2,
                    color: Color(0xFFFFD700),
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
