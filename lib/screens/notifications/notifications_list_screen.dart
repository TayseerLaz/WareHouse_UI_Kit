import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class NotificationsListScreen extends StatelessWidget {
  const NotificationsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).primaryColor;
    final localizations = AppLocalizations.of(context)!;

    // Dummy Data
    final List<Map<String, dynamic>> notifications = [
      {
        'title': 'New Order Received',
        'subtitle': 'PO #12345 has been created.',
        'time': '2 mins ago',
        'type': 'info',
        'isRead': false,
      },
      {
        'title': 'System Maintenance',
        'subtitle': 'System will be down for maintenance at 12:00 AM.',
        'time': '1 hour ago',
        'type': 'warning',
        'isRead': false,
      },
      {
        'title': 'Shipment Delayed',
        'subtitle': 'Shipment #98765 acquisition has been delayed.',
        'time': '3 hours ago',
        'type': 'error',
        'isRead': true,
      },
      {
        'title': 'Inventory Update',
        'subtitle': 'Stock count for item #555 completed successfully.',
        'time': '1 day ago',
        'type': 'success',
        'isRead': true,
      },
      {
        'title': 'New User Registered',
        'subtitle': 'User "John Doe" has requested access.',
        'time': '2 days ago',
        'type': 'info',
        'isRead': true,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFE8F0FB),
      body: Column(
        children: [
          // Custom Header
          Container(
            padding: const EdgeInsets.only(
              left: 20, 
              right: 20, 
              top: 60, 
              bottom: 30
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
                    localizations.notificationDemoTitle, 
                    style: const TextStyle(
                      color: Colors.white, 
                      fontSize: 22,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('All notifications marked as read')),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.done_all, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
          
          // List Content
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return _buildNotificationCard(context, notification, themeColor);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(BuildContext context, Map<String, dynamic> notification, Color themeColor) {
    IconData icon;
    Color iconColor;
    Color containerColor;

    switch (notification['type']) {
      case 'error':
        icon = Icons.error_outline;
        iconColor = Colors.red;
        containerColor = Colors.red.withValues(alpha: 0.1);
        break;
      case 'warning':
        icon = Icons.warning_amber_rounded;
        iconColor = Colors.orange;
        containerColor = Colors.orange.withValues(alpha: 0.1);
        break;
      case 'success':
        icon = Icons.check_circle_outline;
        iconColor = Colors.green;
        containerColor = Colors.green.withValues(alpha: 0.1);
        break;
      case 'info':
      default:
        icon = Icons.info_outline;
        iconColor = themeColor;
        containerColor = themeColor.withValues(alpha: 0.1);
        break;
    }

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
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // Navigate to details or mark as read logic
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: iconColor, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              notification['title'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: notification['isRead'] ? FontWeight.w600 : FontWeight.w700,
                                color: const Color(0xFF262626),
                              ),
                            ),
                          ),
                          if (!notification['isRead'])
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: themeColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        notification['subtitle'],
                        style: const TextStyle(
                          color: Color(0xFF7F7F7F), 
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        notification['time'],
                        style: const TextStyle(
                          color: Color(0xFFAAAAAA), 
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
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
