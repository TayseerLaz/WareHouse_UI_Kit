import 'package:flutter/material.dart';
import 'base_card.dart';

class InventoryEntryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onDiscard;
  final VoidCallback onAdd;

  const InventoryEntryCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onDiscard,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Header
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF191919),
                      fontSize: 16,
                      fontFamily: 'Plus Jakarta Sans',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF4C4C4C),
                      fontSize: 14,
                      fontFamily: 'Plus Jakarta Sans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const Icon(Icons.keyboard_arrow_down, color: Color(0xFF595959)),
            ],
          ),
          const SizedBox(height: 16),
          
          // Action Buttons Row (Mode, Quantity, Excess)
          Row(
            children: [
              _buildOptionButton('Mode'),
              const SizedBox(width: 8),
              _buildOptionButton('Quantity'),
              const SizedBox(width: 8),
              _buildOptionButton('Excess'),
            ],
          ),
          
          const SizedBox(height: 16),

          // Bottom Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: onDiscard,
                child: const Text(
                  'Discard',
                  style: TextStyle(
                    color: Color(0xFF4C4C4C),
                    fontSize: 12,
                    fontFamily: 'Plus Jakarta Sans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: onAdd,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6631E2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  elevation: 4,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                ),
                child: const Text(
                  'Add this item',
                  style: TextStyle(
                    color: Color(0xFFDDD2F8),
                    fontSize: 14,
                    fontFamily: 'Plus Jakarta Sans',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.1,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOptionButton(String label) {
    return Expanded(
      child: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFD2E2F8)),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF4C4C4C),
                fontSize: 12,
                fontFamily: 'Plus Jakarta Sans',
              ),
            ),
             if (label == 'Mode')
              const Icon(Icons.arrow_drop_down, size: 16, color: Color(0xFF4C4C4C)),
          ],
        ),
      ),
    );
  }
}
