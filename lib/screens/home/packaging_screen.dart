import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'pack_for_storage_screen.dart';

class PackagingScreen extends StatefulWidget {
  const PackagingScreen({super.key});

  @override
  State<PackagingScreen> createState() => _PackagingScreenState();
}

class _PackagingScreenState extends State<PackagingScreen> {
  bool _viewMode = false;
  bool _selectionMode = false;
  Set<String> _selectedCartons = {};
  Set<String> _selectedItems = {};
  
  // Mock carton data - 3 cartons with varying item counts
  final List<Map<String, dynamic>> _cartons = [
    {
      'cartonId': '72248636074685',
      'cartonName': 'Carton_791',
      'isPrinted': false,
      'items': [
        {
          'code': 'B10000',
          'name': 'Printer Label',
          'batch': '826-B10000-gut',
          'quantity': 24,
          'isPrinted': false,
        },
        {
          'code': 'A00006',
          'name': 'Rainbow 1200 Laser Series',
          'batch': '827-A00006-xyz',
          'quantity': 12,
          'isPrinted': false,
        },
        {
          'code': 'C00010',
          'name': 'Mouse USB',
          'batch': '828-C00010-abc',
          'quantity': 50,
          'isPrinted': false,
        },
      ],
    },
    {
      'cartonId': '72248636074686',
      'cartonName': 'Carton_792',
      'isPrinted': true,
      'items': [
        {
          'code': 'D00015',
          'name': 'Keyboard Wireless',
          'batch': '829-D00015-def',
          'quantity': 30,
          'isPrinted': true,
        },
        {
          'code': 'E00020',
          'name': 'Monitor Stand',
          'batch': '830-E00020-ghi',
          'quantity': 15,
          'isPrinted': true,
        },
      ],
    },
    {
      'cartonId': '72248636074687',
      'cartonName': 'Carton_793',
      'isPrinted': true,
      'items': [
        {
          'code': 'F00025',
          'name': 'HDMI Cable 2m',
          'batch': '831-F00025-jkl',
          'quantity': 100,
          'isPrinted': true,
        },
      ],
    },
  ];

