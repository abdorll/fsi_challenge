import 'package:flutter/material.dart';
import 'package:fsi_app/models/my_transfers.dart';
import 'package:fsi_app/utils/colors.dart';
import 'package:fsi_app/widgets/widgets.dart';
import 'package:fsi_app/models/bill_catefories.dart';
import 'package:fsi_app/screens/bill_payment/bill_payment.dart';
import 'package:fsi_app/services/all_apis_calling.dart';
import 'package:fsi_app/utils/base_provider.dart';
import 'package:fsi_app/widgets/navigation.dart';
import 'package:provider/provider.dart';

class MyTransfers extends StatelessWidget {
  static var type;
  const MyTransfers({Key? key}) : super(key: key);

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
          title: TextOf('My transfers', 20, FontWeight.w500, black),
        ),
        body: Consumer<MyTransfersProvider>(builder: ((context, value, child) {
          return !value.loading
              ? Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: value.allTransfers.length,
                        itemBuilder: ((context, index) {
                          MyTransfersModel transfers =
                              value.allTransfers[index];
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
                                    transfers.status == 'PENDING'
                                        ? Container(
                                            height: 50,
                                            width: 50,
                                            child: Center(
                                              child: IconOf(
                                                  Icons.arrow_upward_rounded,
                                                  white,
                                                  20),
                                            ),
                                            decoration: BoxDecoration(
                                                color: Colors.green.shade700,
                                                border: Border.all(
                                                    color:
                                                        Colors.green.shade700),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          )
                                        : transfers.status == 'FAILED'
                                            ? Container(
                                                height: 50,
                                                width: 50,
                                                child: Center(
                                                  child: IconOf(
                                                      Icons
                                                          .arrow_downward_rounded,
                                                      white,
                                                      20),
                                                ),
                                                decoration: BoxDecoration(
                                                    color: Colors.red.shade600,
                                                    border: Border.all(
                                                        color: Colors
                                                            .red.shade600),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              )
                                            : Container(
                                                height: 50,
                                                width: 50,
                                                child: Center(
                                                  child: IconOf(
                                                      Icons
                                                          .arrow_forward_rounded,
                                                      white,
                                                      20),
                                                ),
                                                decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    border: Border.all(
                                                        color: Colors.blue),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                    XSpace(10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextOf(
                                            '${transfers.full_name!} (${transfers.account_number!})',
                                            15,
                                            FontWeight.w500,
                                            black),
                                        TextOf(
                                            'N${transfers.amount!.toString()}',
                                            13,
                                            FontWeight.w400,
                                            black),
                                        TextOf(
                                            '${transfers.fee!.toString()} naira fee',
                                            13,
                                            FontWeight.w400,
                                            black),
                                        TextOf(
                                            transfers.status!,
                                            10,
                                            FontWeight.w600,
                                            transfers.status == 'FAILED'
                                                ? Colors.red.shade600
                                                : transfers.status == 'PENDING'
                                                    ? Colors.green.shade600
                                                    : Colors.blue),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              // MyTransfers.type = transfers.;
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

class MyTransfersProvider extends BaseProvider {
  List<MyTransfersModel> allTransfers = [];
  void getAllTransfers() async {
    try {
      setLoading = true;
      var transfersList = await AllApiOperations.getMyTransfers();
      List rawtransfersList = List.from(transfersList['data']);
      print(rawtransfersList);
      allTransfers = rawtransfersList
          .map((json) => MyTransfersModel.fromJson(json))
          .toList();
      setLoading = false;
    } catch (e) {
      print(e);
    }
  }

  MyTransfersProvider() {
    getAllTransfers();
  }
}
