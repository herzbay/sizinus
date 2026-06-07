import 'package:flutter/material.dart';

class PermitRecommendationItem {
  final String id;
  final String title;
  final String subtitle;
  final String reason;
  final String statusLabel;
  final IconData icon;
  final Color color;
  final bool isCompleted;
  final int priority;
  final List<String> highlights;

  const PermitRecommendationItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.reason,
    required this.statusLabel,
    required this.icon,
    required this.color,
    required this.isCompleted,
    required this.priority,
    required this.highlights,
  });
}