import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'packaging_screen.dart';

class ReceivingFromVendorScreen extends StatelessWidget {
  const ReceivingFromVendorScreen({super.key});

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
                Expanded(
                  child: Text(
                    localizations.receivingFromVendor,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // GRPO Button
                  _buildActionButton(
                    context: context,
                    title: localizations.grpo,
                    icon: Icons.inventory_2_outlined,
                    color: const Color(0xFF155096),
                    onTap: () {
                      Navigator.pushNamed(context, '/grpo');
                    },
                  ),
                  const SizedBox(height: 16),

                  // Pack of Storage Button
                  _buildActionButton(
                    context: context,
                    title: localizations.packOfStorage,
                    icon: Icons.archive_outlined,
                    color: const Color(0xFF155096),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PackagingScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  // Put Away Button
                  _buildActionButton(
                    context: context,
                    title: localizations.putAway,
                    icon: Icons.move_to_inbox_outlined,
                    color: const Color(0xFF155096),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${localizations.putAway} - Coming Soon')),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(icon, color: color, size: 32),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF262626),
                    ),
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
