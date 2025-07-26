import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mix_cafe_app/bussines_logic/cubits/admin/analytics_home_screen/cubit/home_analytics_cubit.dart';

class CustomAnalysisContainer extends StatelessWidget {
  const CustomAnalysisContainer({
    super.key,
    required this.title,
    required this.index,
    required this.icon,
  });

  final String title;
  final int index;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 170,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 244, 238, 236),
          borderRadius: BorderRadius.circular(18),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // شريط علوي صغير بلون بني غامق
              Container(
                height: 6,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 165, 101, 56),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
                ),
              ),
              const SizedBox(height: 14),

              // الأيقونة داخل دائرة
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 165, 101, 56),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.white, size: 26),
              ),
              const SizedBox(height: 12),

              // الرقم – مع FittedBox علشان ميكسرش
              BlocBuilder<HomeAnalyticsCubit, HomeAnalyticsState>(
                builder: (context, state) {
                  if (state is HomeAnalyticsLoading) {
                    return const CircularProgressIndicator(
                      color: Color.fromARGB(255, 165, 101, 56),
                    );
                  } else if (state is HomeAnalyticsSuccess) {
                    final number = state.analyticsData[index].toString();
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          title == 'Sales'
                              ? '${formatLargeNumber(number)} \$'
                              : formatLargeNumber(number),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4E342E),
                          ),
                        ),
                      ),
                    );
                  } else if (state is HomeAnalyticsError) {
                    return Text(state.message);
                  }
                  return const SizedBox();
                },
              ),
              const SizedBox(height: 6),

              // العنوان
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 165, 101, 56),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatLargeNumber(String numberString) {
    try {
      double number = double.parse(numberString.replaceAll(' \$', ''));
      if (number >= 1000000) {
        return '${(number / 1000000).toStringAsFixed(1)}M';
      } else if (number >= 1000) {
        return '${(number / 1000).toStringAsFixed(1)}k';
      } else {
        return number.toStringAsFixed(0);
      }
    } catch (e) {
      return numberString;
    }
  }
}
