class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? photoUrl;
  final NotificationPreferences notificationPreferences;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.photoUrl,
    required this.notificationPreferences,
  });
}

class NotificationPreferences {
  final bool serviceReminders;
  final bool promotions;
  final bool statusUpdates;
  final bool emailNotifications;

  const NotificationPreferences({
    required this.serviceReminders,
    required this.promotions,
    required this.statusUpdates,
    required this.emailNotifications,
  });

  NotificationPreferences copyWith({
    bool? serviceReminders,
    bool? promotions,
    bool? statusUpdates,
    bool? emailNotifications,
  }) {
    return NotificationPreferences(
      serviceReminders: serviceReminders ?? this.serviceReminders,
      promotions: promotions ?? this.promotions,
      statusUpdates: statusUpdates ?? this.statusUpdates,
      emailNotifications: emailNotifications ?? this.emailNotifications,
    );
  }
}

// Mock user data
final mockUser = User(
  id: '1',
  name: 'John Doe',
  email: 'john.doe@example.com',
  phone: '+1 (555) 123-4567',
  photoUrl: null,
  notificationPreferences: const NotificationPreferences(
    serviceReminders: true,
    promotions: false,
    statusUpdates: true,
    emailNotifications: true,
  ),
);
