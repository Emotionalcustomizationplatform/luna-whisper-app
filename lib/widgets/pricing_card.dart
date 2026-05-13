import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PricingCard extends StatelessWidget {
  final String plan;
  final String minutes;
  final int price;
  final String description;
  final bool isPopular;
  final VoidCallback onTap;

  const PricingCard({
    super.key,
    required this.plan,
    required this.minutes,
    required this.price,
    required this.description,
    this.isPopular = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isPopular ? const Color(0xFFc8b6ff).withOpacity(0.08) : Colors.white.withOpacity(0.04),
          border: Border.all(
            color: isPopular ? const Color(0xFFc8b6ff) : Colors.white.withOpacity(0.1),
            width: isPopular ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            if (isPopular)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFc8b6ff),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text('Most Popular', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black)),
              ),
            const SizedBox(height: 12),
            Text(minutes, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 8),
            Text('\$$price', style: GoogleFonts.inter(fontSize: 36, fontWeight: FontWeight.bold, color: const Color(0xFFc8b6ff))),
            const SizedBox(height: 8),
            Text(description, textAlign: TextAlign.center, style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[400])),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFc8b6ff),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              ),
              child: const Text('Book Now', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
