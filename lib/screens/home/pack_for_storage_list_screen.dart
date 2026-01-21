import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../l10n/app_localizations.dart';
import 'packaging_screen.dart';

class PackForStorageListScreen extends StatefulWidget {
  const PackForStorageListScreen({super.key});

  @override
  State<PackForStorageListScreen> createState() => _PackForStorageListScreenState();
}

class _PackForStorageListScreenState extends State<PackForStorageListScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  // Mock receiving documents data
  final List<Map<String, dynamic>> _receivingDocs = [
    {
      'receivingNumber': '3',
      'supplierName': 'Far East Imports',
      'receivingDate': DateTime(2025, 8, 12),
    },
    {
      'receivingNumber': '4',
      'supplierName': 'Far East Imports',
      'receivingDate': DateTime(2025, 8, 12),
    },
    {
      'receivingNumber': '5',
      'supplierName': 'Acme Associates',
      'receivingDate': DateTime(2025, 8, 13),
    },
    {
      'receivingNumber': '12',
      'supplierName': 'Global Supplies Ltd',
      'receivingDate': DateTime(2025, 8, 14),
    },
    {
      'receivingNumber': '14',
      'supplierName': 'Tech Components Inc',
      'receivingDate': DateTime(2025, 8, 15),
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
                        '${localizations.packForStorage}...',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    // History Icon
                    IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(localizations.history)),
                        );
                      },
                      icon: const Icon(Icons.history, color: Colors.white),
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
                    // Packing Icon
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PackagingScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.inventory_2_outlined, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Search Bar
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: localizations.search,
                      hintStyle: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 14,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Receiving Documents List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _receivingDocs.length,
              itemBuilder: (context, index) {
                return _buildReceivingCard(_receivingDocs[index], localizations);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReceivingCard(Map<String, dynamic> doc, AppLocalizations localizations) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PackagingScreen(),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Receiving Number Badge
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFF155096).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      doc['receivingNumber'],
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF155096),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Supplier Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${localizations.receivingNumber}: ${doc['receivingNumber']}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF999999),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        doc['supplierName'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF262626),
                        ),
                      ),
                    ],
                  ),
                ),
                // Receiving Date
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Color(0xFF999999),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DateFormat('yyyy-MM-dd').format(doc['receivingDate']),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF595959),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Color(0xFF999999),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
