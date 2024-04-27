// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'drug_information_ar.dart';
import 'drug_information_en.dart';

class D {
  DrugInformationAr? drugInformationAr;
  DrugInformationEn? drugInformationEn;
  String? images;
  String? pdf;

  D({
    this.drugInformationAr,
    this.drugInformationEn,
    this.images,
    this.pdf,
  });

  factory D.fromJson(Map<String, dynamic> json) => D(
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
        'drugInformationAr': drugInformationAr?.toJson(),
        'drugInformationEn': drugInformationEn?.toJson(),
        'images': images,
        'pdf': pdf,
      };

  @override
  bool operator ==(covariant D other) {
    if (identical(this, other)) return true;

    return other.images == images && other.pdf == pdf;
  }

  @override
  int get hashCode => images.hashCode ^ pdf.hashCode;
}
