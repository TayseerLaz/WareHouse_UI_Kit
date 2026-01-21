import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  String _searchQuery = '';
  String _selectedFilter = 'all';

  // Mock user data
  final List<Map<String, dynamic>> _allUsers = [
    {'id': 1, 'name': 'John Doe', 'email': 'john@example.com', 'role': 'Admin', 'isActive': true},
    {'id': 2, 'name': 'Jane Smith', 'email': 'jane@example.com', 'role': 'Manager', 'isActive': true},
    {'id': 3, 'name': 'Bob Johnson', 'email': 'bob@example.com', 'role': 'User', 'isActive': false},
    {'id': 4, 'name': 'Alice Williams', 'email': 'alice@example.com', 'role': 'User', 'isActive': true},
    {'id': 5, 'name': 'Charlie Brown', 'email': 'charlie@example.com', 'role': 'Guest', 'isActive': false},
  ];

  List<Map<String, dynamic>> get _filteredUsers {
    return _allUsers.where((user) {
      // Apply search filter
      final matchesSearch = user['name'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
          user['email'].toString().toLowerCase().contains(_searchQuery.toLowerCase());

      // Apply status filter
      final matchesFilter = _selectedFilter == 'all' ||
          (_selectedFilter == 'active' && user['isActive'] == true) ||
          (_selectedFilter == 'inactive' && user['isActive'] == false);

      return matchesSearch && matchesFilter;
    }).toList();
  }

  void _deleteUser(int userId) {
    setState(() {
      _allUsers.removeWhere((user) => user['id'] == userId);
    });
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
                      localizations.users,
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
                      hintText: localizations.searchUsers,
                      hintStyle: const TextStyle(color: Color(0xFF999999)),
                      prefixIcon: Icon(Icons.search, color: Theme.of(context).primaryColor),
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

          // Filter Chips
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(
                  '${localizations.filterBy}:',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF595959),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip(localizations.allUsers, 'all'),
                        const SizedBox(width: 8),
                        _buildFilterChip(localizations.activeUsers, 'active'),
                        const SizedBox(width: 8),
                        _buildFilterChip(localizations.inactiveUsers, 'inactive'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Users List
          Expanded(
            child: _filteredUsers.isEmpty
                ? Center(
                    child: Text(
                      localizations.noUsersFound,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF999999),
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _filteredUsers.length,
                    itemBuilder: (context, index) {
                      final user = _filteredUsers[index];
                      return _buildUserCard(user, localizations);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigate to Add User form
          Navigator.pushNamed(context, '/user_form');
        },
        backgroundColor: themeColor,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          localizations.addNewUser,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _selectedFilter == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = value;
        });
      },
      backgroundColor: Colors.white,
      selectedColor: Theme.of(context).primaryColor.withValues(alpha: 0.2),
      labelStyle: TextStyle(
        color: isSelected ? Theme.of(context).primaryColor : const Color(0xFF595959),
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
      ),
      side: BorderSide(
        color: isSelected ? Theme.of(context).primaryColor : const Color(0xFFE0E0E0),
        width: 1.5,
      ),
    );
  }

  Widget _buildUserCard(Map<String, dynamic> user, AppLocalizations localizations) {
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                  child: Text(
                    user['name'].toString().substring(0, 1).toUpperCase(),
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user['name'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF262626),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user['email'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF7F7F7F),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: user['isActive']
                        ? Colors.green.withValues(alpha: 0.1)
                        : Colors.grey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    user['isActive'] ? localizations.active : localizations.inactive,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: user['isActive'] ? Colors.green[700] : Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildInfoChip(Icons.badge_outlined, '${localizations.role}: ${user['role']}'),
                const Spacer(),
                // Edit Button
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/user_form',
                      arguments: user,
                    );
                  },
                  icon: Icon(Icons.edit_outlined, color: Theme.of(context).primaryColor),
                  tooltip: localizations.edit,
                ),
                // Delete Button
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(localizations.delete),
                        content: Text(localizations.confirmDelete),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(localizations.cancel),
                          ),
                          TextButton(
                            onPressed: () {
                              _deleteUser(user['id']);
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(localizations.userDeleted)),
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
                  },
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  tooltip: localizations.delete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: const Color(0xFF7F7F7F)),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF7F7F7F),
          ),
        ),
      ],
    );
  }
}
