import 'package:flutter/material.dart';

enum StatusType {
  pending,
  done,
  error,
}

class StatusBadge extends StatelessWidget {
  final StatusType type;
  final String? label;

  const StatusBadge({
    super.key,
    required this.type,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    // Determine colors based on type
    Color backgroundColor;
    String defaultText;

    switch (type) {
      case StatusType.pending:
        backgroundColor = const Color(0xFFFEF2CD);
        defaultText = 'Pending';
        break;
      case StatusType.done:
        backgroundColor = const Color(0xFFD4F7DC);
        defaultText = 'Done';
        break;
      case StatusType.error:
        backgroundColor = const Color(0xFFF8D3D3);
        defaultText = 'Error';
        break;
    }

    return Container(
      // Match Figma: width in Figma was fixed 144, but for a reusable widget 
      // it's better to be adaptive or have a min width. 
      // The design has padding top:4, left:8, right:8, bottom:5.
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 5),
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1,
            color: Color(0xFFE6E6E6),
          ),
          borderRadius: BorderRadius.circular(7),
        ),
      ),
      child: Text(
        label ?? defaultText,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Color(0xFF191919),
          fontSize: 14,
          fontFamily: 'Plus Jakarta Sans',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
