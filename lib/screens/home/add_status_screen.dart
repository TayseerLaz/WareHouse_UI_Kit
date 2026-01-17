import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class AddStatusScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const AddStatusScreen({
    super.key,
    required this.item,
  });

  @override
  State<AddStatusScreen> createState() => _AddStatusScreenState();
}

class _AddStatusScreenState extends State<AddStatusScreen> {
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  String? _selectedWarehouse;
  String? _selectedBin;
  String? _selectedStatus;
  String? _selectedBatch;

  final List<String> _warehouses = ['Bin Warehouse', 'Main Warehouse', 'Storage A'];
  final List<String> _bins = ['05-NC-NC-NC', '05-A1-S1-L2', '06-B2-S2-L1'];
  final List<String> _batches = ['2323', '2324', '2325'];
  
  // Status entries list
  final List<Map<String, dynamic>> _statusEntries = [];

  @override
  void dispose() {
    _quantityController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _handleAddQuantity() {
    if (_quantityController.text.isEmpty ||
        _selectedWarehouse == null ||
        _selectedBin == null ||
        _selectedStatus == null ||
        _selectedBatch == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    setState(() {
      _statusEntries.add({
        'warehouse': _selectedWarehouse,
        'bin': _selectedBin,
        'status': _selectedStatus,
        'batch': _selectedBatch,
        'quantity': _quantityController.text,
        'notes': _notesController.text,
      });

      // Clear form
      _quantityController.clear();
      _notesController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Quantity added to list')),
    );
  }

  void _handleDone() {
    Navigator.pop(context, _statusEntries);
  }

  @override
  Widget build(BuildContext context) {
    const themeColor = Color(0xFF155096);
    final localizations = AppLocalizations.of(context)!;

    // Get status options
    final List<Map<String, dynamic>> statusOptions = [
      {'value': 'good', 'label': localizations.good, 'color': const Color(0xFF4CAF50)},
      {'value': 'bad', 'label': localizations.bad, 'color': const Color(0xFFF44336)},
      {'value': 'damaged', 'label': localizations.damaged, 'color': const Color(0xFFFFA726)},
      {'value': 'blocked', 'label': localizations.blocked, 'color': const Color(0xFF9E9E9E)},
    ];

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
                    localizations.addStatus,
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

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Warehouse Selection
                  _buildDropdownField(
                    label: localizations.warehouse,
                    value: _selectedWarehouse,
                    hint: localizations.selectWarehouse,
                    items: _warehouses,
                    onChanged: (value) {
                      setState(() {
                        _selectedWarehouse = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  // Bin Selection
                  _buildDropdownField(
                    label: localizations.bins,
                    value: _selectedBin,
                    hint: localizations.selectBin,
                    items: _bins,
                    onChanged: (value) {
                      setState(() {
                        _selectedBin = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  // Status Selection
                  _buildStatusDropdown(localizations, statusOptions),
                  const SizedBox(height: 16),

                  // Batch/Serial Selection
                  _buildDropdownField(
                    label: localizations.batchesSerials,
                    value: _selectedBatch,
                    hint: localizations.selectBatch,
                    items: _batches,
                    onChanged: (value) {
                      setState(() {
                        _selectedBatch = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  // UOM (Read-only)
                  _buildTextField(
                    label: '${localizations.uom}: ${widget.item['unit']}',
                    enabled: false,
                  ),
                  const SizedBox(height: 16),

                  // Quantity Input
                  _buildTextField(
                    label: localizations.quantity,
                    controller: _quantityController,
                    hint: localizations.enterQuantity,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),

                  // Notes
                  _buildTextField(
                    label: localizations.notes,
                    controller: _notesController,
                    hint: localizations.enterNotes,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 24),

                  // Add Quantity Button
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _handleAddQuantity,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        localizations.addQuantity,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),

                  // Status Entries List
                  if (_statusEntries.isNotEmpty) ...[
                    const SizedBox(height: 32),
                    Text(
                      '${localizations.status} ${localizations.recordList}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF262626),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ..._statusEntries.asMap().entries.map((entry) {
                      final index = entry.key;
                      final statusEntry = entry.value;
                      return _buildStatusEntryCard(statusEntry, index, localizations, statusOptions);
                    }),
                  ],
                ],
              ),
            ),
          ),

          // Bottom Done Button
          if (_statusEntries.isNotEmpty)
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
                  onPressed: _handleDone,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    localizations.done,
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

  Widget _buildStatusEntryCard(Map<String, dynamic> entry, int index, AppLocalizations localizations, List<Map<String, dynamic>> statusOptions) {
    final statusOption = statusOptions.firstWhere((s) => s['value'] == entry['status']);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: (statusOption['color'] as Color).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            statusOption['label'],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: statusOption['color'],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${localizations.quantity}: ${entry['quantity']}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF262626),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${localizations.batch}: ${entry['batch']} | ${entry['warehouse']} | ${entry['bin']}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF595959),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _statusEntries.removeAt(index);
                  });
                },
                icon: const Icon(Icons.delete_outline, color: Color(0xFFF44336)),
              ),
            ],
          ),
          if (entry['notes'].isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              '${localizations.notes}: ${entry['notes']}',
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF595959),
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusDropdown(AppLocalizations localizations, List<Map<String, dynamic>> statusOptions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizations.status,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF595959),
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedStatus,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
          ),
          hint: Text(localizations.selectStatus),
          items: statusOptions.map((status) {
            return DropdownMenuItem<String>(
              value: status['value'],
              child: Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: status['color'],
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(status['label']),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedStatus = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required String hint,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF595959),
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
          ),
          hint: Text(hint),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    TextEditingController? controller,
    String? hint,
    TextInputType? keyboardType,
    int maxLines = 1,
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF595959),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          enabled: enabled,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            fillColor: enabled ? Colors.white : const Color(0xFFF5F5F5),
            filled: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
          ),
        ),
      ],
    );
  }
}
