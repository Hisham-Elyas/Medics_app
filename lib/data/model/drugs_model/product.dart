// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'drug_information_ar.dart';
import 'drug_information_en.dart';

class Product {
  String? id;
  String? name;
  DrugInformationAr? drugInformationAr;
  DrugInformationEn? drugInformationEn;
  String? images;
  String? pdf;

  Product({
    this.id,
    this.name,
    this.drugInformationAr,
    this.drugInformationEn,
    this.images,
    this.pdf,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        drugInformationAr: json['drugInformationAr'] == null
            ? null
            : DrugInformationAr.fromJson(
                json['drugInformationAr'] as Map<String, dynamic>),
        drugInformationEn: json['drugInformationEn'] == null
            ? null
            : DrugInformationEn.fromJson(
                json['drugInformationEn'] as Map<String, dynamic>),
        images: json['images'] as String?,
        pdf: json['pdf'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'drugInformationAr': drugInformationAr?.toJson(),
        'drugInformationEn': drugInformationEn?.toJson(),
        'images': images,
        'pdf': pdf,
      };

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.drugInformationAr == drugInformationAr &&
        other.drugInformationEn == drugInformationEn &&
        other.images == images &&
        other.pdf == pdf;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        drugInformationAr.hashCode ^
        drugInformationEn.hashCode ^
        images.hashCode ^
        pdf.hashCode;
  }
}
