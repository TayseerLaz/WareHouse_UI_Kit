import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../widgets/notification.dart';

class NotificationDemoScreen extends StatelessWidget {
  const NotificationDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.notificationDemoTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              localizations.pressButtonToSeeNotification,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                AppNotification.showNewSales(
                  context,
                  title: localizations.newSalesEntry,
                  subtitle: 'Monday, 17 Jan 2022', // Date could be dynamic but leaving static match for now or use DateFormat
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF155096),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: Text(localizations.showNotification),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                AppNotification.showNewSales(
                  context,
                  title: localizations.anotherAlert,
                  subtitle: localizations.dynamicTest,
                );
              },
               style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: Text(localizations.showCustomNotification),
            ),
          ],
        ),
      ),
    );
  }
}
