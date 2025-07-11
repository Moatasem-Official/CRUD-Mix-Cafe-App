import 'dart:ui';

import 'package:flutter/material.dart';

class WhenLoadingLogInWidget extends StatelessWidget {
  const WhenLoadingLogInWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          color: Colors.black.withOpacity(0.2),
          child: Center(
            child: Image.asset(
              'assets/animations/Animation - 1751644034977.gif',
              width: 200,
              height: 200,
            ),
          ),
        ),
      ),
    );
  }
}

class WhenLoadingCategoriesWidget extends StatelessWidget {
  const WhenLoadingCategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          color: Colors.black.withOpacity(0.2),
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
