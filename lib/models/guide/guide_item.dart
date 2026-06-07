import 'package:flutter/material.dart';

class GuideSection {
  final String title;
  final String body;
  final List<String> bullets;

  const GuideSection({
    required this.title,
    required this.body,
    this.bullets = const [],
  });
}

class GuideItem {
  final String id;
  final String title;
  final String subtitle;
  final String overview;
  final IconData icon;
  final Color color;
  final bool isUnlocked;
  final int priority;
  final List<String> highlights;
  final List<GuideSection> sections;

  const GuideItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.overview,
    required this.icon,
    required this.color,
    required this.isUnlocked,
    required this.priority,
    required this.highlights,
    required this.sections,
  });
}