import 'package:flutter/material.dart';
import '../status_badge.dart';
import 'base_card.dart';

class PaymentStatusCard extends StatelessWidget {
  final String userName;
  final String amount;
  final StatusType status;
  final VoidCallback? onSendReminder;
  final VoidCallback? onUpdatePayment;

  const PaymentStatusCard({
    super.key,
    required this.userName,
    required this.amount,
    required this.status,
    this.onSendReminder,
    this.onUpdatePayment,
  });

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                userName,
                style: const TextStyle(
                  color: Color(0xFF191919),
                  fontSize: 20,
                  fontFamily: 'Plus Jakarta Sans',
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                amount,
                style: const TextStyle(
                  color: Color(0xFF4C4C4C),
                  fontSize: 14,
                  fontFamily: 'Plus Jakarta Sans',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Status Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               StatusBadge(type: status),
               const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF595959)),
            ],
          ),

          const SizedBox(height: 24),

          // Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (onSendReminder != null)
                TextButton(
                  onPressed: onSendReminder,
                  child: const Text(
                    'Send Reminder',
                    style: TextStyle(
                      color: Color(0xFF4C4C4C),
                      fontSize: 12,
                      fontFamily: 'Plus Jakarta Sans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              const SizedBox(width: 8),
              if (onUpdatePayment != null)
                ElevatedButton(
                  onPressed: onUpdatePayment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6631E2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    elevation: 4,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  ),
                  child: const Text(
                    'Update Payment',
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
}
