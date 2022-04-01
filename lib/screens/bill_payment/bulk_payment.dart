import 'package:flutter/material.dart';
import 'package:fsi_app/models/getMyPayments.dart';
import 'package:fsi_app/screens/bill_payment/payment_date_range.dart';
import 'package:fsi_app/utils/colors.dart';
import 'package:fsi_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fsi_app/utils/colors.dart';
import 'package:fsi_app/widgets/widgets.dart';
import 'package:fsi_app/models/bill_catefories.dart';
import 'package:fsi_app/screens/bill_payment/bill_payment.dart';
import 'package:fsi_app/services/all_apis_calling.dart';
import 'package:fsi_app/utils/base_provider.dart';
import 'package:fsi_app/widgets/navigation.dart';
import 'package:provider/provider.dart';

class BulkBilPaymentPage extends StatelessWidget {
  static var type;
  const BulkBilPaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            child: IconOf(Icons.arrow_back_ios_new_rounded, black, 20),
            onTap: () {
              Navigation.previous(context);
            },
          ),
          backgroundColor: white,
          centerTitle: true,
          title: TextOf('My bills', 20, FontWeight.w500, black),
        ),
        body: Consumer<MyPaymentsProvider>(builder: ((context, value, child) {
          return !value.loading
              ? Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: value.allPaymentDates.length,
                        itemBuilder: ((context, index) {
                          MyBillPaymentsModel billsPayments =
                              value.allPaymentDates[index];
                          return InkWell(
                            child: SideSpace(
                              10,
                              5,
                              Card(
                                elevation: 15,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 70,
                                      width: 70,
                                      child: Center(
                                        child: TextOf(
                                            billsPayments.commission!
                                                .toString(),
                                            15,
                                            FontWeight.w500,
                                            white),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.blue.shade600,
                                          border: Border.all(
                                              color: Colors.blue.shade600),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    XSpace(10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextOf(
                                            '${billsPayments.product_name!} (${billsPayments.product!})',
                                            15,
                                            FontWeight.w500,
                                            black),
                                        TextOf(
                                            'N${billsPayments.amount!.toString()}',
                                            13,
                                            FontWeight.w400,
                                            black),
                                        TextOf(billsPayments.customer_id!, 13,
                                            FontWeight.w500, black),
                                        TextOf(billsPayments.frequency!, 13,
                                            FontWeight.w400, black),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              // BulkBilPaymentPage.type = billsPayments.;
                              // Navigation.withReturn(
                              //     context, const BillPaymentPage());
                            },
                          );
                        }),
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        })));
  }
}

//-----------------------------------------------BILL CATEGORIES PROVIDER
