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

  // STEP 6
  String? productName;

  int? productionCapacity;

  String? capacityUnit;

  String? hasSni;

  String? halalProcess;

  String? hasHalalCertificate;

  // STEP 7
  bool nibDraftGenerated;

  // COMPLETION
  bool nibCompleted;

  DateTime? nibCompletedAt;

  int nibCompletedCount;

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

    this.businessRunning,

    this.hasNpwp,

    this.businessName,

    this.businessDescription,

    this.employeeCount,

    this.sameAddress,

    this.locationDetermined,

    this.buildingConstruction,

    this.productName,

    this.productionCapacity,

    this.capacityUnit,

    this.hasSni,

    this.halalProcess,

    this.hasHalalCertificate,

    this.currentStep = 1,

    this.unlockedStep = 1,

    this.nibDraftGenerated = false,

    this.nibCompleted = false,

    this.nibCompletedCount = 0,
  });
}