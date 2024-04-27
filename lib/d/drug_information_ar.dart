class DrugInformationAr {
  String? tradeName;
  String? strength;
  String? genericName;
  String? dosageForm;
  String? routeOfAdministration;
  String? sfdaCode;
  String? pacakgeSize;

  DrugInformationAr({
    this.tradeName,
    this.strength,
    this.genericName,
    this.dosageForm,
    this.routeOfAdministration,
    this.sfdaCode,
    this.pacakgeSize,
  });

  factory DrugInformationAr.fromJson(Map<String, dynamic> json) {
    return DrugInformationAr(
      tradeName: json['Trade Name'] as String?,
      strength: json['Strength'] as String?,
      genericName: json['Generic Name'] as String?,
      dosageForm: json['Dosage Form'] as String?,
      routeOfAdministration: json['Route of Administration'] as String?,
      sfdaCode: json['SFDA Code'] as String?,
      pacakgeSize: json['Pacakge Size'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'Trade Name': tradeName,
        'Strength': strength,
        'Generic Name': genericName,
        'Dosage Form': dosageForm,
        'Route of Administration': routeOfAdministration,
        'SFDA Code': sfdaCode,
        'Pacakge Size': pacakgeSize,
      };
}
