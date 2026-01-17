import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class UserFormScreen extends StatefulWidget {
  final Map<String, dynamic>? user; // For editing existing user

  const UserFormScreen({super.key, this.user});

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Form controllers
  final _userCodeController = TextEditingController();
  final _usernameController = TextEditingController();
  final _foreignNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _imeiController = TextEditingController();
  
  // Dropdown values
  String? _selectedUserGroup;
  String? _selectedLanguage;
  String? _selectedCompany;
  String? _selectedFontSize;
  bool _isActive = true;

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      // Populate form with existing user data
      _usernameController.text = widget.user!['name'] ?? '';
      _emailController.text = widget.user!['email'] ?? '';
      _selectedUserGroup = widget.user!['role'];
      _isActive = widget.user!['isActive'] ?? true;
    }
  }

  @override
  void dispose() {
    _userCodeController.dispose();
    _usernameController.dispose();
    _foreignNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _imeiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const themeColor = Color(0xFF155096);
    final localizations = AppLocalizations.of(context)!;
    final isEditing = widget.user != null;

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
                  isEditing ? '${localizations.edit} ${localizations.user}' : localizations.addNewUser,
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // User Code
                    _buildInputField(
                      label: localizations.userCode,
                      hint: localizations.enterUserCode,
                      controller: _userCodeController,
                      icon: Icons.qr_code,
                    ),
                    const SizedBox(height: 16),

                    // Username
                    _buildInputField(
                      label: localizations.userName,
                      hint: localizations.enterName,
                      controller: _usernameController,
                      icon: Icons.person_outline,
                      required: true,
                    ),
                    const SizedBox(height: 16),

                    // Foreign Name
                    _buildInputField(
                      label: localizations.foreignName,
                      hint: localizations.enterForeignName,
                      controller: _foreignNameController,
                      icon: Icons.translate,
                    ),
                    const SizedBox(height: 16),

                    // Email
                    _buildInputField(
                      label: localizations.email,
                      hint: localizations.enterEmail,
                      controller: _emailController,
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      required: true,
                    ),
                    const SizedBox(height: 16),

                    // Password
                    _buildInputField(
                      label: localizations.password,
                      hint: localizations.enterPassword,
                      controller: _passwordController,
                      icon: Icons.lock_outline,
                      isPassword: true,
                      required: !isEditing,
                    ),
                    const SizedBox(height: 16),

                    // Phone Number
                    _buildInputField(
                      label: localizations.phoneNumber,
                      hint: localizations.enterPhoneNumber,
                      controller: _phoneController,
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),

                    // IMEI Number
                    _buildInputField(
                      label: localizations.imeiNumber,
                      hint: localizations.enterImei,
                      controller: _imeiController,
                      icon: Icons.smartphone_outlined,
                    ),
                    const SizedBox(height: 24),

                    // Dropdowns Section
                    Text(
                      localizations.appConfiguration,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF155096),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // User Group
                    _buildDropdown(
                      context: context,
                      label: localizations.userGroup,
                      value: _selectedUserGroup,
                      hint: localizations.selectUserGroup,
                      items: [localizations.admin, localizations.manager, localizations.user, localizations.guest],
                      onChanged: (value) {
                        setState(() {
                          _selectedUserGroup = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),

                    // Language
                    _buildDropdown(
                      context: context,
                      label: localizations.language,
                      value: _selectedLanguage,
                      hint: localizations.selectLanguage,
                      items: ['English', 'Arabic'],
                      onChanged: (value) {
                        setState(() {
                          _selectedLanguage = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),

                    // Company
                    _buildDropdown(
                      context: context,
                      label: localizations.company,
                      value: _selectedCompany,
                      hint: localizations.selectCompany,
                      items: ['Pegolive_US', 'Company A', 'Company B', 'Company C'],
                      onChanged: (value) {
                        setState(() {
                          _selectedCompany = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),

                    // Font Size
                    _buildDropdown(
                      context: context,
                      label: localizations.fontSize,
                      value: _selectedFontSize,
                      hint: localizations.selectFontSize,
                      items: ['Small', 'Medium', 'Large', 'Extra Large'],
                      onChanged: (value) {
                        setState(() {
                          _selectedFontSize = value;
                        });
                      },
                    ),
                    const SizedBox(height: 24),

                    // Active Status Switch
                    Container(
                      padding: const EdgeInsets.all(16),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.power_settings_new,
                                color: _isActive ? Colors.green : Colors.grey,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                localizations.activeStatus,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF262626),
                                ),
                              ),
                            ],
                          ),
                          Switch(
                            value: _isActive,
                            onChanged: (value) {
                              setState(() {
                                _isActive = value;
                              });
                            },
                            activeColor: const Color(0xFF155096),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Save Button
                    SizedBox(
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Save user logic
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(localizations.userSaved)),
                            );
                          }
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
                          localizations.save,
                          style: const TextStyle(
                            fontSize: 18,
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
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    bool isPassword = false,
    bool required = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
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
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            obscureText: isPassword,
            keyboardType: keyboardType,
            validator: required
                ? (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  }
                : null,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Color(0xFF999999)),
              prefixIcon: Icon(icon, color: const Color(0xFF155096)),
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
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required BuildContext context,
    required String label,
    required String? value,
    required String hint,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
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
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: DropdownButtonFormField<String>(
            value: value,
            decoration: InputDecoration(
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
            hint: Text(hint),
            icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF595959)),
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
