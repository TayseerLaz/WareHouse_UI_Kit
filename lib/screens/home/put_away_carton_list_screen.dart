import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../l10n/app_localizations.dart';
import 'put_away_confirmation_screen.dart';

class PutAwayCartonListScreen extends StatefulWidget {
  final String warehouse;
  final String toBin;

  const PutAwayCartonListScreen({
    super.key,
    required this.warehouse,
    required this.toBin,
  });

  @override
  State<PutAwayCartonListScreen> createState() => _PutAwayCartonListScreenState();
}

class _PutAwayCartonListScreenState extends State<PutAwayCartonListScreen> {
  bool _multiSelectMode = false;
  
  // Mock carton data
  final List<Map<String, dynamic>> _cartons = [
    {
      'cartonId': '10606629684729',
      'itemCode': 'B10000',
      'batch': '826-B10000-gut',
      'attribute1': 'LOT-EXT-001',
      'expDate': DateTime(2026, 12, 31),
      'assignedBin': '05-A1-S1-L1',
      'putAwayProgress': 1,
      'totalRequired': 1,
      'isPutAway': true,
    },
    {
      'cartonId': '10606629684730',
      'itemCode': 'A00006',
      'batch': '827-A00006-xyz',
      'attribute1': 'LOT-EXT-002',
      'expDate': DateTime(2026, 11, 15),
      'assignedBin': null,
      'putAwayProgress': 0,
      'totalRequired': 1,
      'isPutAway': false,
    },
    {
      'cartonId': '10606629684731',
      'itemCode': 'C00010',
      'batch': '828-C00010-abc',
      'attribute1': 'LOT-EXT-003',
      'expDate': DateTime(2027, 1, 20),
      'assignedBin': null,
      'putAwayProgress': 0,
      'totalRequired': 1,
      'isPutAway': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).primaryColor;
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFE8F0FB),
      body: Column(
        children: [
          // Top Header Bar
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title Row
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        localizations.putAway,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    // Filter Icon
                    IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(localizations.filter)),
                        );
                      },
                      icon: const Icon(Icons.filter_list, color: Colors.white),
                    ),
                    // Multi-Select Icon
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _multiSelectMode = !_multiSelectMode;
                        });
                      },
                      icon: Icon(
                        _multiSelectMode ? Icons.check_box : Icons.check_box_outline_blank,
                        color: Colors.white,
                      ),
                    ),
                    // Barcode Scanner Icon
                    IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(localizations.scanBarcode)),
                        );
                      },
                      icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Warehouse and Bin Info
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoChip(
                        label: localizations.warehouse,
                        value: widget.warehouse,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildInfoChip(
                        label: localizations.toBins,
                        value: widget.toBin,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Carton List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _cartons.length,
              itemBuilder: (context, index) {
                return _buildCartonCard(_cartons[index], localizations);
              },
            ),
          ),

          // Bottom OK Button
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
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  localizations.ok,
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
    );
  }

  Widget _buildInfoChip({required String label, required String value}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartonCard(Map<String, dynamic> carton, AppLocalizations localizations) {
    final isPutAway = carton['isPutAway'] as bool;
    final progress = carton['putAwayProgress'] as int;
    final total = carton['totalRequired'] as int;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isPutAway ? const Color(0xFFE8F5E9) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPutAway 
              ? const Color(0xFF4CAF50).withValues(alpha: 0.3) 
              : const Color(0xFFE0E0E0),
          width: 2,
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
            // Header Row
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localizations.cartonId,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF999999),
                        ),
                      ),
                      Text(
                        carton['cartonId'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF155096),
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
                // Progress Indicator
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isPutAway 
                        ? const Color(0xFF4CAF50) 
                        : const Color(0xFFF44336),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '$progress / $total',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),
            // Details Grid
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem(
                    label: localizations.items,
                    value: carton['itemCode'],
                  ),
                ),
                Expanded(
                  child: _buildDetailItem(
                    label: localizations.batches,
                    value: carton['batch'],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem(
                    label: localizations.attribute1,
                    value: carton['attribute1'],
                  ),
                ),
                Expanded(
                  child: _buildDetailItem(
                    label: localizations.expDate,
                    value: DateFormat('yyyy-MM-dd').format(carton['expDate']),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildDetailItem(
              label: localizations.bin,
              value: carton['assignedBin'] ?? '—',
              valueColor: carton['assignedBin'] != null 
                  ? const Color(0xFF4CAF50) 
                  : const Color(0xFF999999),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem({
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF999999),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: valueColor ?? const Color(0xFF262626),
          ),
        ),
      ],
    );
  }
}
