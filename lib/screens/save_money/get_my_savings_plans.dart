import 'package:flutter/material.dart';
import 'package:fsi_app/models/get_savings.dart';
import 'package:fsi_app/utils/colors.dart';
import 'package:fsi_app/widgets/widgets.dart';
import 'package:fsi_app/services/all_apis_calling.dart';
import 'package:fsi_app/utils/base_provider.dart';
import 'package:fsi_app/widgets/navigation.dart';
import 'package:provider/provider.dart';

class GetMySavingsPlansPage extends StatelessWidget {
  static var type;
  const GetMySavingsPlansPage({Key? key}) : super(key: key);

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
          title: TextOf('My savings', 20, FontWeight.w500, black),
        ),
        body: Consumer<GetMySavingsPlansPageProvider>(
            builder: ((context, value, child) {
          return !value.loading
              ? Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: value.allSavings.length,
                        itemBuilder: ((context, index) {
                          GetSavingsModel savings = value.allSavings[index];
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
                                    savings.status == 'active'
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
                                        : savings.status == 'cancelled'
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
                                        TextOf(savings.name!, 15,
                                            FontWeight.w500, black),
                                        TextOf('N${savings.amount!.toString()}',
                                            13, FontWeight.w400, black),
                                        TextOf(savings.interval!, 13,
                                            FontWeight.w400, black),
                                        TextOf(
                                            savings.status!.toUpperCase(),
                                            10,
                                            FontWeight.w600,
                                            savings.status == 'cancelled'
                                                ? Colors.red.shade600
                                                : savings.status == 'active'
                                                    ? Colors.green.shade600
                                                    : Colors.blue),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              // GetMySavingsPlansPage.type = savings.;
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

class GetMySavingsPlansPageProvider extends BaseProvider {
  List<GetSavingsModel> allSavings = [];
  void getAllSavings() async {
    try {
      setLoading = true;
      var savingsList = await AllApiOperations.getSavingsPlans();
      List rawsavingsList = List.from(savingsList['data']);
      print(rawsavingsList);
      allSavings =
          rawsavingsList.map((json) => GetSavingsModel.fromJson(json)).toList();
      setLoading = false;
    } catch (e) {
      print(e);
    }
  }

  GetMySavingsPlansPageProvider() {
    getAllSavings();
  }
}
