class DrugInformationEn {
  String? tradeName;
  String? strength;
  String? genericName;
  String? dosageForm;
  String? routeOfAdministration;
  String? sfdaCode;
  String? pacakgeSize;

  DrugInformationEn({
    this.tradeName,
    this.strength,
    this.genericName,
    this.dosageForm,
    this.routeOfAdministration,
    this.sfdaCode,
    this.pacakgeSize,
  });

  factory DrugInformationEn.fromJson(Map<String, dynamic> json) {
    return DrugInformationEn(
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
