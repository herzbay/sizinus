class AdaptiveLearningNode {
  /// Kondisi agar node ini dijalankan.
  final bool Function() condition;

  /// ID panduan yang direkomendasikan apabila kondisi terpenuhi.
  final List<String> guideIds;

  /// Node lanjutan (child) untuk membentuk learning path.
  final List<AdaptiveLearningNode> children;

  const AdaptiveLearningNode({
    required this.condition,
    this.guideIds = const [],
    this.children = const [],
  });

  /// Mengevaluasi node secara rekursif.
  ///
  /// Semua guideId yang memenuhi kondisi akan dimasukkan ke result.
  void evaluate(Set<String> result) {
    if (!condition()) {
      return;
    }

    result.addAll(guideIds);

    for (final child in children) {
      child.evaluate(result);
    }
  }
}