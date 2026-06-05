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

    this.nibCompletedAt,
  });

  Map<String, dynamic> toJson() {

    return {

      'businessCategory': businessCategory,

      'businessType': businessType,
      'kbli': kbli,
      'businessScope': businessScope,

      'landArea': landArea,
      'landUnit': landUnit,
      'capital': capital,
      'businessScale': businessScale,
      'riskLevel': riskLevel,

      'businessRunning': businessRunning,
      'hasNpwp': hasNpwp,
      'businessName': businessName,
      'businessDescription': businessDescription,
      'employeeCount': employeeCount,

      'sameAddress': sameAddress,
      'locationDetermined': locationDetermined,
      'buildingConstruction': buildingConstruction,

      'productName': productName,
      'productionCapacity': productionCapacity,
      'capacityUnit': capacityUnit,
      'hasSni': hasSni,
      'halalProcess': halalProcess,
      'hasHalalCertificate': hasHalalCertificate,

      'nibDraftGenerated': nibDraftGenerated,

      'nibCompleted': nibCompleted,
      'nibCompletedCount': nibCompletedCount,

      'nibCompletedAt':
          nibCompletedAt?.toIso8601String(),

      'currentStep': currentStep,
      'unlockedStep': unlockedStep,
    };
  }

  factory SimulationData.fromJson(
    Map<String, dynamic> json,
  ) {

    return SimulationData(

      businessCategory:
          json['businessCategory'],

      businessType:
          json['businessType'],

      kbli:
          json['kbli'],

      businessScope:
          json['businessScope'],

      landArea:
          (json['landArea'] as num?)
              ?.toDouble(),

      landUnit:
          json['landUnit'],

      capital:
          (json['capital'] as num?)
              ?.toDouble(),

      businessScale:
          json['businessScale'],

      riskLevel:
          json['riskLevel'],

      businessRunning:
          json['businessRunning'],

      hasNpwp:
          json['hasNpwp'],

      businessName:
          json['businessName'],

      businessDescription:
          json['businessDescription'],

      employeeCount:
          json['employeeCount'],

      sameAddress:
          json['sameAddress'],

      locationDetermined:
          json['locationDetermined'],

      buildingConstruction:
          json['buildingConstruction'],

      productName:
          json['productName'],

      productionCapacity:
          json['productionCapacity'],

      capacityUnit:
          json['capacityUnit'],

      hasSni:
          json['hasSni'],

      halalProcess:
          json['halalProcess'],

      hasHalalCertificate:
          json['hasHalalCertificate'],

      nibDraftGenerated:
          json['nibDraftGenerated'] ?? false,

      nibCompleted:
          json['nibCompleted'] ?? false,

      nibCompletedCount:
          json['nibCompletedCount'] ?? 0,

      nibCompletedAt:
          json['nibCompletedAt'] != null
              ? DateTime.parse(
                  json['nibCompletedAt'],
                )
              : null,

      currentStep:
          json['currentStep'] ?? 1,

      unlockedStep:
          json['unlockedStep'] ?? 1,
    );
  }
}