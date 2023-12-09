import 'package:flutter/material.dart';
import 'package:myride/constant/app_screen_size.dart';

class ConfirmTripScreen extends StatelessWidget {
  final Function onSubmit;

  const ConfirmTripScreen({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      onSubmit(2);
    });

    return Center(
      child: GestureDetector(
        onTap: () {
          // onSubmit(2);
        },
        child: Container(
          height: 70,
          width: AppSceenSize.getWidth(context) * 0.95,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: Colors.grey),
          child: const Center(
            child: Text(
              'Confirming Trip....',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
