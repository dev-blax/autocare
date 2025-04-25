import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/user.dart';
import '../../models/vehicle.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late NotificationPreferences _notificationPreferences;

  @override
  void initState() {
    super.initState();
    _notificationPreferences = mockUser.notificationPreferences;
  }

  void _editVehicle(Vehicle? vehicle) {
    final makeController = TextEditingController(text: vehicle?.make);
    final modelController = TextEditingController(text: vehicle?.model);
    final yearController = TextEditingController(
      text: vehicle?.year.toString(),
    );
    final plateController = TextEditingController(text: vehicle?.licensePlate);

    showCupertinoModalPopup(
      context: context,
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: CupertinoColors.systemBackground,
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    vehicle == null ? 'Add Vehicle' : 'Edit Vehicle',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CupertinoTextField(
                    controller: makeController,
                    placeholder: 'Make',
                    padding: const EdgeInsets.all(12),
                  ),
                  const SizedBox(height: 8),
                  CupertinoTextField(
                    controller: modelController,
                    placeholder: 'Model',
                    padding: const EdgeInsets.all(12),
                  ),
                  const SizedBox(height: 8),
                  CupertinoTextField(
                    controller: yearController,
                    placeholder: 'Year',
                    keyboardType: TextInputType.number,
                    padding: const EdgeInsets.all(12),
                  ),
                  const SizedBox(height: 8),
                  CupertinoTextField(
                    controller: plateController,
                    placeholder: 'License Plate (Optional)',
                    padding: const EdgeInsets.all(12),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: const Text('Cancel'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      Expanded(
                        child: CupertinoButton.filled(
                          padding: EdgeInsets.zero,
                          child: const Text('Save'),
                          onPressed: () {
                            // Mock save
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Profile')),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 32),
              CircleAvatar(
                radius: 50,
                backgroundColor: CupertinoColors.systemGrey4,
                child: ClipOval(child: Image.network(mockUser.photoUrl!)),
              ),
              const SizedBox(height: 16),
              Text(
                mockUser.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                mockUser.email,
                style: const TextStyle(color: CupertinoColors.systemGrey),
              ),
              Text(
                mockUser.phone,
                style: const TextStyle(color: CupertinoColors.systemGrey),
              ),
              const SizedBox(height: 32),

              // Vehicles
              CupertinoListSection.insetGrouped(
                header: const Text('VEHICLES'),
                children: [
                  ...mockVehicles.map(
                    (vehicle) => CupertinoListTile(
                      title: Text('${vehicle.make} ${vehicle.model}'),
                      subtitle: Text(
                        '${vehicle.year}${vehicle.licensePlate != null ? ' • ${vehicle.licensePlate}' : ''}',
                      ),
                      leading: const Icon(CupertinoIcons.car_detailed),
                      trailing: CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: const Text('Edit'),
                        onPressed: () => _editVehicle(vehicle),
                      ),
                    ),
                  ),
                  CupertinoListTile(
                    title: const Text('Add Vehicle'),
                    leading: const Icon(CupertinoIcons.add_circled),
                    onTap: () => _editVehicle(null),
                  ),
                ],
              ),

              // Notification Preferences
              CupertinoListSection.insetGrouped(
                header: const Text('NOTIFICATION PREFERENCES'),
                children: [
                  CupertinoListTile.notched(
                    title: const Text('Service Reminders'),
                    trailing: CupertinoSwitch(
                      value: _notificationPreferences.serviceReminders,
                      onChanged: (value) {
                        setState(() {
                          _notificationPreferences = _notificationPreferences
                              .copyWith(serviceReminders: value);
                        });
                      },
                    ),
                  ),
                  CupertinoListTile.notched(
                    title: const Text('Promotions'),
                    trailing: CupertinoSwitch(
                      value: _notificationPreferences.promotions,
                      onChanged: (value) {
                        setState(() {
                          _notificationPreferences = _notificationPreferences
                              .copyWith(promotions: value);
                        });
                      },
                    ),
                  ),
                  CupertinoListTile.notched(
                    title: const Text('Status Updates'),
                    trailing: CupertinoSwitch(
                      value: _notificationPreferences.statusUpdates,
                      onChanged: (value) {
                        setState(() {
                          _notificationPreferences = _notificationPreferences
                              .copyWith(statusUpdates: value);
                        });
                      },
                    ),
                  ),
                  CupertinoListTile.notched(
                    title: const Text('Email Notifications'),
                    trailing: CupertinoSwitch(
                      value: _notificationPreferences.emailNotifications,
                      onChanged: (value) {
                        setState(() {
                          _notificationPreferences = _notificationPreferences
                              .copyWith(emailNotifications: value);
                        });
                      },
                    ),
                  ),
                ],
              ),

              // Account Actions
              CupertinoListSection.insetGrouped(
                children: [
                  CupertinoListTile(
                    title: const Text(
                      'Logout',
                      style: TextStyle(color: CupertinoColors.destructiveRed),
                    ),
                    leading: const Icon(
                      CupertinoIcons.square_arrow_left,
                      color: CupertinoColors.destructiveRed,
                    ),
                    onTap: () {
                      // alert dialog before login out
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                          title: const Text('Logout'),
                          content: const Text('Are you sure you want to logout?'),
                          actions: [
                            CupertinoDialogAction(
                              child: const Text('Cancel'),
                              onPressed: () => Navigator.pop(context),
                            ),
                            CupertinoDialogAction(
                              child: const Text('Logout', style: TextStyle(color: CupertinoColors.destructiveRed)),
                              onPressed: () {
                                // logout
                                Navigator.pop(context);
                                context.go('/login');
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
