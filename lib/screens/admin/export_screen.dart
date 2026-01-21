import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class ExportScreen extends StatefulWidget {
  const ExportScreen({super.key});

  @override
  State<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends State<ExportScreen> {
  String? _selectedCompany;
  final Map<String, bool> _dataSelections = {
    'system': false,
    'items': false,
    'customers': false,
    'inbound': false,
    'outbound': false,
    'transfer': false,
    'move': false,
    'transactions': false,
  };

  final List<String> _companies = ['Pegolive_US', 'Company A', 'Company B', 'Company C'];

  void _handleExport(AppLocalizations localizations) {
    if (!_dataSelections.values.any((selected) => selected)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(localizations.selectAtLeastOne)),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localizations.exportData),
        content: Text(localizations.confirmExport),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(localizations.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(localizations.exportSuccess)),
              );
              setState(() {
                _dataSelections.updateAll((key, value) => false);
                _selectedCompany = null;
              });
            },
            child: Text(localizations.exportData),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).primaryColor;
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFE8F0FB),
      body: Column(
        children: [
          // Custom Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 60,
              bottom: 30,
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
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      localizations.exportData,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  localizations.exportFromMobileToERP,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Company Dropdown
                    _buildDropdown(
                      label: localizations.company,
                      value: _selectedCompany,
                      hint: localizations.selectCompanyToExport,
                      items: _companies,
                      onChanged: (value) {
                        setState(() {
                          _selectedCompany = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),

                    // Data Selection Label
                    Text(
                      localizations.selectDataToExport,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF595959),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Checkboxes
                    _buildCheckbox(localizations.system, 'system'),
                    _buildCheckbox(localizations.items, 'items'),
                    _buildCheckbox(localizations.customers, 'customers'),
                    _buildCheckbox(localizations.inbound, 'inbound'),
                    _buildCheckbox(localizations.outbound, 'outbound'),
                    _buildCheckbox(localizations.transfer, 'transfer'),
                    _buildCheckbox(localizations.move, 'move'),
                    _buildCheckbox(localizations.transactions, 'transactions'),

                    const SizedBox(height: 20),

                    // Export Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => _handleExport(localizations),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: themeColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: Text(
                          localizations.exportData,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
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

  Widget _buildDropdown({
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
            color: Color(0xFF595959),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            fillColor: const Color(0xFFF5F5F5),
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
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF155096), width: 1.5),
            ),
          ),
          hint: Text(hint),
          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF595959)),
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

  Widget _buildCheckbox(String label, String key) {
    return CheckboxListTile(
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 15,
          color: Color(0xFF262626),
        ),
      ),
      value: _dataSelections[key],
      onChanged: (value) {
        setState(() {
          _dataSelections[key] = value ?? false;
        });
      },
      activeColor: const Color(0xFF155096),
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
