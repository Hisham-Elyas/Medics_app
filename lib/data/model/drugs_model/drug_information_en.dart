// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  @override
  bool operator ==(covariant DrugInformationEn other) {
    if (identical(this, other)) return true;

    return other.tradeName == tradeName &&
        other.strength == strength &&
        other.genericName == genericName &&
        other.dosageForm == dosageForm &&
        other.routeOfAdministration == routeOfAdministration &&
        other.sfdaCode == sfdaCode &&
        other.pacakgeSize == pacakgeSize;
  }

  @override
  int get hashCode {
    return tradeName.hashCode ^
        strength.hashCode ^
        genericName.hashCode ^
        dosageForm.hashCode ^
        routeOfAdministration.hashCode ^
        sfdaCode.hashCode ^
        pacakgeSize.hashCode;
  }
}
