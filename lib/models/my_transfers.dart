class MyTransfersModel {
  int? id;
  num? amount;
  num? fee;
  String? account_number;
  String? full_name;
  String? status;
  String? narration;
  String? complete_message;
  String? bank_name;

  MyTransfersModel({
    this.full_name,
    this.id,
    this.account_number,
    this.status,
    this.narration,
    this.complete_message,
    this.fee,
    this.bank_name,
    this.amount,
  });

  MyTransfersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 00;
    full_name = json['full_name'] ?? 'full_name';
    account_number = json['account_number'] ?? 00;
    status = json['status'] ?? 'status';
    narration = json['narration'] ?? 'narration';
    complete_message = json['complete_message'] ?? 'complete_message';
    fee = json['fee'] ?? 00;
    bank_name = json['bank_name'] ?? 'bank_name';
    amount = json['amount'] ?? 'amount';
  }
}
