import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'grpo_details_screen.dart';

class GRPOScreen extends StatefulWidget {
  const GRPOScreen({super.key});

  @override
  State<GRPOScreen> createState() => _GRPOScreenState();
}

class _GRPOScreenState extends State<GRPOScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  // Mock data for purchase orders
  final List<Map<String, dynamic>> _purchaseOrders = [
    {
      'poNumber': '724',
      'vendor': 'Acme Associates',
      'amount': '11460',
      'currency': 'USD',
      'receivingDate': '2025-09-22',
    },
    {
      'poNumber': '725',
      'vendor': 'Global Supplies Ltd',
      'amount': '8750',
      'currency': 'LBP',
      'receivingDate': '2025-11-12',
    },
    {
      'poNumber': '726',
      'vendor': 'Tech Solutions Inc',
      'amount': '15200',
      'currency': 'USD',
      'receivingDate': '2025-10-05',
    },
    {
      'poNumber': '727',
      'vendor': 'Prime Distributors',
      'amount': '9340',
      'currency': 'LBP',
      'receivingDate': '2025-09-28',
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
                        localizations.grpo,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    // Refresh Icon
                    IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(localizations.refresh)),
                        );
                      },
                      icon: const Icon(Icons.refresh, color: Colors.white),
                    ),
                    // Document Icon
                    IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(localizations.createNewGRPO)),
                        );
                      },
                      icon: const Icon(Icons.description_outlined, color: Colors.white),
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
                const SizedBox(height: 16),
                
                // Search Section
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: localizations.searchGRPO,
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
                    ),
                    const SizedBox(width: 12),
                    // Advanced Filters Button
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        onPressed: () {
                          _showFilterDialog(context, localizations);
                        },
                        icon: const Icon(Icons.filter_list, color: Color(0xFF155096)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Suppliers Button (3 dots)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/suppliers');
                        },
                        icon: const Icon(Icons.more_vert, color: Color(0xFF155096)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Main GRPO Action Button
                  SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${localizations.grpo} - ${localizations.createNewGRPO}')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                      ),
                      child: Text(
                        localizations.grpo,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // List Header Labels
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            localizations.poNumber,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF595959),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            localizations.receivingDate,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF595959),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // GRPO List Cards
                  ..._purchaseOrders.map((po) => _buildPOCard(po, localizations)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context, AppLocalizations localizations) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              const Icon(Icons.filter_list, color: Color(0xFF155096)),
              const SizedBox(width: 12),
              Text(localizations.advancedFilters),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date Range
                const Text(
                  'Date Range',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF262626),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.calendar_today, size: 16),
                        label: const Text('From Date'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF155096),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.calendar_today, size: 16),
                        label: const Text('To Date'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF155096),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Vendor Filter
                Text(
                  localizations.vendor,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF262626),
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  hint: const Text('All Vendors'),
                  items: const [
                    DropdownMenuItem(value: 'all', child: Text('All Vendors')),
                    DropdownMenuItem(value: 'acme', child: Text('Acme Associates')),
                    DropdownMenuItem(value: 'global', child: Text('Global Supplies Ltd')),
                    DropdownMenuItem(value: 'tech', child: Text('Tech Solutions Inc')),
                    DropdownMenuItem(value: 'prime', child: Text('Prime Distributors')),
                  ],
                  onChanged: (value) {},
                ),
                const SizedBox(height: 20),

                // Status Filter
                const Text(
                  'Status',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF262626),
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  hint: const Text('All Status'),
                  items: const [
                    DropdownMenuItem(value: 'all', child: Text('All')),
                    DropdownMenuItem(value: 'open', child: Text('Open')),
                    DropdownMenuItem(value: 'closed', child: Text('Closed')),
                    DropdownMenuItem(value: 'pending', child: Text('Pending')),
                  ],
                  onChanged: (value) {},
                ),
                const SizedBox(height: 20),

                // Currency Filter
                Text(
                  localizations.currency,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF262626),
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  hint: const Text('All Currencies'),
                  items: const [
                    DropdownMenuItem(value: 'all', child: Text('All Currencies')),
                    DropdownMenuItem(value: 'usd', child: Text('USD')),
                    DropdownMenuItem(value: 'lbp', child: Text('LBP')),
                  ],
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Reset'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Filters applied')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF155096),
              ),
              child: const Text('Apply'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPOCard(Map<String, dynamic> po, AppLocalizations localizations) {
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GRPODetailsScreen(purchaseOrder: po),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // PO Number and Vendor
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // PO Number Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF155096).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        po['poNumber'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF155096),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            po['vendor'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF262626),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.calendar_today, size: 14, color: Colors.grey[600]),
                              const SizedBox(width: 4),
                              Text(
                                po['receivingDate'],
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Amount and Currency
                Row(
                  children: [
                    Icon(Icons.attach_money, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      '${po['amount']} ${po['currency']}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF155096),
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF999999)),
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
