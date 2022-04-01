class GetSavingsModel {
  int? id;
  String? name;
  num? amount;
  String? interval;
  num? duration;
  String? status;
  GetSavingsModel(
      {this.interval,
      this.id,
      this.name,
      this.amount,
      this.duration,
      this.status});

  GetSavingsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 00;
    interval = json['interval'] ?? 'interval';
    name = json['name'] ?? 'name';
    amount = json['amount'] ?? 00;
    duration = json['duration'] ?? 00;
    status = json['status'] ?? 'status';
  }
}
