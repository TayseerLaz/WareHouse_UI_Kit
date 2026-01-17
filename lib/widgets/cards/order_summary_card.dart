import 'package:flutter/material.dart';
import 'base_card.dart';

class OrderSummaryCard extends StatelessWidget {
  final List<Map<String, String>> items;
  final String totalAmount;

  const OrderSummaryCard({
    super.key,
    required this.items,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Items List
          ...items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: _buildItemRow(item),
          )),
          
          // Divider
          const Divider(height: 1, color: Color(0xFFE6E6E6)),
          const SizedBox(height: 16),
          
          // Total Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  color: Color(0xFF191919),
                  fontSize: 16,
                  fontFamily: 'Plus Jakarta Sans',
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                totalAmount,
                style: const TextStyle(
                  color: Color(0xFF191919),
                  fontSize: 16,
                  fontFamily: 'Plus Jakarta Sans',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Bottom Bar (Item Count + Proceed)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${items.length} Items Selected',
                style: const TextStyle(
                  color: Color(0xFF191919),
                  fontSize: 14,
                  fontFamily: 'Plus Jakarta Sans',
                  fontWeight: FontWeight.w500,
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6631E2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  shadowColor: const Color(0x0C000000),
                  elevation: 4,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                ),
                child: const Text(
                  'Proceed',
                  style: TextStyle(
                    color: Color(0xFFE8F1FB),
                    fontSize: 14,
                    fontFamily: 'Roboto',
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

  Widget _buildItemRow(Map<String, String> item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item['title'] ?? '',
              style: const TextStyle(
                color: Color(0xFF191919),
                fontSize: 16,
                fontFamily: 'Plus Jakarta Sans',
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              item['subtitle'] ?? '',
              style: const TextStyle(
                color: Color(0xFF4C4C4C),
                fontSize: 14,
                fontFamily: 'Plus Jakarta Sans',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        Text(
          item['price'] ?? '',
          style: const TextStyle(
             color: Color(0xFF191919),
             fontSize: 16,
             fontFamily: 'Plus Jakarta Sans',
             fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
