import 'package:flutter/material.dart';
import '../../shared/toast.dart';
import '../home/home_page.dart';
import '../../shared/methods.dart';

class PinScreen extends StatefulWidget {
  final bool isNewUser;
  const PinScreen({super.key, required this.isNewUser});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  late bool isNewUser;
  final List<TextEditingController> _pinControllers =
      List.generate(4, (_) => TextEditingController());
  final List<TextEditingController> _confirmPinControllers =
      List.generate(4, (_) => TextEditingController());

  @override
  void dispose() {
    for (var controller in [..._pinControllers, ..._confirmPinControllers]) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    isNewUser = widget.isNewUser;
  }

  void _submitPin() async {
    String pin = _pinControllers.map((c) => c.text).join();
    String confirmPin = _confirmPinControllers.map((c) => c.text).join();

    if (isNewUser) {
      if (pin.length != 4 ||
          confirmPin.length != 4 ||
          pin.contains(RegExp(r'[^0-9]'))) {
        showToast("Please enter a valid 4-digit PIN");
        return;
      }

      if (pin != confirmPin) {
        showToast("PINs do not match. Please try again.");
        return;
      }
    } else {
      if (pin.length != 4 || pin.contains(RegExp(r'[^0-9]'))) {
        showToast("Please enter a valid 4-digit PIN");
        return;
      }
    }

    if (isNewUser) {
      // Save the PIN logic here (e.g., Firebase)
      showToast("PIN set successfully!");
    } else {
      // Login logic here (e.g., verify PIN from the backend)
      showToast("Logged in successfully!");
    }
    navigateWithFade(context, const HomePage());
  }

  Widget _buildPinInput(String label, List<TextEditingController> controllers) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(4, (index) {
            return SizedBox(
              width: 40,
              child: TextField(
                controller: controllers[index],
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLength: 1,
                obscureText: true,
                decoration: InputDecoration(
                  counterText: '',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onChanged: (value) {
                  if (value.isNotEmpty && index < 3) {
                    FocusScope.of(context).nextFocus();
                  }
                },
              ),
            );
          }),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 30),
        child: Column(
          children: [
            Text(
              isNewUser
                  ? "Please set a 4-digit PIN for future logins."
                  : "Enter your 4-digit PIN to login.",
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            if (isNewUser) ...[
              _buildPinInput("Enter PIN", _pinControllers),
              const SizedBox(height: 20),
              _buildPinInput("Confirm PIN", _confirmPinControllers),
            ] else
              _buildPinInput("Enter PIN", _pinControllers),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitPin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: Text(
                  isNewUser ? "Set PIN" : "Login",
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
