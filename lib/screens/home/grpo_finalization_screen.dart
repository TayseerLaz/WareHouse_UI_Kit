import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../l10n/app_localizations.dart';

class GRPOFinalizationScreen extends StatefulWidget {
  const GRPOFinalizationScreen({super.key});

  @override
  State<GRPOFinalizationScreen> createState() => _GRPOFinalizationScreenState();
}

class _GRPOFinalizationScreenState extends State<GRPOFinalizationScreen> {
  final TextEditingController _bpReferenceController = TextEditingController();
  final TextEditingController _driverNameController = TextEditingController();
  final TextEditingController _carController = TextEditingController();
  final TextEditingController _commentsController = TextEditingController();

  DateTime _bookingDate = DateTime.now();
  TimeOfDay _bookingTime = TimeOfDay.now();
  DateTime _dueDate = DateTime.now();
  String? _selectedStatus;
  
  // Signature state
  List<Offset?> _signaturePoints = [];
  bool _hasSignature = false;

  @override
  void dispose() {
    _bpReferenceController.dispose();
    _driverNameController.dispose();
    _carController.dispose();
    _commentsController.dispose();
    super.dispose();
  }

  void _handleSave() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('GRPO saved and posted successfully')),
    );
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  void _handleSaveAsDraft() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('GRPO saved as draft')),
    );
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).primaryColor;
    final localizations = AppLocalizations.of(context)!;

    final List<Map<String, String>> statusOptions = [
      {'value': 'draft', 'label': localizations.draft},
      {'value': 'proceed_packing', 'label': localizations.proceedToPacking},
      {'value': 'in_receiving', 'label': localizations.inReceiving},
      {'value': 'completed', 'label': localizations.completed},
      {'value': 'posted', 'label': localizations.posted},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFE8F0FB),
      body: Column(
        children: [
          // Top App Bar
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 60,
              bottom: 20,
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
                    localizations.grpo,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                // Attachment Icon
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Attach documents')),
                    );
                  },
                  icon: const Icon(Icons.attach_file, color: Colors.white),
                ),
                // Edit Icon
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(localizations.edit)),
                    );
                  },
                  icon: const Icon(Icons.edit_outlined, color: Colors.white),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Booking Date
                  _buildDateField(
                    label: localizations.bookingDate,
                    date: _bookingDate,
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _bookingDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (date != null) {
                        setState(() {
                          _bookingDate = date;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),

                  // Time Booking
                  _buildTimeField(
                    label: localizations.timeBooking,
                    time: _bookingTime,
                    onTap: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: _bookingTime,
                      );
                      if (time != null) {
                        setState(() {
                          _bookingTime = time;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),

                  // Due Date
                  _buildDateField(
                    label: localizations.dueDate,
                    date: _dueDate,
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _dueDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2030),
                      );
                      if (date != null) {
                        setState(() {
                          _dueDate = date;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),

                  // Document Status
                  _buildStatusDropdown(localizations, statusOptions),
                  const SizedBox(height: 16),

                  // BP Reference
                  _buildTextField(
                    label: localizations.bpReference,
                    controller: _bpReferenceController,
                    hint: localizations.enterBPReference,
                  ),
                  const SizedBox(height: 16),

                  // Driver Name
                  _buildTextField(
                    label: localizations.driverName,
                    controller: _driverNameController,
                    hint: localizations.enterDriverName,
                  ),
                  const SizedBox(height: 16),

                  // Car
                  _buildTextField(
                    label: localizations.car,
                    controller: _carController,
                    hint: localizations.enterCarInfo,
                  ),
                  const SizedBox(height: 16),

                  // Comments
                  _buildTextField(
                    label: localizations.comments,
                    controller: _commentsController,
                    hint: localizations.enterComments,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),

                  // Signature
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localizations.signature,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF595959),
                        ),
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () => _showSignatureDialog(context, localizations),
                        child: Container(
                          height: 120,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFE0E0E0)),
                          ),
                          child: _hasSignature
                              ? CustomPaint(
                                  painter: SignaturePainter(_signaturePoints),
                                  size: Size.infinite,
                                )
                              : Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.draw, size: 32, color: Color(0xFF999999)),
                                      const SizedBox(height: 8),
                                      Text(
                                        localizations.addSignature,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF999999),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Created By (Read-only)
                  _buildTextField(
                    label: localizations.createdBy,
                    enabled: false,
                    initialValue: 'ric',
                  ),
                ],
              ),
            ),
          ),

          // Bottom Action Buttons
          Container(
            padding: const EdgeInsets.all(20),
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
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: OutlinedButton(
                      onPressed: _handleSaveAsDraft,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: themeColor,
                        side: BorderSide(color: themeColor, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        localizations.saveAsDraft,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _handleSave,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        localizations.save,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
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
    );
  }

  Widget _buildDateField({
    required String label,
    required DateTime date,
    required VoidCallback onTap,
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
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE0E0E0)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    DateFormat('yyyy-MM-dd').format(date),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF262626),
                    ),
                  ),
                ),
                const Icon(Icons.calendar_today, size: 20, color: Color(0xFF155096)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeField({
    required String label,
    required TimeOfDay time,
    required VoidCallback onTap,
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
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE0E0E0)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    time.format(context),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF262626),
                    ),
                  ),
                ),
                const Icon(Icons.access_time, size: 20, color: Color(0xFF155096)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusDropdown(AppLocalizations localizations, List<Map<String, String>> statusOptions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizations.status,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF595959),
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedStatus,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
          ),
          hint: Text(localizations.selectStatus),
          items: statusOptions.map((status) {
            return DropdownMenuItem<String>(
              value: status['value'],
              child: Text(status['label']!),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedStatus = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    TextEditingController? controller,
    String? hint,
    String? initialValue,
    int maxLines = 1,
    bool enabled = true,
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
          initialValue: initialValue,
          enabled: enabled,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            fillColor: enabled ? Colors.white : const Color(0xFFF5F5F5),
            filled: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
          ),
        ),
      ],
    );
  }

  void _showSignatureDialog(BuildContext context, AppLocalizations localizations) {
    List<Offset?> tempPoints = List.from(_signaturePoints);
    
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      localizations.drawYourSignature,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF262626),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Signature Canvas
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: const Color(0xFFE0E0E0), width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: GestureDetector(
                          onPanStart: (details) {
                            setDialogState(() {
                              tempPoints.add(details.localPosition);
                            });
                          },
                          onPanUpdate: (details) {
                            setDialogState(() {
                              tempPoints.add(details.localPosition);
                            });
                          },
                          onPanEnd: (details) {
                            setDialogState(() {
                              tempPoints.add(null);
                            });
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: CustomPaint(
                              painter: SignaturePainter(tempPoints),
                              child: Container(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Action Buttons
                    Row(
                      children: [
                        // Clear Button
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setDialogState(() {
                                tempPoints.clear();
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFFF44336),
                              side: const BorderSide(color: Color(0xFFF44336), width: 2),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              localizations.clear,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Cancel Button
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(dialogContext),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF999999),
                              side: const BorderSide(color: Color(0xFF999999)),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              localizations.cancel,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Save Button
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _signaturePoints = tempPoints;
                                _hasSignature = tempPoints.isNotEmpty;
                              });
                              Navigator.pop(dialogContext);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Signature saved')),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF155096),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              localizations.save,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// Signature Painter Class
class SignaturePainter extends CustomPainter {
  final List<Offset?> points;

  SignaturePainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF155096)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(SignaturePainter oldDelegate) {
    return oldDelegate.points != points;
  }
}
