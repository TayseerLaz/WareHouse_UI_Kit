import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Theme color used throughout
    const themeColor = Color(0xFF155096);
    final localizations = AppLocalizations.of(context)!;
    
    return Scaffold(
      backgroundColor: const Color(0xFFE8F0FB),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              decoration: const ShapeDecoration(
                color: themeColor, // Changed from black overlay to theme color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localizations.helloUser('User1'),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Monday, 17 Jan 2026',
                        style: TextStyle(
                          color: Color(0xFFD4FBF6),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.notifications_outlined,
                    color: Colors.white,
                    size: 24,
                  ),
                ],
              ),
            ),
            
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildMenuItem(
                      localizations.goodReceipts,
                      localizations.goodReceiptsSubtitle,
                      Icons.receipt_long,
                      themeColor,
                    ),
                    const SizedBox(height: 12),
                    _buildMenuItem(
                      localizations.goodIssue,
                      localizations.goodIssueSubtitle,
                      Icons.output,
                      themeColor,
                    ),
                     const SizedBox(height: 12),
                    _buildMenuItem(
                      localizations.transactions,
                      localizations.transactionsSubtitle,
                      Icons.history,
                      themeColor,
                    ),
                    const SizedBox(height: 12),
                    _buildMenuItem(
                      localizations.receivingFromVendors,
                      localizations.receivingFromVendorsSubtitle,
                      Icons.arrow_downward,
                      themeColor,
                    ),
                    const SizedBox(height: 12),
                    _buildMenuItem(
                      localizations.returnToVendor,
                      localizations.returnToVendorSubtitle,
                      Icons.arrow_upward,
                      themeColor,
                    ),
                    const SizedBox(height: 12),
                    _buildMenuItem(
                      localizations.deliveryToCustomer,
                      localizations.deliveryToCustomerSubtitle,
                      Icons.local_shipping_outlined,
                      themeColor,
                    ),
                    const SizedBox(height: 12),
                    _buildMenuItem(
                      localizations.returnFromCustomer,
                      localizations.returnFromCustomerSubtitle,
                      Icons.assignment_return_outlined,
                      themeColor,
                    ),
                    const SizedBox(height: 12),
                    _buildMenuItem(
                      localizations.inventoryTransfer,
                      localizations.inventoryTransferSubtitle,
                      Icons.swap_horiz,
                      themeColor,
                    ),
                    const SizedBox(height: 12),
                    _buildMenuItem(
                      localizations.inventoryTransferIn,
                      localizations.inventoryTransferInSubtitle,
                      Icons.input_outlined,
                      themeColor,
                    ),
                    const SizedBox(height: 12),
                    _buildMenuItem(
                      localizations.inventoryMove,
                      localizations.inventoryMoveSubtitle,
                      Icons.drive_file_move_outlined,
                      themeColor,
                    ),
                  ],
                ),
              ),
            ),
            
            // Bottom Navigation
            Container(
              width: double.infinity,
              decoration: const ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildNavItem(localizations.home, Icons.home_outlined, true, themeColor),
                        _buildNavItem(localizations.inventory, Icons.inventory_2_outlined, false, themeColor),
                        _buildNavItem(localizations.analytics, Icons.analytics_outlined, false, themeColor),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/navigation_menu'),
                          child: _buildNavItem(localizations.navigation, Icons.menu, false, themeColor),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Opacity(
                      opacity: 0.40,
                      child: Container(
                        width: 32,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: ShapeDecoration(
                          color: const Color(0xFF79747E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
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
      ),
    );
  }

  Widget _buildMenuItem(String title, String subtitle, IconData icon, Color themeColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: themeColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: themeColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF262626),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF595959),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Color(0xFF595959),
            size: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String label, IconData icon, bool isActive, Color themeColor) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: themeColor,
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: themeColor,
            fontSize: 12,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