  void _showInfoDialog(BuildContext context, AppLocalizations localizations) {
    final totalCartons = _cartons.length;
    final totalQty = _cartons.fold<int>(
      0,
      (sum, carton) => sum + (carton['items'] as List).fold<int>(
        0,
        (itemSum, item) => itemSum + (item['quantity'] as int),
      ),
    );
    final printedCartons = _cartons.where((c) => c['isPrinted'] == true).length;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(localizations.info),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${localizations.totalCartons}: $totalCartons'),
            const SizedBox(height: 8),
            Text('${localizations.totalQuantity}: $totalQty'),
            const SizedBox(height: 8),
            Text('${localizations.printStatus}: $printedCartons / $totalCartons ${localizations.printed}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(localizations.ok),
          ),
        ],
      ),
    );
  }

  void _printSelected() {
    if (_selectionMode) {
      // Print selected items only
      int printedCount = 0;
      setState(() {
        for (var carton in _cartons) {
          if (_selectedCartons.contains(carton['cartonId'])) {
            carton['isPrinted'] = true;
            for (var item in carton['items']) {
              item['isPrinted'] = true;
              printedCount++;
            }
          } else {
            for (var item in carton['items']) {
              final itemKey = '${carton['cartonId']}_${item['code']}';
              if (_selectedItems.contains(itemKey)) {
                item['isPrinted'] = true;
                printedCount++;
              }
            }
          }
        }
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$printedCount labels printed successfully')),
      );
    } else {
      // Print all
      setState(() {
        for (var carton in _cartons) {
          carton['isPrinted'] = true;
          for (var item in carton['items']) {
            item['isPrinted'] = true;
          }
        }
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All labels printed successfully')),
      );
    }
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
                        localizations.packaging,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Search Bar and Action Icons Row
                Row(
                  children: [
                    // Search Bar
                    Expanded(
                      child: Container(
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
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: localizations.searchCartons,
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
                    ),
                    const SizedBox(width: 12),
                    // Action Icons
                    // View Icon
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _viewMode = !_viewMode;
                        });
                      },
                      icon: Icon(
                        _viewMode ? Icons.visibility : Icons.visibility_outlined,
                        color: Colors.white,
                      ),
                    ),
                    // Print Icon
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _selectionMode = !_selectionMode;
                          if (!_selectionMode) {
                            _selectedCartons.clear();
                            _selectedItems.clear();
                          }
                        });
                      },
                      icon: Icon(
                        Icons.print,
                        color: _selectionMode ? Colors.amber : Colors.white,
                      ),
                    ),
                    // Cancel Selection Mode
                    if (_selectionMode)
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _selectionMode = false;
                            _selectedCartons.clear();
                            _selectedItems.clear();
                          });
                        },
                        icon: const Icon(Icons.close, color: Colors.white),
                      ),
                    // Info Icon
                    IconButton(
                      onPressed: () => _showInfoDialog(context, localizations),
                      icon: const Icon(Icons.info_outline, color: Colors.white),
                    ),
                    // Add Icon
                    IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(localizations.addCarton)),
                        );
                      },
                      icon: const Icon(Icons.add_circle_outline, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _cartons.length,
              itemBuilder: (context, index) {
                return _buildCartonCard(_cartons[index], index, localizations);
              },
            ),
          ),

          // Bottom Button Area
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: _selectionMode ? Colors.amber.shade100 : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Selection Info Banner (when in selection mode)
                if (_selectionMode) ...[
                  Row(
                    children: [
                      Icon(Icons.touch_app, color: themeColor, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Select packages or items to print',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.amber.shade900,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: themeColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${_selectedCartons.length + _selectedItems.where((item) => !_selectedCartons.any((carton) => item.startsWith(carton))).length} selected',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
                // Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _selectionMode
                        ? (_selectedCartons.isNotEmpty || _selectedItems.isNotEmpty)
                            ? () {
                                _printSelected();
                                setState(() {
                                  _selectionMode = false;
                                  _selectedCartons.clear();
                                  _selectedItems.clear();
                                });
                              }
                            : null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PackForStorageScreen(),
                              ),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectionMode ? themeColor : themeColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      disabledBackgroundColor: Colors.grey.shade300,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _selectionMode ? Icons.print : Icons.arrow_forward,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _selectionMode ? localizations.print : localizations.next,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
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

  Widget _buildCartonCard(Map<String, dynamic> carton, int index, AppLocalizations localizations) {
    final themeColor = Theme.of(context).primaryColor;
    final isPrinted = carton['isPrinted'] as bool;
    final items = carton['items'] as List<Map<String, dynamic>>;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Carton Header - Main Info
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isPrinted 
                  ? [const Color(0xFF4CAF50), const Color(0xFF66BB6A)]
                  : [const Color(0xFFFFA726), const Color(0xFFFFB74D)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Selection Checkbox
                    if (_selectionMode) ...[
                      Checkbox(
                        value: _selectedCartons.contains(carton['cartonId']),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == true) {
                              _selectedCartons.add(carton['cartonId']);
                              // Auto-select all items in this carton
                              for (var item in items) {
                                _selectedItems.add('${carton['cartonId']}_${item['code']}');
                              }
                            } else {
                              _selectedCartons.remove(carton['cartonId']);
                              // Deselect all items in this carton
                              for (var item in items) {
                                _selectedItems.remove('${carton['cartonId']}_${item['code']}');
                              }
                            }
                          });
                        },
                        fillColor: WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.selected)) {
                            return Colors.white;
                          }
                          return Colors.white.withValues(alpha: 0.5);
                        }),
                        checkColor: isPrinted ? const Color(0xFF4CAF50) : const Color(0xFFFFA726),
                      ),
                      const SizedBox(width: 8),
                    ],
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.inventory_2,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${localizations.carton} ${carton['cartonName']}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            carton['cartonId'],
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white.withValues(alpha: 0.9),
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isPrinted ? Icons.check_circle : Icons.print_disabled,
                            size: 16,
                            color: isPrinted ? const Color(0xFF4CAF50) : const Color(0xFFFFA726),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            isPrinted ? localizations.printed : localizations.notPrinted,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: isPrinted ? const Color(0xFF4CAF50) : const Color(0xFFFFA726),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Package Summary Section
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PACKAGE SUMMARY',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF999999),
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 16),
                // Summary Grid
                Row(
                  children: [
                    Expanded(
                      child: _buildSummaryItem(
                        icon: Icons.inventory_outlined,
                        label: localizations.totalQuantity,
                        value: '${items.fold<int>(0, (sum, item) => sum + (item['quantity'] as int))}',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildSummaryItem(
                        icon: Icons.category_outlined,
                        label: localizations.items,
                        value: '${items.length}',
                      ),
                    ),
                  ],
                ),
                if (items.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  const Divider(height: 1),
                  const SizedBox(height: 16),
                  // Item Details
                  _buildInfoRow(
                    label: localizations.code,
                    value: items.map((item) => item['code']).join(', '),
                  ),
                  const SizedBox(height: 8),
                  _buildInfoRow(
                    label: localizations.name,
                    value: items.map((item) => item['name']).join(', '),
                  ),
                  const SizedBox(height: 8),
                  _buildInfoRow(
                    label: localizations.batch,
                    value: items.map((item) => item['batch']).join(', '),
                  ),
                ],
              ],
            ),
          ),

          // Carton Actions Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFFF8F9FA),
              border: Border(
                bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${items.length} ${items.length == 1 ? localizations.item : localizations.items}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF595959),
                    ),
                  ),
                ),
                // Print Package Button
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      carton['isPrinted'] = true;
                      for (var item in items) {
                        item['isPrinted'] = true;
                      }
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${localizations.carton} ${carton['cartonName']} ${localizations.printed}')),
                    );
                  },
                  icon: const Icon(Icons.print, size: 18),
                  label: Text(localizations.print),
                  style: TextButton.styleFrom(
                    foregroundColor: themeColor,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
                const SizedBox(width: 8),
                // Edit Button
                TextButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(localizations.editCarton)),
                    );
                  },
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  label: Text(localizations.edit),
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF4CAF50),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
                const SizedBox(width: 8),
                // Delete Button
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _cartons.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(localizations.deleteCarton)),
                    );
                  },
                  icon: const Icon(Icons.delete_outline, size: 18),
                  label: Text(localizations.delete),
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFFF44336),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              ],
            ),
          ),

          // Items Section
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizations.items.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF999999),
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                ...items.asMap().entries.map((entry) {
                  final itemIndex = entry.key;
                  final item = entry.value;
                  return _buildItemCard(item, index, itemIndex, localizations);
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemCard(Map<String, dynamic> item, int cartonIndex, int itemIndex, AppLocalizations localizations) {
    final themeColor = Theme.of(context).primaryColor;
    final isPrinted = item['isPrinted'] as bool;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isPrinted ? const Color(0xFF4CAF50).withValues(alpha: 0.3) : const Color(0xFFE0E0E0),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Item Header
          Row(
            children: [
              // Selection Checkbox
              if (_selectionMode) ...[
                Checkbox(
                  value: _selectedItems.contains('${_cartons[cartonIndex]['cartonId']}_${item['code']}'),
                  onChanged: (bool? value) {
                    setState(() {
                      final itemKey = '${_cartons[cartonIndex]['cartonId']}_${item['code']}';
                      if (value == true) {
                        _selectedItems.add(itemKey);
                        // Check if all items in carton are selected
                        final cartonItems = _cartons[cartonIndex]['items'] as List;
                        final allSelected = cartonItems.every((i) => 
                          _selectedItems.contains('${_cartons[cartonIndex]['cartonId']}_${i['code']}')
                        );
                        if (allSelected) {
                          _selectedCartons.add(_cartons[cartonIndex]['cartonId']);
                        }
                      } else {
                        _selectedItems.remove(itemKey);
                        _selectedCartons.remove(_cartons[cartonIndex]['cartonId']);
                      }
                    });
                  },
                  fillColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return themeColor;
                    }
                    return null;
                  }),
                ),
                const SizedBox(width: 8),
              ],
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: themeColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.inventory,
                  size: 20,
                  color: Color(0xFF155096),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          item['code'],
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF155096),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          isPrinted ? Icons.check_circle : Icons.radio_button_unchecked,
                          size: 16,
                          color: isPrinted ? const Color(0xFF4CAF50) : const Color(0xFF999999),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item['name'],
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF595959),
                      ),
                    ),
                  ],
                ),
              ),
              // Print Item Button
              IconButton(
                onPressed: () {
                  setState(() {
                    item['isPrinted'] = true;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${item['code']} ${localizations.printed}')),
                  );
                },
                icon: Icon(
                  Icons.print,
                  color: isPrinted ? const Color(0xFF4CAF50) : const Color(0xFF155096),
                  size: 20,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                tooltip: localizations.print,
              ),
              const SizedBox(width: 8),
              // Remove Item Button
              IconButton(
                onPressed: () {
                  setState(() {
                    _cartons[cartonIndex]['items'].removeAt(itemIndex);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Item removed from carton')),
                  );
                },
                icon: const Icon(Icons.close, color: Color(0xFF999999), size: 20),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFE0E0E0)),
          const SizedBox(height: 12),
          // Item Details Grid
          Row(
            children: [
              Expanded(
                child: _buildDetailItem(
                  label: localizations.batch,
                  value: item['batch'],
                  icon: Icons.qr_code_2,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildDetailItem(
                  label: localizations.quantity,
                  value: '${item['quantity']}',
                  icon: Icons.numbers,
                  valueColor: const Color(0xFF155096),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem({
    required String label,
    required String value,
    required IconData icon,
    Color? valueColor,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16, color: const Color(0xFF999999)),
        const SizedBox(width: 6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF999999),
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: valueColor ?? const Color(0xFF262626),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF155096).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: const Color(0xFF155096)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
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
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF155096),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            '$label:',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF999999),
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF262626),
            ),
          ),
        ),
      ],
    );
  }
}
