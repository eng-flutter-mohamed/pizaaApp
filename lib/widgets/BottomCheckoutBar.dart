import 'package:flutter/material.dart';

class BottomCheckoutBar extends StatelessWidget {
  final int itemCount; // عدد العناصر
  final double totalPrice; // السعر الإجمالي
  final VoidCallback onCheckout; // الوظيفة عند الضغط على الزر

  const BottomCheckoutBar({
    Key? key,
    required this.itemCount,
    required this.totalPrice,
    required this.onCheckout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Colors.black, blurRadius: 20),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MaterialButton(
          height: 50,
          color: const Color.fromARGB(255, 2, 158, 186),
          onPressed: onCheckout,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 18, 167, 194),
                  borderRadius: BorderRadius.circular(5),
                ),
                width: 30,
                child: Center(
                  child: Text(
                    '$itemCount',
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),Text("View Baskit"),
              Text(
                'EGP ${totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
