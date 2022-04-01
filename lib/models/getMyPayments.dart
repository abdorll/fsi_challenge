class MyBillPaymentsModel {
  int? id;
  String? currency;
  String? customer_id;
  String? frequency;
  String? amount;
  String? product;
  String? product_name;
  num? commission;

  MyBillPaymentsModel({
    this.customer_id,
    this.id,
    this.currency,
    this.frequency,
    this.amount,
    this.product,
    this.product_name,
    this.commission,
  });

  MyBillPaymentsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 00;
    customer_id = json['customer_id'] ?? 'customer_id';
    currency = json['currency'] ?? 'currency';
    frequency = json['frequency'] ?? 'frequency';
    amount = json['amount'] ?? 'amount';
    product = json['product'] ?? 'product';
    product_name = json['product_name'] ?? 'product_name';
    commission = json['commission'] ?? 00;
  }
}
