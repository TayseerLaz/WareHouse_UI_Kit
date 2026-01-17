import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const themeColor = Color(0xFF155096);
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
                   _buildSectionHeader(localizations.general),
                   const SizedBox(height: 16),
                   _buildInputField(localizations.company, localizations.selectCompany),
                   const SizedBox(height: 12),
                   _buildInputField(localizations.warehouse, localizations.selectWarehouse),
                   const SizedBox(height: 12),
                   _buildInputField(localizations.binId, localizations.enterBinId),
                   
                   const SizedBox(height: 32),

                  // --- Transitory Section ---
                  _buildSectionHeader(localizations.transitory),
                  const SizedBox(height: 16),
                  _buildInputField(localizations.warehouse, localizations.selectWarehouse),
                  const SizedBox(height: 12),
                  _buildInputField(localizations.bin, localizations.enterBin),

                  const SizedBox(height: 32),

                  // --- Inbound Section ---
                  _buildSectionHeader(localizations.inbound),
                  const SizedBox(height: 16),
                  _buildInputField(localizations.warehouse, localizations.selectWarehouse),

                  const SizedBox(height: 48),

                  // --- Update Button ---
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        // Update logic
                         ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(localizations.profileUpdated)),
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

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFF155096),
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildInputField(String label, String placeholder) {
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
                borderSide: const BorderSide(color: Color(0xFF155096), width: 1.5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
