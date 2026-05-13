import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CompanionCard extends StatelessWidget {
  final String name;
  final String tag;
  final String description;
  final String imageUrl;

  const CompanionCard({
    super.key,
    required this.name,
    required this.tag,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.network(
              imageUrl,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  color: const Color(0xFF1e1e3a),
                  child: Center(
                    child: Text(name, style: const TextStyle(color: Color(0xFFc8b6ff), fontSize: 18)),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 4),
                Text(tag, style: GoogleFonts.inter(fontSize: 13, color: const Color(0xFFc8b6ff))),
                const SizedBox(height: 8),
                Text(description, style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[400])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
