import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppBannerBar extends StatefulWidget {
  const AppBannerBar({super.key});

  @override
  State<AppBannerBar> createState() => _AppBannerBarState();
}

class _AppBannerBarState extends State<AppBannerBar> {
  final Set<String> _dismissed = {};

  bool _isWithinRange(String start, String end) {
    final today = DateTime.now();
    final day = DateTime(today.year, today.month, today.day);
    if (start.isNotEmpty) {
      final s = DateTime.tryParse(start);
      if (s != null && day.isBefore(DateTime(s.year, s.month, s.day))) {
        return false;
      }
    }
    if (end.isNotEmpty) {
      final e = DateTime.tryParse(end);
      if (e != null && day.isAfter(DateTime(e.year, e.month, e.day))) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('app_banners').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox.shrink();

        final banners = snapshot.data!.docs.where((doc) {
          final d = doc.data();
          final message = (d['message'] ?? d['title'] ?? '').toString().trim();
          final active = d['is_active'] != false;
          final start = (d['start_date'] ?? '').toString();
          final end = (d['end_date'] ?? '').toString();
          return message.isNotEmpty &&
              active &&
              !_dismissed.contains(doc.id) &&
              _isWithinRange(start, end);
        }).toList();

        if (banners.isEmpty) return const SizedBox.shrink();

        return Column(
          children: banners.map((doc) {
            final d = doc.data();
            final message = (d['message'] ?? d['title'] ?? '').toString();

            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Material(
                color: const Color(0xFF159954).withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 10, 4, 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          message,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: Color(0xFF0B3D2E),
                          ),
                        ),
                      ),
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        icon: const Icon(Icons.close, size: 18),
                        onPressed: () {
                          setState(() => _dismissed.add(doc.id));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
