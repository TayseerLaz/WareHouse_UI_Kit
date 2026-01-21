import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';

class AuthorizationsScreen extends StatefulWidget {
  const AuthorizationsScreen({super.key});

  @override
  State<AuthorizationsScreen> createState() => _AuthorizationsScreenState();
}

class _AuthorizationsScreenState extends State<AuthorizationsScreen> {
  String _searchQuery = '';

  // Mock roles data
  final List<Map<String, dynamic>> _allRoles = [
    {'id': 1, 'name': 'User', 'icon': Icons.person_outline},
    {'id': 2, 'name': 'Manager', 'icon': Icons.manage_accounts_outlined},
    {'id': 3, 'name': 'Representative', 'icon': Icons.support_agent_outlined},
    {'id': 4, 'name': 'Warehouse-keeper', 'icon': Icons.warehouse_outlined},
    {'id': 5, 'name': 'Clerk', 'icon': Icons.assignment_ind_outlined},
    {'id': 6, 'name': 'w-clerk', 'icon': Icons.inventory_outlined},
    {'id': 7, 'name': 'hy', 'icon': Icons.badge_outlined},
  ];

  List<Map<String, dynamic>> get _filteredRoles {
    if (_searchQuery.isEmpty) {
      return _allRoles;
    }
    return _allRoles.where((role) {
      return role['name'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
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
                      localizations.authorizations,
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
                      hintText: localizations.searchRoles,
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

          // Roles List
          Expanded(
            child: _filteredRoles.isEmpty
                ? Center(
                    child: Text(
                      localizations.noRolesFound,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF999999),
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredRoles.length,
                    itemBuilder: (context, index) {
                      final role = _filteredRoles[index];
                      return _buildRoleCard(role, localizations);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleCard(Map<String, dynamic> role, AppLocalizations localizations) {
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
            Navigator.pushNamed(
              context,
              '/authorization_details',
              arguments: role,
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Profile Icon
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.person_outline,
                    color: Theme.of(context).primaryColor,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                // Role Name
                Expanded(
                  child: Text(
                    role['name'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF262626),
                    ),
                  ),
                ),
                // Edit Icon
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.edit_note_outlined,
                    color: Theme.of(context).primaryColor,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
