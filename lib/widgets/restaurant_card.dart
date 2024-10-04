import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String? cuisine;
  final String? rating;
  final String? time;

  const RestaurantCard({
    Key? key,
    required this.imagePath,
    required this.name,
    this.cuisine,
    this.rating,
    this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return Container(
      width: widthScreen / 2.5,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: ClipRRect( // قص الحواف الداخلية لتكون دائرية
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: widthScreen / 2.5,
              height: widthScreen / 3.5,
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            if (cuisine != null) Text(cuisine!),
            if (rating != null || time != null)
              Row(
                children: [
                  if (rating != null)
                    Row(
                      children: [
                        const Icon(Icons.star, size: 14, color: Colors.orange),
                        Text(rating!),
                      ],
                    ),
            
                  if (time != null) Row(
                    children: [
                      Icon(Icons.watch_later),
                      Text(time!),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
