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
    final themeColor = Theme.of(context).primaryColor;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: themeColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.notifications_outlined,
              color: themeColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: themeColor,
                    fontSize: 16,
                    fontFamily: 'Plus Jakarta Sans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF595959),
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
