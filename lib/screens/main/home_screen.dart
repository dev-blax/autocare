import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../data/mock_data.dart';
import '../../models/vendor.dart';
import '../../widgets/service_type_filter.dart';
import '../../widgets/vendor_card.dart';
import 'booking_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<ServiceType> _selectedTypes = [];
  SortOption _sortOption = SortOption.rating;
  List<Vendor> _filteredVendors = [];

  @override
  void initState() {
    super.initState();
    _filteredVendors = List.from(mockVendors);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterVendors() {
    setState(() {
      _filteredVendors = mockVendors.where((vendor) {
        // Apply search filter
        if (_searchController.text.isNotEmpty) {
          final searchLower = _searchController.text.toLowerCase();
          if (!vendor.name.toLowerCase().contains(searchLower)) {
            return false;
          }
        }

        // Apply service type filter
        if (_selectedTypes.isNotEmpty) {
          return vendor.serviceTypes
              .any((type) => _selectedTypes.contains(type));
        }

        return true;
      }).toList();

      // Apply sorting
      _filteredVendors.sort((a, b) {
        switch (_sortOption) {
          case SortOption.price:
            return a.serviceTypes.first.basePrice
                .compareTo(b.serviceTypes.first.basePrice);
          case SortOption.rating:
            return b.rating.compareTo(a.rating);
          case SortOption.distance:
            return a.distance.compareTo(b.distance);
          case SortOption.waitTime:
            return a.estimatedWaitTime.compareTo(b.estimatedWaitTime);
        }
      });
    });
  }

  void _toggleServiceType(ServiceType type) {
    setState(() {
      if (_selectedTypes.contains(type)) {
        _selectedTypes.remove(type);
      } else {
        _selectedTypes.add(type);
      }
      _filterVendors();
    });
  }

  @override
  Widget build(BuildContext context) {
    final recommendedVendors =
        _filteredVendors.where((v) => v.isRecommended).toList();
    final otherVendors =
        _filteredVendors.where((v) => !v.isRecommended).toList();

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('AutoCare'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: CupertinoSearchTextField(
                controller: _searchController,
                placeholder: 'Search vendors...',
                onChanged: (_) => _filterVendors(),
              ),
            ),
            ServiceTypeFilter(
              selectedTypes: _selectedTypes,
              onToggle: _toggleServiceType,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('Sort by: '),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Row(
                      children: [
                        Text(
                          _sortOption.label,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Icon(CupertinoIcons.chevron_down, size: 16),
                      ],
                    ),
                    onPressed: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) => CupertinoActionSheet(
                          actions: SortOption.values
                              .map(
                                (option) => CupertinoActionSheetAction(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    setState(() {
                                      _sortOption = option;
                                      _filterVendors();
                                    });
                                  },
                                  child: Text(option.label),
                                ),
                              )
                              .toList(),
                          cancelButton: CupertinoActionSheetAction(
                            isDestructiveAction: true,
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            if (recommendedVendors.isNotEmpty) ...[
              const Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(CupertinoIcons.star_fill,
                        color: CupertinoColors.systemYellow),
                    SizedBox(width: 8),
                    Text(
                      'Recommended Vendors',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            Expanded(
              child: ListView(
                children: [
                  ...recommendedVendors.map(
                    (vendor) => VendorCard(
                      vendor: vendor,
                      onBookNow: (){
                        Navigator.push(context, CupertinoPageRoute(builder: (context) => BookingScreen(vendor: vendor)));
                      },
                    ),
                  ),
                  if (otherVendors.isNotEmpty && recommendedVendors.isNotEmpty)
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Other Vendors',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ...otherVendors.map(
                    (vendor) => VendorCard(
                      vendor: vendor,
                      onBookNow: () => context.push('/shell/bookings'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
