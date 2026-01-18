import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'put_away_carton_list_screen.dart';
import 'put_away_confirmation_screen.dart';

class PutAwayScreen extends StatefulWidget {
  const PutAwayScreen({super.key});

  @override
  State<PutAwayScreen> createState() => _PutAwayScreenState();
}

class _PutAwayScreenState extends State<PutAwayScreen> {
  String _selectedWarehouse = 'Bin Warehouse';
  String _fromBin = '07-B3-S2-L1'; // Changed to match first item in _availableBins
  String? _selectedToBin;

  final List<String> _warehouses = [
    'Bin Warehouse',
    'Main Warehouse',
    'Cold Storage',
    'Hazmat Warehouse',
  ];

  final List<String> _availableBins = [
    '07-B3-S2-L1',
    '08-C2-S1-L3',
    '09-D1-S3-L2',
    '10-A4-S2-L1',
    '11-B2-S1-L4',
  ];

  void _showBinSelector(BuildContext context, AppLocalizations localizations) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizations.selectBin,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF262626),
              ),
            ),
            const SizedBox(height: 16),
            ..._availableBins.map((bin) => ListTile(
              leading: const Icon(Icons.inventory_2, color: Color(0xFF155096)),
              title: Text(bin),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                setState(() {
                  _selectedToBin = bin;
                });
                Navigator.pop(context);
              },
            )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const themeColor = Color(0xFF155096);
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
            decoration: const BoxDecoration(
              color: themeColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Row(
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
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Warehouse Selection
                  _buildFieldLabel(localizations.warehouse),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                    ),
                    child: DropdownButton<String>(
                      value: _selectedWarehouse,
                      isExpanded: true,
                      underline: const SizedBox(),
                      icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF999999)),
                      items: _warehouses.map((warehouse) {
                        return DropdownMenuItem(
                          value: warehouse,
                          child: Text(
                            warehouse,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF262626),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedWarehouse = value;
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 24),

                  // From Bins (Source) - Dropdown
                  _buildFieldLabel(localizations.fromBins),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                    ),
                    child: DropdownButton<String>(
                      value: _fromBin,
                      isExpanded: true,
                      underline: const SizedBox(),
                      icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF999999)),
                      items: _availableBins.map((bin) {
                        return DropdownMenuItem(
                          value: bin,
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF155096).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Icon(
                                  Icons.inventory_2,
                                  color: Color(0xFF155096),
                                  size: 18,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                bin,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF262626),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _fromBin = value;
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Select Bin Button
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_selectedToBin != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PutAwayCartonListScreen(
                                warehouse: _selectedWarehouse,
                                toBin: _selectedToBin!,
                              ),
                            ),
                          );
                        } else {
                          _showBinSelector(context, localizations);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF155096),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.add_location_alt, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            localizations.selectBin,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Proceed Button
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
                onPressed: _selectedToBin != null
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PutAwayConfirmationScreen(),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  disabledBackgroundColor: Colors.grey.shade300,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.check_circle, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      localizations.proceed,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFF595959),
      ),
    );
  }
}
