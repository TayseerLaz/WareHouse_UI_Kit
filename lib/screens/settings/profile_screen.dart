import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../widgets/common/notification.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).primaryColor;
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFE8F0FB),
      // Extend body behind app bar effectively to allow our custom container to be at the top
      body: Column(
        children: [
          // Custom Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              left: 20, 
              right: 20, 
              top: 60, // Safe area equivalent + padding
              bottom: 40 // Extra length as requested
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
                Text(
                  localizations.companySettings,
                  style: const TextStyle(
                    color: Colors.white, 
                    fontSize: 22, // Slightly larger title
                    fontWeight: FontWeight.w600
                  ),
                ),
              ],
            ),
          ),
          
          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   // --- General Section ---
                   _buildSectionHeader(localizations.general, context),
                   const SizedBox(height: 16),
                   _buildInputField(localizations.company, localizations.selectCompany, context),
                   const SizedBox(height: 12),
                   _buildInputField(localizations.warehouse, localizations.selectWarehouse, context),
                   const SizedBox(height: 12),
                   _buildInputField(localizations.binId, localizations.enterBinId, context),
                   
                   const SizedBox(height: 32),

                  // --- Transitory Section ---
                  _buildSectionHeader(localizations.transitory, context),
                  const SizedBox(height: 16),
                  _buildInputField(localizations.warehouse, localizations.selectWarehouse, context),
                  const SizedBox(height: 12),
                  _buildInputField(localizations.bin, localizations.enterBin, context),

                  const SizedBox(height: 32),

                  // --- Inbound Section ---
                  _buildSectionHeader(localizations.inbound, context),
                  const SizedBox(height: 16),
                  _buildInputField(localizations.warehouse, localizations.selectWarehouse, context),

                  const SizedBox(height: 48),

                  // --- Update Button ---
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        // Update logic
                        AppNotification.showNewSales(
                          context,
                          title: 'Success',
                          subtitle: localizations.profileUpdated,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                      ),
                      child: Text(
                        localizations.update,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildInputField(String label, String placeholder, BuildContext context) {
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
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: const TextStyle(color: Color(0xFF999999)),
              fillColor: Colors.white,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
