import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating; // Rating value (between 0 and 5)
  final double size; // Size of the stars

  const StarRating({super.key, required this.rating, required this.size});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        double starValue = index + 1.0;
        Icon starIcon;
        if (starValue <= rating) {
          starIcon = Icon(Icons.star, size: size, color: Colors.yellow);
        } else if (starValue - 0.5 <= rating) {
          starIcon = Icon(Icons.star_half, size: size, color: Colors.yellow);
        } else {
          starIcon = Icon(Icons.star_border, size: size, color: Colors.yellow);
        }
        return starIcon;
      }),
    );
  }
}
