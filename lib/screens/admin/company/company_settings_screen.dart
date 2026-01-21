import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import 'company_form_screen.dart';

class CompanySettingsScreen extends StatefulWidget {
  const CompanySettingsScreen({super.key});

  @override
  State<CompanySettingsScreen> createState() => _CompanySettingsScreenState();
}

class _CompanySettingsScreenState extends State<CompanySettingsScreen> {
  String _searchQuery = '';

  // Mock company data
  final List<Map<String, dynamic>> _allCompanies = [
    {
      'id': 1,
      'code': 'Pregolive_US',
      'database': 'PregoliveDB_US',
      'server': '192.168.1.100',
      'isActive': true,
    },
    {
      'id': 2,
      'code': 'Pregolive_EU',
      'database': 'PregoliveDB_EU',
      'server': '192.168.1.101',
      'isActive': false,
    },
    {
      'id': 3,
      'code': 'Warehouse_Main',
      'database': 'WarehouseDB',
      'server': '192.168.1.102',
      'isActive': false,
    },
  ];

  List<Map<String, dynamic>> get _filteredCompanies {
    if (_searchQuery.isEmpty) {
      return _allCompanies;
    }
    return _allCompanies.where((company) {
      return company['code'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  void _deleteCompany(int companyId, AppLocalizations localizations) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localizations.deleteCompany),
        content: Text(localizations.confirmDeleteCompany),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(localizations.cancel),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _allCompanies.removeWhere((company) => company['id'] == companyId);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(localizations.companyDeleted)),
              );
            },
            child: Text(
              localizations.delete,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _syncCompany(String companyCode, AppLocalizations localizations) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${localizations.companySynced}: $companyCode'),
        backgroundColor: Colors.green,
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
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      localizations.companySettings,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: localizations.searchCompanies,
                      hintStyle: const TextStyle(color: Color(0xFF999999)),
                      prefixIcon: Icon(Icons.search, color: themeColor),
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

          // Company List
          Expanded(
            child: _filteredCompanies.isEmpty
                ? Center(
                    child: Text(
                      localizations.noCompaniesFound,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF999999),
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredCompanies.length,
                    itemBuilder: (context, index) {
                      final company = _filteredCompanies[index];
                      return _buildCompanyCard(company, localizations);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CompanyFormScreen(),
            ),
          );
        },
        backgroundColor: themeColor,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          localizations.addCompany,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildCompanyCard(Map<String, dynamic> company, AppLocalizations localizations) {
    final isActive = company['isActive'] ?? false;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isActive
            ? Border.all(color: Theme.of(context).primaryColor, width: 2)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Company Icon
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.business_outlined,
                    color: Theme.of(context).primaryColor,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                // Company Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            company['code'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF262626),
                            ),
                          ),
                          if (isActive) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                localizations.active,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green[700],
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${company['database']} • ${company['server']}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF7F7F7F),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 8),
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Select/Activate Button
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      for (var c in _allCompanies) {
                        c['isActive'] = false;
                      }
                      company['isActive'] = true;
                    });
                  },
                  icon: const Icon(Icons.check_circle_outline, size: 20),
                  label: Text(localizations.selectCompany),
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(width: 8),
                // Sync Button
                IconButton(
                  onPressed: () => _syncCompany(company['code'], localizations),
                  icon: const Icon(Icons.sync, color: Colors.green),
                  tooltip: localizations.syncCompany,
                ),
                // Delete Button
                IconButton(
                  onPressed: () => _deleteCompany(company['id'], localizations),
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  tooltip: localizations.deleteCompany,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
