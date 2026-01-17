import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class PackagePrintListScreen extends StatefulWidget {
  final Map<String, dynamic> batchRecord;

  const PackagePrintListScreen({
    super.key,
    required this.batchRecord,
  });

  @override
  State<PackagePrintListScreen> createState() => _PackagePrintListScreenState();
}

class _PackagePrintListScreenState extends State<PackagePrintListScreen> {
  // Mock package data with print status
  final List<Map<String, dynamic>> _packages = [
    {'packId': 'PKG-001', 'isPrinted': true},
    {'packId': 'PKG-002', 'isPrinted': false},
    {'packId': 'PKG-003', 'isPrinted': true},
    {'packId': 'PKG-004', 'isPrinted': false},
    {'packId': 'PKG-005', 'isPrinted': false},
  ];

  final Set<int> _selectedPackages = {};

  void _togglePackageSelection(int index) {
    setState(() {
      if (_selectedPackages.contains(index)) {
        _selectedPackages.remove(index);
      } else {
        _selectedPackages.add(index);
      }
    });
  }

  void _printSelected() {
    if (_selectedPackages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select packages to print')),
      );
      return;
    }

    setState(() {
      for (var index in _selectedPackages) {
        _packages[index]['isPrinted'] = true;
      }
      _selectedPackages.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Selected packages printed successfully')),
    );
  }

  void _printAll() {
    setState(() {
      for (var package in _packages) {
        package['isPrinted'] = true;
      }
      _selectedPackages.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All packages printed successfully')),
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
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    localizations.packageList,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Package List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              itemCount: _packages.length,
              itemBuilder: (context, index) {
                return _buildPackageCard(index, localizations);
              },
            ),
          ),

          // Bottom Action Buttons
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
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: OutlinedButton(
                      onPressed: _printSelected,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: themeColor,
                        side: const BorderSide(color: themeColor, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        localizations.printSelected,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _printAll,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFA726),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        localizations.printAll,
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
        ],
      ),
    );
  }

  Widget _buildPackageCard(int index, AppLocalizations localizations) {
    final package = _packages[index];
    final isSelected = _selectedPackages.contains(index);
    final isPrinted = package['isPrinted'] as bool;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? const Color(0xFF155096) : Colors.transparent,
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _togglePackageSelection(index),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Checkbox
                Checkbox(
                  value: isSelected,
                  onChanged: (value) => _togglePackageSelection(index),
                  activeColor: const Color(0xFF155096),
                ),
                const SizedBox(width: 12),
                // Package Icon
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFF155096).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.inventory_2,
                    color: Color(0xFF155096),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                // Package Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${localizations.packId}: ${package['packId']}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF262626),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            '${localizations.status}: ',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF999999),
                            ),
                          ),
                          Text(
                            isPrinted ? localizations.printed : localizations.notPrinted,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: isPrinted ? const Color(0xFF4CAF50) : const Color(0xFFF44336),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Print Status Icon
                Icon(
                  isPrinted ? Icons.check_circle : Icons.print_outlined,
                  color: isPrinted ? const Color(0xFF4CAF50) : const Color(0xFF999999),
                  size: 28,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
