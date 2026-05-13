import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/companion_card.dart';
import '../widgets/pricing_card.dart';
import 'booking_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0.5, 0.3),
                  radius: 1.5,
                  colors: [
                    Color(0xFF1a1a3e),
                    Color(0xFF0a0a1f),
                  ],
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Let a Gentle Real Voice\nGuide You to Sleep',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Real human whispers, bedtime stories,\nemotional comfort & ASMR.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Colors.grey[400],
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BookingScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFc8b6ff),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 48,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        child: const Text(
                          '🌙 Reserve Tonight',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Companions Section
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    'Meet Your Real Companions',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const CompanionCard(
                    name: 'Elena Voss',
                    tag: '🎀 Gentle British Whisperer',
                    description: 'Soft, magnetic British accent, light as night feathers, guiding you into sleep.',
                    imageUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=800',
                  ),
                  const SizedBox(height: 16),
                  const CompanionCard(
                    name: 'Marcus Reed',
                    tag: '💛 Warm American Storyteller',
                    description: 'A comforting deep voice that reads bedtime stories like a caring friend.',
                    imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=800',
                  ),
                ],
              ),
            ),
            // Pricing Section
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    'Choose Your Session',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  PricingCard(
                    plan: '30min',
                    minutes: '30 Minutes',
                    price: 10,
                    description: 'Gentle whispers & emotional comfort',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BookingScreen(plan: '30min', price: 10),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  PricingCard(
                    plan: '60min',
                    minutes: '60 Minutes',
                    price: 29,
                    description: 'Personalized bedtime stories & deep companionship',
                    isPopular: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BookingScreen(plan: '60min', price: 29),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  PricingCard(
                    plan: '90min',
                    minutes: '90 Minutes Premium',
                    price: 59,
                    description: 'Premium deep relaxation experience',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BookingScreen(plan: '90min', price: 59),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
