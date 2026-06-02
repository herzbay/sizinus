class SimulationData {

  // STEP 1
  String? businessCategory;

  // STEP 2
  String? businessType;

  String? kbli;

  String? businessScope;

  // STEP 3
  double? landArea;

  String? landUnit;

  double? capital;

  String? businessScale;

  String? riskLevel;

  // STEP 4
  String? businessRunning;

  String? hasNpwp;

  String? businessName;

  String? businessDescription;

  int? employeeCount;

  // STEP 5
  String? sameAddress;

  String? locationDetermined;

  String? buildingConstruction;

  // PROGRESS
  int currentStep;

  int unlockedStep;

  SimulationData({

    this.businessCategory,

    this.businessType,

    this.kbli,

    this.businessScope,

    this.landArea,

    this.landUnit,

    this.capital,

    this.businessScale,

    this.riskLevel,

    this.currentStep = 1,

    this.unlockedStep = 1,
  });
}