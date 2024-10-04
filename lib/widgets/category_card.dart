// /widgets/category_card.dart
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final Color backgroundColor;

  const CategoryCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: backgroundColor,
          radius: heightScreen / 8.5 / 3,
          child: Image.asset(imagePath),
        ),
        SizedBox(height: heightScreen / 8 / 5 / 5), // لإضافة مسافة صغيرة تحت الصورة
        Text(title)
      ],
    );
  }
}
