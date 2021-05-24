import 'MedicineDTO.dart';

class MedicineListResponse {
  String responseCode;
  String responseMessage;
  List<MedicineDTO> medicines;
  int totalMedicines;

  MedicineListResponse(
      {this.responseCode,
        this.responseMessage,
        this.medicines,
        this.totalMedicines});

  MedicineListResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'];
    responseMessage = json['responseMessage'];
    if (json['medicines'] != null) {
      medicines = new List<MedicineDTO>();
      json['medicines'].forEach((v) {
        medicines.add(new MedicineDTO.fromJson(v));
      });
    }
    totalMedicines = json['totalMedicines'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseCode'] = this.responseCode;
    data['responseMessage'] = this.responseMessage;
    if (this.medicines != null) {
      data['medicines'] = this.medicines.map((v) => v.toJson()).toList();
    }
    data['totalMedicines'] = this.totalMedicines;
    return data;
  }
}

