import 'package:flutter/material.dart';
import 'package:millyshb/configs/theme/colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Sample notifications data
  final List<Map<String, String>> notifications = [
    {
      'title': 'Order Shipped',
      'description': 'Your order #12345 has been shipped.',
      'time': '2 hours ago'
    },
    {
      'title': 'New Offer',
      'description': 'Limited time offer: Get 20% off on your next purchase!',
      'time': '1 day ago'
    },
    {
      'title': 'Delivery Update',
      'description': 'Your package will be delivered by tomorrow.',
      'time': '3 days ago'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading:
                  const Icon(Icons.notifications, color: Pallete.accentColor),
              title: Text(notification['title']!),
              subtitle: Text(notification['description']!),
              trailing: Text(notification['time']!),
              onTap: () {
                // Action when tapped, e.g., view details
              },
            ),
          );
        },
      ),
    );
  }
}
