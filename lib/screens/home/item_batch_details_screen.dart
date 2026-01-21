import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'package_print_list_screen.dart';
import 'add_status_screen.dart';
import 'grpo_review_screen.dart';

class ItemBatchDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const ItemBatchDetailsScreen({
    super.key,
    required this.item,
  });

  @override
  State<ItemBatchDetailsScreen> createState() => _ItemBatchDetailsScreenState();
}

class _ItemBatchDetailsScreenState extends State<ItemBatchDetailsScreen> {
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _batchController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  String? _selectedWarehouse;
  String? _selectedBin;
  DateTime? _productionDate;
  DateTime? _expiryDate;
  bool _showValidationError = false;

  final List<String> _warehouses = ['Bin Warehouse', 'Main Warehouse', 'Storage A'];
  final List<String> _bins = ['05-A1-S1-L2', '05-A1-S1-L3', '06-B2-S2-L1', '07-C3-S1-L4'];

  // List to store added batch records
  final List<Map<String, dynamic>> _batchRecords = [
    {
      'quantity': '1.00',
      'batch': '2323',
      'prodDate': '',
      'expDate': '2025-12-31',
      'notes': '',
    },
  ];

  @override
  void dispose() {
    _quantityController.dispose();
    _batchController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _handleAddBatch() {
    if (_quantityController.text.isEmpty ||
        _batchController.text.isEmpty ||
        _selectedWarehouse == null ||
        _selectedBin == null) {
      setState(() {
        _showValidationError = true;
      });
      return;
    }

    setState(() {
      _showValidationError = false;
      _batchRecords.add({
        'quantity': _quantityController.text,
        'batch': _batchController.text,
        'prodDate': _productionDate != null
            ? '${_productionDate!.year}-${_productionDate!.month.toString().padLeft(2, '0')}-${_productionDate!.day.toString().padLeft(2, '0')}'
            : '',
        'expDate': _expiryDate != null
            ? '${_expiryDate!.year}-${_expiryDate!.month.toString().padLeft(2, '0')}-${_expiryDate!.day.toString().padLeft(2, '0')}'
            : '',
        'notes': _notesController.text,
      });

      // Clear form
      _quantityController.clear();
      _batchController.clear();
      _notesController.clear();
      _productionDate = null;
      _expiryDate = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Batch added to list')),
    );
  }

  void _handleOK() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GRPOReviewScreen(
          purchaseOrder: {'poNumber': '724'},
        ),
      ),
    );
  }

  void _showAttachmentDialog(BuildContext context, AppLocalizations localizations) {
    showDialog(
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
                Text(
                  localizations.addPhoto,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF262626),
                  ),
                ),
                const SizedBox(height: 24),
                // Take Photo Option
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(localizations.takePhoto)),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF155096).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.camera_alt, color: Color(0xFF155096), size: 28),
                        const SizedBox(width: 16),
                        Text(
                          localizations.takePhoto,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF155096),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Choose from Gallery Option
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(localizations.chooseFromGallery)),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.photo_library, color: Color(0xFF4CAF50), size: 28),
                        const SizedBox(width: 16),
                        Text(
                          localizations.chooseFromGallery,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF4CAF50),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Cancel Button
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
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
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).primaryColor;
    final localizations = AppLocalizations.of(context)!;

    // Calculate remaining quantity (mock data)
    final remainingCartons = widget.item['ordered'] - widget.item['received'];
    final remainingUnits = remainingCartons * 24; // Assuming 24 units per carton

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
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    widget.item['code'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                // Scan Icon
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(localizations.scanQR)),
                    );
                  },
                  icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
                ),
                // Attachment Icon
                IconButton(
                  onPressed: () {
                    _showAttachmentDialog(context, localizations);
                  },
                  icon: const Icon(Icons.attach_file, color: Colors.white),
                ),
                // Notes Icon
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddStatusScreen(item: widget.item),
                      ),
                    );
                  },
                  icon: const Icon(Icons.comment_outlined, color: Colors.white),
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
                  // Item Information Card
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.item['code']} ${widget.item['name']}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF262626),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '${localizations.remainingQty}: $remainingCartons.00 ${widget.item['unit']} $remainingUnits.00',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF595959),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Form Fields
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

                  _buildTextField(
                    label: '${localizations.uom}: ${widget.item['unit']}',
                    enabled: false,
                  ),
                  const SizedBox(height: 16),

                  _buildTextField(
                    label: localizations.quantity,
                    controller: _quantityController,
                    hint: localizations.enterQuantity,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),

                  _buildTextField(
                    label: localizations.batch,
                    controller: _batchController,
                    hint: localizations.enterBatch,
                  ),
                  const SizedBox(height: 16),

                  _buildDateField(
                    label: localizations.productionDate,
                    date: _productionDate,
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (date != null) {
                        setState(() {
                          _productionDate = date;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),

                  _buildDateField(
                    label: localizations.expiryDate,
                    date: _expiryDate,
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now().add(const Duration(days: 365)),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2035),
                      );
                      if (date != null) {
                        setState(() {
                          _expiryDate = date;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),

                  _buildTextField(
                    label: localizations.notes,
                    controller: _notesController,
                    hint: localizations.enterNotes,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 24),

                  // Add Batch Button
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _handleAddBatch,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        localizations.addBatch,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),

                  // Validation Error
                  if (_showValidationError)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.error_outline, color: Colors.red, size: 20),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                localizations.pleaseFillAllFields,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  const SizedBox(height: 32),

                  // Record List Section
                  Text(
                    localizations.recordList,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF262626),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Batch Records
                  if (_batchRecords.isEmpty)
                    Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          localizations.noBatchesAdded,
                          style: const TextStyle(
                            color: Color(0xFF999999),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    )
                  else
                    ..._batchRecords.asMap().entries.map((entry) {
                      final index = entry.key;
                      final record = entry.value;
                      return _buildBatchRecord(record, index, localizations);
                    }),

                  const SizedBox(height: 24),

                  // OK Confirmation Button
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _handleOK,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4CAF50),
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
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBatchRecord(Map<String, dynamic> record, int index, AppLocalizations localizations) {
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
                    Text(
                      '${localizations.quantity}: ${record['quantity']}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF155096),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${localizations.batch}: ${record['batch']}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF262626),
                      ),
                    ),
                  ],
                ),
              ),
              // Action Icons
              Row(
                children: [
                  // Print Icon (Yellow)
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PackagePrintListScreen(batchRecord: record),
                        ),
                      );
                    },
                    icon: const Icon(Icons.print, color: Color(0xFFFFA726)),
                  ),
                  // Info Icon (Green)
                  IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${localizations.info} ${record['batch']}')),
                      );
                    },
                    icon: const Icon(Icons.info_outline, color: Color(0xFF4CAF50)),
                  ),
                  // Edit Icon (Blue)
                  IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${localizations.edit} ${record['batch']}')),
                      );
                    },
                    icon: const Icon(Icons.edit_outlined, color: Color(0xFF155096)),
                  ),
                  // Delete Icon (Red)
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _batchRecords.removeAt(index);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${localizations.delete} ${record['batch']}')),
                      );
                    },
                    icon: const Icon(Icons.delete_outline, color: Color(0xFFF44336)),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 12),
          // Dates and Notes
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${localizations.prodDate}: ${record['prodDate'].isEmpty ? '-' : record['prodDate']}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF595959),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${localizations.expDate}: ${record['expDate'].isEmpty ? '-' : record['expDate']}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF595959),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (record['notes'].isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              '${localizations.notes}: ${record['notes']}',
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

  Widget _buildDateField({
    required String label,
    required DateTime? date,
    required VoidCallback onTap,
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
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE0E0E0)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    date != null
                        ? '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}'
                        : 'Select date',
                    style: TextStyle(
                      fontSize: 14,
                      color: date != null ? const Color(0xFF262626) : const Color(0xFF999999),
                    ),
                  ),
                ),
                const Icon(Icons.calendar_today, size: 20, color: Color(0xFF155096)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
