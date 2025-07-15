import 'dart:ui';

import 'package:flutter/material.dart';

class CustomBackBotton extends StatelessWidget {
  const CustomBackBotton({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          borderRadius: BorderRadius.circular(100),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Transform.translate(
                offset: Offset(3, 0),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
