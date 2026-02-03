import 'package:flutter/material.dart';

enum ConnectState { idle, connecting, connected }

class ConnectGadgetCard extends StatefulWidget {
  final void Function(ConnectState)? onStateChanged;

  const ConnectGadgetCard({super.key, this.onStateChanged});

  @override
  State<ConnectGadgetCard> createState() => _ConnectGadgetCardState();
}

class _ConnectGadgetCardState extends State<ConnectGadgetCard> {
  ConnectState buttonState = ConnectState.idle;

  void _onButtonPressed() {
    if (buttonState == ConnectState.idle) {
      setState(() {
        buttonState = ConnectState.connecting;
        widget.onStateChanged?.call(buttonState);
      });

      // Simulate 3 second connection
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          buttonState = ConnectState.connected;
          widget.onStateChanged?.call(buttonState);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String buttonText;
    Color buttonColor = const Color(0xFF0F172A);
    Widget? buttonIcon;

    switch (buttonState) {
      case ConnectState.idle:
        buttonText = 'Connect Device';
        buttonColor = const Color(0xFF0F172A);
        buttonIcon = const Icon(Icons.bluetooth, color: Colors.white);
        break;
      case ConnectState.connecting:
        buttonText = 'Connecting...';
        buttonColor = Colors.blueGrey;
        buttonIcon = const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
        );
        break;
      case ConnectState.connected:
        buttonText = 'Connected';
        buttonColor = Colors.green;
        buttonIcon = const Icon(Icons.check, color: Colors.white);
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          '2. Connect Gadget',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A2130),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05), // Very light shadow
                blurRadius: 4, // Smooth blur
                spreadRadius: 1, // Spread a tiny bit
                offset: const Offset(0, 2), // Slight vertical offset
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage(
                  'assets/images/doctor_holding_tablet.png',
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Make sure your KneeMS device is turned on and strapped comfortably.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blueGrey.shade600,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _onButtonPressed,
                  icon: buttonIcon,
                  label: Text(
                    buttonText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
