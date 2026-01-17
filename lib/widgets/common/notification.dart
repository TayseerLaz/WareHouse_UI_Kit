import 'dart:async';
import 'package:flutter/material.dart';

/// A unified system for showing animated top notifications.
class AppNotification {
  /// Shows a notification from the top of the screen.
  ///
  /// You can pass a custom [child] widget, or use [AppNotification.showSales] 
  /// for the specific sales styling.
  static void show(BuildContext context, Widget child, {Duration duration = const Duration(seconds: 4)}) {
    final overlayState = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => _AnimatedNotification(
        duration: duration,
        onDismiss: () {
          overlayEntry.remove();
        },
        child: child,
      ),
    );

    overlayState.insert(overlayEntry);
  }

  /// Helper to show the specific "New Sales" style notification easily.
  /// This demonstrates how to use the specific styling with custom text.
  static void showNewSales(BuildContext context, {
    required String title,
    required String subtitle,
    Duration duration = const Duration(seconds: 4),
  }) {
    show(
      context,
      NotificationCard(title: title, subtitle: subtitle),
      duration: duration,
    );
  }
}

/// The visual component for the notification (formerly NewSalesNotification).
/// Now reusable with custom text.
class NotificationCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const NotificationCard({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox( 
      height: 130, 
      width: double.infinity,
      child: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Container(
              decoration: const ShapeDecoration(
                color: Color(0xFF155096), // Theme color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
              ),
            ),
          ),
          // Content
          Positioned(
            left: 48,
            top: 53,
            right: 24,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Plus Jakarta Sans',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: Color(0xFFD4FBF6),
                          fontSize: 12,
                          fontFamily: 'Plus Jakarta Sans',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Private generic widget that handles the animation and overlay logic.
class _AnimatedNotification extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final VoidCallback onDismiss;

  const _AnimatedNotification({
    required this.child,
    required this.duration,
    required this.onDismiss,
  });

  @override
  State<_AnimatedNotification> createState() => _AnimatedNotificationState();
}

class _AnimatedNotificationState extends State<_AnimatedNotification> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
      reverseCurve: Curves.easeInBack,
    ));

    _controller.forward();

    _timer = Timer(widget.duration, () {
      _dismiss();
    });
  }

  void _dismiss() async {
    _timer?.cancel();
    await _controller.reverse();
    widget.onDismiss();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Material(
        color: Colors.transparent,
        child: SlideTransition(
          position: _offsetAnimation,
          child: GestureDetector(
            onTap: _dismiss,
            onVerticalDragEnd: (details) {
              if (details.primaryVelocity! < 0) {
                _dismiss();
              }
            },
            child: SafeArea(
              bottom: false,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
