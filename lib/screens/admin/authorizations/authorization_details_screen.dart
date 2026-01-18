import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';

class AuthorizationDetailsScreen extends StatefulWidget {
  const AuthorizationDetailsScreen({super.key});

  @override
  State<AuthorizationDetailsScreen> createState() => _AuthorizationDetailsScreenState();
}

class _AuthorizationDetailsScreenState extends State<AuthorizationDetailsScreen> {
  // Permission state management - now with sub-permissions
  final Map<String, Map<String, bool>> _permissions = {
    'administration': {'create': false, 'view': false, 'edit': false, 'delete': false},
    'synchronization': {'create': false, 'view': false, 'edit': false, 'delete': false},
    'receivingFromVendor': {'create': false, 'view': false, 'edit': false, 'delete': false},
    'returnToVendor': {'create': false, 'view': false, 'edit': false, 'delete': false},
    'deliveryToCustomer': {'create': false, 'view': false, 'edit': false, 'delete': false},
    'returnFromCustomer': {'create': false, 'view': false, 'edit': false, 'delete': false},
    'inventoryTransfer': {'create': false, 'view': false, 'edit': false, 'delete': false},
    'inventoryTransferIn': {'create': false, 'view': false, 'edit': false, 'delete': false},
    'inventoryMove': {'create': false, 'view': false, 'edit': false, 'delete': false},
    'goodReceipts': {'create': false, 'view': false, 'edit': false, 'delete': false},
    'goodIssue': {'create': false, 'view': false, 'edit': false, 'delete': false},
    'transactions': {'create': false, 'view': false, 'edit': false, 'delete': false},
  };

  void _toggleSubPermission(String moduleKey, String action) {
    setState(() {
      _permissions[moduleKey]![action] = !_permissions[moduleKey]![action]!;
    });
  }

  void _toggleAllSubPermissions(String moduleKey, bool value) {
    setState(() {
      _permissions[moduleKey]!['create'] = value;
      _permissions[moduleKey]!['view'] = value;
      _permissions[moduleKey]!['edit'] = value;
      _permissions[moduleKey]!['delete'] = value;
    });
  }

  bool _hasAnyPermission(String moduleKey) {
    final perms = _permissions[moduleKey]!;
    return perms['create']! || perms['view']! || perms['edit']! || perms['delete']!;
  }

  bool _hasAllPermissions(String moduleKey) {
    final perms = _permissions[moduleKey]!;
    return perms['create']! && perms['view']! && perms['edit']! && perms['delete']!;
  }

  void _updatePermissions() {
    final localizations = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(localizations.permissionsUpdated),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    const themeColor = Color(0xFF155096);
    final localizations = AppLocalizations.of(context)!;
    
    // Get role data from navigation arguments
    final role = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final roleName = role?['name'] ?? 'Unknown Role';

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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localizations.editPermissions,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${localizations.permissionsFor} $roleName',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Permissions List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildPermissionCard(
                  localizations.administrationPermission,
                  'administration',
                  Icons.admin_panel_settings_outlined,
                ),
                const SizedBox(height: 12),
                _buildPermissionCard(
                  localizations.synchronizationPermission,
                  'synchronization',
                  Icons.sync_outlined,
                ),
                const SizedBox(height: 12),
                _buildPermissionCard(
                  localizations.receivingFromVendorPermission,
                  'receivingFromVendor',
                  Icons.move_to_inbox_outlined,
                ),
                const SizedBox(height: 12),
                _buildPermissionCard(
                  localizations.returnToVendorPermission,
                  'returnToVendor',
                  Icons.keyboard_return_outlined,
                ),
                const SizedBox(height: 12),
                _buildPermissionCard(
                  localizations.deliveryToCustomerPermission,
                  'deliveryToCustomer',
                  Icons.local_shipping_outlined,
                ),
                const SizedBox(height: 12),
                _buildPermissionCard(
                  localizations.returnFromCustomerPermission,
                  'returnFromCustomer',
                  Icons.assignment_return_outlined,
                ),
                const SizedBox(height: 12),
                _buildPermissionCard(
                  localizations.inventoryTransferPermission,
                  'inventoryTransfer',
                  Icons.swap_horiz_outlined,
                ),
                const SizedBox(height: 12),
                _buildPermissionCard(
                  localizations.inventoryTransferInPermission,
                  'inventoryTransferIn',
                  Icons.input_outlined,
                ),
                const SizedBox(height: 12),
                _buildPermissionCard(
                  localizations.inventoryMovePermission,
                  'inventoryMove',
                  Icons.drive_file_move_outlined,
                ),
                const SizedBox(height: 12),
                _buildPermissionCard(
                  localizations.goodReceiptsPermission,
                  'goodReceipts',
                  Icons.receipt_long_outlined,
                ),
                const SizedBox(height: 12),
                _buildPermissionCard(
                  localizations.goodIssuePermission,
                  'goodIssue',
                  Icons.output_outlined,
                ),
                const SizedBox(height: 12),
                _buildPermissionCard(
                  localizations.transactionsPermission,
                  'transactions',
                  Icons.list_alt_outlined,
                ),
                const SizedBox(height: 80), // Space for buttons
              ],
            ),
          ),
        ],
      ),
      // Bottom Action Buttons
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
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
        child: SafeArea(
          child: Row(
            children: [
              // Cancel Button
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: Color(0xFF155096), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    localizations.cancel,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF155096),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Update Button
              Expanded(
                child: ElevatedButton(
                  onPressed: _updatePermissions,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: const Color(0xFF155096),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    localizations.update,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPermissionCard(String title, String key, IconData icon) {
    final hasAnyPermission = _hasAnyPermission(key);
    final hasAllPermissions = _hasAllPermissions(key);

    return Container(
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
      child: ExpansionTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: hasAnyPermission
                ? const Color(0xFF155096).withValues(alpha: 0.1)
                : Colors.grey.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: hasAnyPermission ? const Color(0xFF155096) : Colors.grey,
            size: 24,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF262626),
          ),
        ),
        trailing: Checkbox(
          value: hasAllPermissions,
          tristate: true,
          onChanged: (value) {
            _toggleAllSubPermissions(key, value ?? false);
          },
          activeColor: const Color(0xFF155096),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              children: [
                const Divider(),
                const SizedBox(height: 8),
                _buildSubPermission('Create', key, 'create'),
                _buildSubPermission('View', key, 'view'),
                _buildSubPermission('Edit', key, 'edit'),
                _buildSubPermission('Delete', key, 'delete'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubPermission(String label, String moduleKey, String action) {
    final isGranted = _permissions[moduleKey]![action] ?? false;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            Icons.subdirectory_arrow_right,
            size: 16,
            color: Colors.grey[600],
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF262626),
              ),
            ),
          ),
          Checkbox(
            value: isGranted,
            onChanged: (value) => _toggleSubPermission(moduleKey, action),
            activeColor: const Color(0xFF155096),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}
