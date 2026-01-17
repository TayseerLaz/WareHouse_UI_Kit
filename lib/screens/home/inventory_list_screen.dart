import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class InventoryListScreen extends StatefulWidget {
  const InventoryListScreen({super.key});

  @override
  State<InventoryListScreen> createState() => _InventoryListScreenState();
}

class _InventoryListScreenState extends State<InventoryListScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Mock inventory data
  final List<Map<String, String>> _inventoryItems = [
    {
      'code': 'A00001',
      'name': 'J.B. Officeprint 1420',
      'authGroup': 'AG03',
      'barcode': 'ABCD123456',
    },
    {
      'code': 'A00002',
      'name': 'J.B. Officeprint 1111',
      'authGroup': 'AG01',
    },
    {
      'code': 'A00003',
      'name': 'J.B. Officeprint 1186',
      'authGroup': 'AG03',
    },
    {
      'code': 'A00004',
      'name': 'Rainbow ColorJet 5',
      'authGroup': 'AG01',
    },
    {
      'code': 'A00005',
      'name': 'Rainbow ColorJet 7.5',
      'authGroup': 'AG03',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const themeColor = Color(0xFF155096);
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
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
            decoration: const BoxDecoration(
              color: themeColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                // Header Row
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        localizations.inventoryList,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    // QR Scan Icon
                    IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(localizations.scanQR)),
                        );
                      },
                      icon: const Icon(Icons.qr_code_scanner, color: Colors.white, size: 28),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: localizations.searchInventory,
                      hintStyle: const TextStyle(color: Color(0xFF999999)),
                      prefixIcon: const Icon(Icons.search, color: Color(0xFF155096)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Inventory Items List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _inventoryItems.length,
              itemBuilder: (context, index) {
                return _buildInventoryCard(_inventoryItems[index], localizations);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInventoryCard(Map<String, String> item, AppLocalizations localizations) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.pop(context, item);
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Item Code (Primary)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF155096).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    item['code']!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF155096),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Item Name
                Text(
                  item['name']!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF262626),
                  ),
                ),
                const SizedBox(height: 12),

                // Authorization Group and Barcode
                Row(
                  children: [
                    // Authorization Group
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(Icons.security, size: 16, color: Color(0xFF999999)),
                          const SizedBox(width: 6),
                          Text(
                            '${localizations.authorizationGroup}: ',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF999999),
                            ),
                          ),
                          Text(
                            item['authGroup']!,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF595959),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Barcode (if available)
                    if (item.containsKey('barcode'))
                      Row(
                        children: [
                          const Icon(Icons.qr_code, size: 16, color: Color(0xFF999999)),
                          const SizedBox(width: 6),
                          Text(
                            item['barcode']!,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
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
        ),
      ),
    );
  }
}
