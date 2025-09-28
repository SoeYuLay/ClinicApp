import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../utils/constants/app_colors.dart';

class RecentSearches extends StatefulWidget {
  const RecentSearches({super.key});

  @override
  State<RecentSearches> createState() => _RecentSearchesState();
}
    List<String> recentSearches = [
      "Primary care doctor specialist",
      "Doctor Putri Anggreheni",
      "Doctor for teeth",
      "Abdominal pain complaints",
      "Eye specialist doctors",
      "Extra search (should be cut off)",
    ];

class _RecentSearchesState extends State<RecentSearches> {
  @override
  Widget build(BuildContext context) {

    final displayList = recentSearches.take(5).toList();

    void removeSearch(String searchHistory) {
      setState(() => recentSearches.remove(searchHistory));
    }

    void clearAll() {
      setState(() => recentSearches.clear());
    }

    return Column(
      children: [
        Row(
          children: [
            Text(
              'Recent Search',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Spacer(),
            TextButton(
                onPressed: () => clearAll(),
                child: Text(
                  'Remove All',
                  style: TextStyle(color: AppColor.primaryColor, fontSize: 15),
                )),
          ],
        ),
        Column(
            children: displayList.map((searchHistory) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Row(
              children: [
                const Icon(Icons.history, size: 25, color: Colors.grey),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    searchHistory,
                    style: const TextStyle(fontSize: 17),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                GestureDetector(
                  onTap: () => removeSearch(searchHistory),
                  child: const Icon(Iconsax.close_circle, size: 20),
                ),
              ],
            ),
          );
        }).toList())
      ],
    );
  }
}
