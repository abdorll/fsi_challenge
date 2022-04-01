class GetAllBanksModel {
  int? id;
  String? code;
  String? name;

  GetAllBanksModel({this.code, this.id, this.name});

  GetAllBanksModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 00;
    code = json['code'] ?? 'code';
    name = json['name'] ?? 'name';
  }
}
