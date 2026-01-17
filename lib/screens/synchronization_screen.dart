import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class SynchronizationScreen extends StatefulWidget {
  const SynchronizationScreen({super.key});

  @override
  State<SynchronizationScreen> createState() => _SynchronizationScreenState();
}

class _SynchronizationScreenState extends State<SynchronizationScreen> {
  // Import section state
  String? _importCompany;
  final Map<String, bool> _importData = {
    'system': false,
    'items': false,
    'customers': false,
    'inbound': false,
    'outbound': false,
    'transfer': false,
    'move': false,
    'transactions': false,
  };

  // Export section state
  String? _exportCompany;
  final Map<String, bool> _exportData = {
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

  void _handleImport(AppLocalizations localizations) {
    if (!_importData.values.any((selected) => selected)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(localizations.selectAtLeastOne)),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localizations.importData),
        content: Text(localizations.confirmImport),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(localizations.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(localizations.importSuccess)),
              );
              // Reset selections
              setState(() {
                _importData.updateAll((key, value) => false);
                _importCompany = null;
              });
            },
            child: Text(localizations.importData),
          ),
        ],
      ),
    );
  }

  void _handleExport(AppLocalizations localizations) {
    if (!_exportData.values.any((selected) => selected)) {
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
              // Reset selections
              setState(() {
                _exportData.updateAll((key, value) => false);
                _exportCompany = null;
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
    const themeColor = Color(0xFF155096);
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
                Text(
                  localizations.synchronization,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
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
                  // Import Section
                  _buildSyncSection(
                    title: localizations.importFromERPToMobile,
                    icon: Icons.download_outlined,
                    iconColor: Colors.green,
                    company: _importCompany,
                    companyHint: localizations.selectCompanyToImport,
                    dataSelections: _importData,
                    dataLabel: localizations.selectDataToImport,
                    onCompanyChanged: (value) {
                      setState(() {
                        _importCompany = value;
                      });
                    },
                    onDataChanged: (key, value) {
                      setState(() {
                        _importData[key] = value ?? false;
                      });
                    },
                    buttonLabel: localizations.importData,
                    onButtonPressed: () => _handleImport(localizations),
                    localizations: localizations,
                  ),

                  const SizedBox(height: 32),

                  // Export Section
                  _buildSyncSection(
                    title: localizations.exportFromMobileToERP,
                    icon: Icons.upload_outlined,
                    iconColor: Colors.blue,
                    company: _exportCompany,
                    companyHint: localizations.selectCompanyToExport,
                    dataSelections: _exportData,
                    dataLabel: localizations.selectDataToExport,
                    onCompanyChanged: (value) {
                      setState(() {
                        _exportCompany = value;
                      });
                    },
                    onDataChanged: (key, value) {
                      setState(() {
                        _exportData[key] = value ?? false;
                      });
                    },
                    buttonLabel: localizations.exportData,
                    onButtonPressed: () => _handleExport(localizations),
                    localizations: localizations,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSyncSection({
    required String title,
    required IconData icon,
    required Color iconColor,
    required String? company,
    required String companyHint,
    required Map<String, bool> dataSelections,
    required String dataLabel,
    required void Function(String?) onCompanyChanged,
    required void Function(String, bool?) onDataChanged,
    required String buttonLabel,
    required VoidCallback onButtonPressed,
    required AppLocalizations localizations,
  }) {
    return Container(
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
          // Section Title
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF262626),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Company Dropdown
          _buildDropdown(
            label: localizations.company,
            value: company,
            hint: companyHint,
            items: _companies,
            onChanged: onCompanyChanged,
          ),
          const SizedBox(height: 20),

          // Data Selection Label
          Text(
            dataLabel,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF595959),
            ),
          ),
          const SizedBox(height: 12),

          // Checkboxes
          _buildCheckbox(localizations.system, 'system', dataSelections, onDataChanged),
          _buildCheckbox(localizations.items, 'items', dataSelections, onDataChanged),
          _buildCheckbox(localizations.customers, 'customers', dataSelections, onDataChanged),
          _buildCheckbox(localizations.inbound, 'inbound', dataSelections, onDataChanged),
          _buildCheckbox(localizations.outbound, 'outbound', dataSelections, onDataChanged),
          _buildCheckbox(localizations.transfer, 'transfer', dataSelections, onDataChanged),
          _buildCheckbox(localizations.move, 'move', dataSelections, onDataChanged),
          _buildCheckbox(localizations.transactions, 'transactions', dataSelections, onDataChanged),

          const SizedBox(height: 20),

          // Action Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: onButtonPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: iconColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              child: Text(
                buttonLabel,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
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

  Widget _buildCheckbox(
    String label,
    String key,
    Map<String, bool> selections,
    void Function(String, bool?) onChanged,
  ) {
    return CheckboxListTile(
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 15,
          color: Color(0xFF262626),
        ),
      ),
      value: selections[key],
      onChanged: (value) => onChanged(key, value),
      activeColor: const Color(0xFF155096),
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
