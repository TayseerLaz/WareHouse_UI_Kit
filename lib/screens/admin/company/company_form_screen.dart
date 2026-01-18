import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../l10n/app_localizations.dart';

class CompanyFormScreen extends StatefulWidget {
  final Map<String, dynamic>? company;

  const CompanyFormScreen({super.key, this.company});

  @override
  State<CompanyFormScreen> createState() => _CompanyFormScreenState();
}

class _CompanyFormScreenState extends State<CompanyFormScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers
  final _companyCodeController = TextEditingController();
  final _databaseController = TextEditingController();
  final _serverController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _portController = TextEditingController(text: '1433');
  final _erpUserController = TextEditingController();
  final _erpPasswordController = TextEditingController();
  final _erpAddressController = TextEditingController();

  String _selectedDatabaseType = 'SQL Server';
  bool _showPassword = false;
  bool _showErpPassword = false;

  final List<String> _databaseTypes = [
    'SQL Server',
    'MySQL',
    'PostgreSQL',
    'Oracle',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.company != null) {
      _companyCodeController.text = widget.company!['code'] ?? '';
      _databaseController.text = widget.company!['database'] ?? '';
      _serverController.text = widget.company!['server'] ?? '';
    }
  }

  @override
  void dispose() {
    _companyCodeController.dispose();
    _databaseController.dispose();
    _serverController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _portController.dispose();
    _erpUserController.dispose();
    _erpPasswordController.dispose();
    _erpAddressController.dispose();
    super.dispose();
  }

  void _saveCompany() {
    if (_formKey.currentState!.validate()) {
      final localizations = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(localizations.companySaved),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    const themeColor = Color(0xFF155096);
    final localizations = AppLocalizations.of(context)!;
    final isEdit = widget.company != null;

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
                Text(
                  isEdit ? localizations.editCompany : localizations.addCompany,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Form Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Company Information Section
                    _buildSectionTitle(localizations.companyInformation, Icons.business),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _companyCodeController,
                      label: localizations.companyCode,
                      hint: localizations.enterCompanyCode,
                      icon: Icons.badge_outlined,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return localizations.pleaseEnterCompanyCode;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // Database Configuration Section
                    _buildSectionTitle(localizations.databaseConfiguration, Icons.storage),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _databaseController,
                      label: localizations.connectionDatabase,
                      hint: localizations.enterDatabaseName,
                      icon: Icons.dns_outlined,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _serverController,
                      label: localizations.connectionServer,
                      hint: localizations.enterServerAddress,
                      icon: Icons.computer_outlined,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _usernameController,
                      label: localizations.connectionUsername,
                      hint: localizations.enterUsername,
                      icon: Icons.person_outline,
                    ),
                    const SizedBox(height: 16),
                    _buildPasswordField(
                      controller: _passwordController,
                      label: localizations.connectionPassword,
                      hint: localizations.enterConnectionPassword,
                      showPassword: _showPassword,
                      onToggle: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _portController,
                      label: localizations.connectionPort,
                      hint: localizations.enterPort,
                      icon: Icons.settings_ethernet_outlined,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    const SizedBox(height: 16),
                    _buildDropdownField(
                      label: localizations.databaseType,
                      value: _selectedDatabaseType,
                      items: _databaseTypes,
                      onChanged: (value) {
                        setState(() {
                          _selectedDatabaseType = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 24),

                    // ERP Integration Section
                    _buildSectionTitle(localizations.erpIntegration, Icons.integration_instructions),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _erpUserController,
                      label: localizations.erpUser,
                      hint: localizations.enterErpUser,
                      icon: Icons.account_circle_outlined,
                    ),
                    const SizedBox(height: 16),
                    _buildPasswordField(
                      controller: _erpPasswordController,
                      label: localizations.erpPassword,
                      hint: localizations.enterErpPassword,
                      showPassword: _showErpPassword,
                      onToggle: () {
                        setState(() {
                          _showErpPassword = !_showErpPassword;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _erpAddressController,
                      label: localizations.erpAddress,
                      hint: localizations.enterErpAddress,
                      icon: Icons.link_outlined,
                    ),
                    const SizedBox(height: 80), // Space for bottom buttons
                  ],
                ),
              ),
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
              // Save Button
              Expanded(
                child: ElevatedButton(
                  onPressed: _saveCompany,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: const Color(0xFF155096),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    localizations.save,
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

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF155096).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF155096), size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF262626),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF595959),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFF999999)),
            prefixIcon: Icon(icon, color: const Color(0xFF155096)),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF155096), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool showPassword,
    required VoidCallback onToggle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF595959),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: !showPassword,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFF999999)),
            prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF155096)),
            suffixIcon: IconButton(
              icon: Icon(
                showPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                color: const Color(0xFF155096),
              ),
              onPressed: onToggle,
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF155096), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF595959),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE0E0E0)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF155096)),
              items: items.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF262626),
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
