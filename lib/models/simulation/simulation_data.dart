class SimulationData {

  // STEP 1
  String? businessCategory;

  // STEP 2
  String? businessType;

  String? kbli;

  String? businessScope;

  // PROGRESS
  int currentStep;

  int unlockedStep;

  SimulationData({

    this.businessCategory,

    this.businessType,

    this.kbli,

    this.businessScope,

    this.currentStep = 1,

    this.unlockedStep = 1,
  });
}