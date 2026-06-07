import 'package:flutter/material.dart';

class RewardBadge {
  final String id;
  final String title;
  final String description;
  final String imageAsset;
  final Color color;

  const RewardBadge({
    required this.id,
    required this.title,
    required this.description,
    required this.imageAsset,
    required this.color,
  });
}