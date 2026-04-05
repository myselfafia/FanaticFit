import 'package:flutter/material.dart';
import 'package:fanaticfit/cart_model.dart';
import 'confirmation_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  String _payment = "";

  Widget _field(TextEditingController controller, {bool isMultiline = false, bool isPhone = false}) {
    return TextField(
      controller: controller,
      maxLines: isMultiline ? 3 : 1,
      keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _paymentOption(String label, IconData icon) {
    bool selected = _payment == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _payment = label),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            border: Border.all(color: selected ? Colors.red : Colors.grey, width: selected ? 2 : 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Icon(icon, color: selected ? Colors.red : Colors.grey),
              const SizedBox(height: 5),
              Text(label, textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, color: selected ? Colors.red : Colors.black)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () => Navigator.pop(context)),
        title: const Text("Order Details", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text("Customer Name", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _field(nameController),

            const SizedBox(height: 20),
            const Text("Phone Number", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _field(phoneController, isPhone: true),

            const SizedBox(height: 20),
            const Text("Payment Method", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                _paymentOption("Bkash", Icons.mobile_friendly),
                const SizedBox(width: 15),
                _paymentOption("Cash on Delivery", Icons.money),
              ],
            ),

            const SizedBox(height: 20),
            const Text("Billing Address", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _field(addressController, isMultiline: true),

            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total Amount:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text("${CartStorage.totalAmount}/-TK", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.red)),
              ],
            ),

            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  if (nameController.text.isEmpty || phoneController.text.isEmpty || addressController.text.isEmpty || _payment.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill in all fields")));
                    return;
                  }
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => ConfirmationScreen()),
                        (route) => false,
                  );
                },
                child: Text("Place Order",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}