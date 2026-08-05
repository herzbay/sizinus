class DecisionTreeNode {
  final bool Function() condition;

  final List<String> ruleIds;

  final List<DecisionTreeNode> children;

  const DecisionTreeNode({
    required this.condition,
    this.ruleIds = const [],
    this.children = const [],
  });

  void evaluate(Set<String> result) {
    if (!condition()) {
      return;
    }

    result.addAll(ruleIds);

    for (final child in children) {
      child.evaluate(result);
    }
  }
}