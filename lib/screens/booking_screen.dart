import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/api_service.dart';

class BookingScreen extends StatefulWidget {
  final String plan;
  final int price;

  const BookingScreen({super.key, this.plan = '60min', this.price = 29});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _whatsappController = TextEditingController();
  final _preferredTimeController = TextEditingController();
  final _specialRequestController = TextEditingController();
  String _paymentMethod = 'paypal';
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _whatsappController.dispose();
    _preferredTimeController.dispose();
    _specialRequestController.dispose();
    super.dispose();
  }

  Future<void> _submitBooking() async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _whatsappController.text.isEmpty ||
        _preferredTimeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final usdPrice = widget.price;
      final cnyPrice = (usdPrice * 7.0).round();
      final orderId = 'LW-${DateTime.now().millisecondsSinceEpoch}';

      if (_paymentMethod == 'wechat') {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please scan QR code and note Order ID: $orderId'),
              duration: const Duration(seconds: 5),
            ),
          );
        }
        ApiService.submitBooking(
          name: _nameController.text,
          email: _emailController.text,
          whatsapp: _whatsappController.text,
          sessionPlan: widget.plan,
          preferredTime: _preferredTimeController.text,
          specialRequest: _specialRequestController.text,
          paymentMethod: 'wechat',
          orderId: orderId,
          priceUsd: usdPrice,
          priceCny: cnyPrice,
        );
      } else {
        final result = await ApiService.submitBooking(
          name: _nameController.text,
          email: _emailController.text,
          whatsapp: _whatsappController.text,
          sessionPlan: widget.plan,
          preferredTime: _preferredTimeController.text,
          specialRequest: _specialRequestController.text,
          paymentMethod: 'paypal',
          orderId: orderId,
          priceUsd: usdPrice,
          priceCny: cnyPrice,
        );

        if (result['status'] == 'success' && result['redirect_url'] != null) {
          final url = Uri.parse(result['redirect_url']);
          if (await canLaunchUrl(url)) {
            await launchUrl(url, mode: LaunchMode.externalApplication);
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Your Session')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '${widget.plan == '30min' ? '30 Minutes' : widget.plan == '60min' ? '60 Minutes' : '90 Minutes Premium'} - \$${widget.price}',
              style: GoogleFonts.playfairDisplay(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFc8b6ff),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Your Name'),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _whatsappController,
              decoration: const InputDecoration(labelText: 'WhatsApp (with country code)'),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _preferredTimeController,
              decoration: const InputDecoration(labelText: 'Preferred Time'),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _specialRequestController,
              decoration: const InputDecoration(labelText: 'Special Requests (optional)'),
              style: const TextStyle(color: Colors.white),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('PayPal'),
                    value: 'paypal',
                    groupValue: _paymentMethod,
                    onChanged: (value) => setState(() => _paymentMethod = value!),
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('WeChat Pay'),
                    value: 'wechat',
                    groupValue: _paymentMethod,
                    onChanged: (value) => setState(() => _paymentMethod = value!),
                  ),
                ),
              ],
            ),
            if (_paymentMethod == 'wechat') ...[
              const SizedBox(height: 16),
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/wechat-qr.jpg',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Text(
                                'WeChat QR Code',
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Please scan and note Order ID when paying',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _isLoading ? null : _submitBooking,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                backgroundColor: const Color(0xFFc8b6ff),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.black)
                  : Text(
                      'Confirm Payment \$${widget.price}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
