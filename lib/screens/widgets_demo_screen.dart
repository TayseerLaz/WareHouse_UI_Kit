import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../widgets/cards/item_info_card.dart';
import '../widgets/cards/inventory_entry_card.dart';
import '../widgets/cards/order_summary_card.dart';
import '../widgets/cards/payment_status_card.dart';
import '../widgets/status_badge.dart';

class WidgetsDemoScreen extends StatelessWidget {
  const WidgetsDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text(localizations.widgets),
        backgroundColor: const Color(0xFF155096),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Badges Section
            Text(localizations.statusBadges, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(localizations.pendingState),
                       const StatusBadge(type: StatusType.pending),
                    ],
                  ),
                  const SizedBox(height: 16),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(localizations.doneState),
                       const StatusBadge(type: StatusType.done),
                    ],
                  ),
                  const SizedBox(height: 16),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(localizations.errorState),
                       const StatusBadge(type: StatusType.error),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            Text(localizations.itemInfoCard, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ItemInfoCard(
              title: localizations.milkMixed,
              subtitle: localizations.categoryMilk,
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
            
            const SizedBox(height: 24),
            Text(localizations.inventoryEntryCard, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            InventoryEntryCard(
              title: localizations.milkCow,
              subtitle: localizations.categoryMilk,
              onDiscard: () {},
              onAdd: () {},
            ),
            
            const SizedBox(height: 24),
            Text(localizations.paymentStatusCard, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            PaymentStatusCard(
              userName: 'Rahul Kumar', // Keeping name as is, likely dynamic in real app
              amount: localizations.totalAmount,
              status: StatusType.pending,
              onSendReminder: () {},
              onUpdatePayment: () {},
            ),
            
            const SizedBox(height: 24),
            Text(localizations.orderSummaryCard, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            OrderSummaryCard(
              items: [
                {'title': localizations.milkCow, 'subtitle': 'Milk', 'price': '₹240'},
                {'title': localizations.gheeCow, 'subtitle': localizations.ghee, 'price': '₹240'},
                {'title': localizations.paneer, 'subtitle': localizations.paneer, 'price': '₹240'},
              ],
              totalAmount: localizations.totalAmount720,
            ),
             const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
