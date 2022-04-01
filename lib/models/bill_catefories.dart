class BillCategoriesModel {
  int? id;
  String? name;
  String? biller_code;
  num? default_commission;
  String? biller_name;
  String? item_code;
  String? short_name;
  num? fee;
  String? label_name;
  String? country;
  num? amount;

  BillCategoriesModel({
    this.biller_code,
    this.id,
    this.name,
    this.default_commission,
    this.biller_name,
    this.item_code,
    this.short_name,
    this.fee,
    this.label_name,
    this.amount,
    this.country,
  });

  BillCategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 00;
    biller_code = json['biller_code'] ?? 'biller_code';
    name = json['name'] ?? 'name';
    default_commission = json['default_commission'] ?? 0.0;
    biller_name = json['biller_name'] ?? 'biller_name';
    item_code = json['item_code'] ?? 'item_code';
    short_name = json['short_name'] ?? 'short_name';
    fee = json['fee'] ?? 00;
    label_name = json['label_name'] ?? 'label_name';
    amount = json['amount'] ?? 00;
    country = json['country'] ?? 'country';
  }
}
