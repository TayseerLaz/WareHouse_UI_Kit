import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isGridView = true;

  @override
  Widget build(BuildContext context) {
    // Theme color used throughout
    final themeColor = Theme.of(context).primaryColor;
    final localizations = AppLocalizations.of(context)!;

    // Define helper to build item data
    Map<String, dynamic> item(String title, String subtitle, IconData icon, [String? route]) {
      return {
        'title': title,
        'subtitle': subtitle,
        'icon': icon,
        'route': route,
      };
    }

    // Categorized Data
    // We use a List of Maps to maintain order and categories
    final List<Map<String, dynamic>> categories = [
      {
        'title': localizations.inbound,
        'items': [
          item(localizations.goodReceipts, localizations.goodReceiptsSubtitle, Icons.receipt_long),
          item(localizations.receivingFromVendors, localizations.receivingFromVendorsSubtitle, Icons.arrow_downward, '/receiving_from_vendor'),
          item(localizations.inventoryTransferIn, localizations.inventoryTransferInSubtitle, Icons.input_outlined),
        ]
      },
      {
        'title': localizations.outbound,
        'items': [
           item(localizations.goodIssue, localizations.goodIssueSubtitle, Icons.output),
           item(localizations.returnToVendor, localizations.returnToVendorSubtitle, Icons.arrow_upward),
           item(localizations.deliveryToCustomer, localizations.deliveryToCustomerSubtitle, Icons.local_shipping_outlined),
        ]
      },
      {
        'title': localizations.inventory,
        'items': [
          item(localizations.transactions, localizations.transactionsSubtitle, Icons.history),
          item(localizations.inventoryTransfer, localizations.inventoryTransferSubtitle, Icons.swap_horiz),
          item(localizations.inventoryMove, localizations.inventoryMoveSubtitle, Icons.drive_file_move_outlined),
        ]
      },
      {
        'title': 'Returns', // Fallback or add key if possible. Using English 'Returns' or specific key if found.
        'items': [
           item(localizations.returnFromCustomer, localizations.returnFromCustomerSubtitle, Icons.assignment_return_outlined),
        ]
      }
    ];
    
    return Scaffold(
      backgroundColor: const Color(0xFFE8F0FB),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: themeColor,
              ),
              child: Column(
                children: [
                   // Top Row: User Info & Actions
                   Row(
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
                            'Pegolive_US',
                            style: TextStyle(
                              color: Color(0xFFD4FBF6),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          // View Toggle
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isGridView = !_isGridView;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                _isGridView ? Icons.view_list_rounded : Icons.grid_view_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Notification Icon
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(context, '/notifications'),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.notifications_outlined,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 100), // Added bottom padding for nav bar space
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var category in categories) ...[
                      // Section Title
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12, top: 8),
                        child: Text(
                          category['title'],
                          style: TextStyle(
                            color: themeColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Items
                      if (_isGridView)
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 1.1, // Adjust for card shape
                          ),
                          itemCount: (category['items'] as List).length,
                          itemBuilder: (context, index) {
                            final item = category['items'][index];
                            return _buildGridCard(context, item, themeColor);
                          },
                        )
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: (category['items'] as List).length,
                          itemBuilder: (context, index) {
                            final item = category['items'][index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _buildListCard(context, item, themeColor),
                            );
                          },
                        ),
                       const SizedBox(height: 16),
                    ],
                  ],
                ),
              ),
            ),
            
            // Bottom Navigation (Keeping existing design)
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: themeColor,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildNavItem(localizations.home, Icons.home_outlined, true, Colors.white),
                        _buildNavItem(localizations.inventory, Icons.inventory_2_outlined, false, Colors.white),
                        _buildNavItem(localizations.analytics, Icons.analytics_outlined, false, Colors.white),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/navigation_menu'),
                          child: _buildNavItem(localizations.navigation, Icons.menu, false, Colors.white),
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
                          color: Colors.white,
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

  // --- List View Card ---
  Widget _buildListCard(BuildContext context, Map<String, dynamic> item, Color themeColor) {
    return GestureDetector(
      onTap: item['route'] != null ? () => Navigator.pushNamed(context, item['route']) : null,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadows: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: themeColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                item['icon'],
                color: themeColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'],
                    style: const TextStyle(
                      color: Color(0xFF262626),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['subtitle'],
                    style: const TextStyle(
                      color: Color(0xFF595959),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFFCCCCCC),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  // --- Grid View Card ---
  Widget _buildGridCard(BuildContext context, Map<String, dynamic> item, Color themeColor) {
    return GestureDetector(
      onTap: item['route'] != null ? () => Navigator.pushNamed(context, item['route']) : null,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: themeColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                item['icon'],
                color: themeColor,
                size: 28,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              item['title'],
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF262626),
                fontSize: 14,
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
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
