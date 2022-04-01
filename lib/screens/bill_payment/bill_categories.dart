import 'package:flutter/material.dart';
import 'package:fsi_app/models/bill_catefories.dart';
import 'package:fsi_app/screens/bill_payment/bill_payment.dart';
import 'package:fsi_app/screens/transfer_money/create_transfer.dart';
import 'package:fsi_app/services/all_apis_calling.dart';
import 'package:fsi_app/utils/base_provider.dart';
import 'package:fsi_app/utils/colors.dart';
import 'package:fsi_app/widgets/navigation.dart';
import 'package:fsi_app/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:fsi_app/services/api_basics.dart';
import 'package:fsi_app/utils/endpoints.dart';

class BillCategoriesPage extends StatelessWidget {
  static var type;
  const BillCategoriesPage({Key? key}) : super(key: key);

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
          title:
              TextOf('Select category to continue', 20, FontWeight.w500, black),
        ),
        body: Consumer<GetBillCategoriesProvider>(
            builder: ((context, value, child) {
          return !value.loading
              ? Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: value.allCategories.length,
                        itemBuilder: ((context, index) {
                          BillCategoriesModel billCats =
                              value.allCategories[index];
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
                                      height: 50,
                                      width: 50,
                                      child: Center(
                                        child: TextOf(billCats.id!.toString(),
                                            15, FontWeight.w500, white),
                                      ),
                                      decoration: BoxDecoration(
                                          color: orange,
                                          border: Border.all(color: orange),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    XSpace(10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextOf(
                                            '${billCats.short_name!} (${billCats.name!})',
                                            15,
                                            FontWeight.w500,
                                            black),
                                        TextOf(billCats.label_name!, 13,
                                            FontWeight.w400, black),
                                        TextOf(billCats.biller_code!, 10,
                                            FontWeight.w400, black),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              BillCategoriesPage.type = billCats.name;
                              Navigation.withReturn(
                                  context, const BillPaymentPage());
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

class GetBillCategoriesProvider extends BaseProvider {
  List<BillCategoriesModel> allCategories = [];
  void getbillCats() async {
    try {
      setLoading = true;
      var categoriesList = await AllApiOperations.getBillCategories();
      List rawCategoriesList = List.from(categoriesList['data']);
      print(rawCategoriesList);
      allCategories = rawCategoriesList
          .map((json) => BillCategoriesModel.fromJson(json))
          .toList();
      setLoading = false;
    } catch (e) {
      print(e);
    }
  }

  GetBillCategoriesProvider() {
    getbillCats();
  }
}
