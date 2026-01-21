import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'grpo_finalization_screen.dart';

class GRPOReviewScreen extends StatefulWidget {
  final Map<String, dynamic> purchaseOrder;

  const GRPOReviewScreen({
    super.key,
    required this.purchaseOrder,
  });

  @override
  State<GRPOReviewScreen> createState() => _GRPOReviewScreenState();
}

class _GRPOReviewScreenState extends State<GRPOReviewScreen> {
  // Mock items with different receiving statuses
  final List<Map<String, dynamic>> _items = [
    {
      'code': 'B10000',
      'name': 'Printer Label',
      'received': 1,
      'ordered': 116,
      'unit': 'Carton',
      'warehouse': 'Bin Warehouse',
      'status': 'partial', // yellow
    },
    {
      'code': 'C00010',
      'name': 'Mouse USB',
      'received': 78,
      'ordered': 78,
      'unit': 'Carton',
      'warehouse': 'Bin Warehouse',
      'status': 'complete', // green
    },
    {
      'code': 'A00006',
      'name': 'Rainbow 1200 Laser Series',
      'received': 0,
      'ordered': 12,
      'unit': 'Manual',
      'warehouse': 'Bin Warehouse',
      'status': 'pending', // white
    },
    {
      'code': 'A00001',
      'name': 'Office Desk Chair',
      'received': 0,
      'ordered': 25,
      'unit': 'Each',
      'warehouse': 'Bin Warehouse',
      'status': 'pending', // white
    },
  ];

  Future<bool> _showQuitDialog(BuildContext context, AppLocalizations localizations) async {
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.warning_amber_rounded,
                  color: Color(0xFFFFA726),
                  size: 48,
                ),
                const SizedBox(height: 16),
                Text(
                  localizations.quitActivity,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF262626),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  localizations.quitActivityMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF595959),
                  ),
                ),
                const SizedBox(height: 24),
                // Save & Continue Later Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, 'save'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF50),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      localizations.saveContinueLater,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Discard Data Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, 'discard'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF44336),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      localizations.discardData,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Cancel Button
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context, 'cancel'),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      localizations.cancel,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF999999),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (result == 'save') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Progress saved')),
      );
      return true;
    } else if (result == 'discard') {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).primaryColor;
    final localizations = AppLocalizations.of(context)!;

    return WillPopScope(
      onWillPop: () => _showQuitDialog(context, localizations),
      child: Scaffold(
        backgroundColor: const Color(0xFFE8F0FB),
        body: Column(
        children: [
          // Top App Bar
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 60,
              bottom: 20,
            ),
            decoration: BoxDecoration(
              color: themeColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    final shouldPop = await _showQuitDialog(context, localizations);
                    if (shouldPop && context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    localizations.grpo,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                // Edit Icon
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(localizations.edit)),
                    );
                  },
                  icon: const Icon(Icons.edit_outlined, color: Colors.white),
                ),
                // QR Scan Icon
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(localizations.scanQR)),
                    );
                  },
                  icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Supplier & PO Information
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                localizations.supplierNumber,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF999999),
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'V10000',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF262626),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: const Color(0xFFE0E0E0),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                localizations.poNumber,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF999999),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.purchaseOrder['poNumber'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: themeColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Additional Item Button
                  SizedBox(
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/inventory_list');
                      },
                      icon: const Icon(Icons.add_circle_outline),
                      label: Text(localizations.additionalItem),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Item List Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            localizations.item,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF595959),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            localizations.quantity,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF595959),
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Item Cards with Color Coding
                  ..._items.map((item) => _buildItemCard(item, widget.purchaseOrder['poNumber'], localizations)),
                ],
              ),
            ),
          ),

          // Bottom Next Button
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GRPOFinalizationScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  localizations.next,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }

  Widget _buildItemCard(Map<String, dynamic> item, String poNumber, AppLocalizations localizations) {
    // Determine card color based on status
    final themeColor = Theme.of(context).primaryColor;
    Color cardColor;
    Color statusColor;
    String statusText;
    
    if (item['status'] == 'complete') {
      cardColor = const Color(0xFFE8F5E9); // Light green
      statusColor = const Color(0xFF4CAF50); // Green
      statusText = localizations.fullyReceived;
    } else if (item['status'] == 'partial') {
      cardColor = const Color(0xFFFFF8E1); // Light yellow
      statusColor = const Color(0xFFFFA726); // Orange/Yellow
      statusText = localizations.partiallyReceived;
    } else {
      cardColor = Colors.white;
      statusColor = const Color(0xFF999999); // Gray
      statusText = localizations.pending;
    }

    // Calculate progress
    final double progress = item['ordered'] > 0 ? item['received'] / item['ordered'] : 0.0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: item['status'] == 'pending' ? const Color(0xFFE0E0E0) : statusColor.withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Item Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Item Code
                      Row(
                        children: [
                          Text(
                            '${localizations.itemCode}: ',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF999999),
                            ),
                          ),
                          Text(
                            item['code'],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: themeColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Item Name
                      Text(
                        item['name'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF262626),
                        ),
                      ),
                      // Manual indicator if applicable
                      if (item['unit'] == 'Manual') ...[
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF9E9E9E).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            localizations.manual,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF9E9E9E),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Quantity
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${item['received']}.00 / ${item['ordered']} ${item['unit']}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: statusColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        statusText,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            // Progress Bar (for partial and complete)
            if (item['status'] != 'pending') ...[
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: const Color(0xFFE0E0E0),
                  valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                  minHeight: 6,
                ),
              ),
            ],
            
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),
            // Warehouse and PO Reference
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(Icons.warehouse_outlined, size: 16, color: Color(0xFF999999)),
                      const SizedBox(width: 4),
                      Text(
                        item['warehouse'],
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF595959),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.receipt_outlined, size: 16, color: Color(0xFF999999)),
                    const SizedBox(width: 4),
                    Text(
                      '${localizations.poNumber}: $poNumber',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF595959),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
