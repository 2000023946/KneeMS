import 'package:flutter/material.dart';

class ReviewUI extends StatelessWidget {
  final VoidCallback onRedo;
  final VoidCallback onSave;

  const ReviewUI({super.key, required this.onRedo, required this.onSave});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        color: Color(0xFF1E293B),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          const Text(
            "How was that rep?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _btn(
                  "Redo",
                  Icons.refresh,
                  const Color(0xFF334155),
                  onRedo,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _btn(
                  "Save Rep",
                  Icons.check,
                  const Color(0xFF10B981),
                  onSave,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _btn(String label, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 30),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
