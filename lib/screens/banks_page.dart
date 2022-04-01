import 'package:flutter/material.dart';
import 'package:fsi_app/models/getAllBanksModel.dart';
import 'package:fsi_app/providers/getAllBanks.dart';
import 'package:fsi_app/screens/transfer_money/create_transfer.dart';
import 'package:fsi_app/utils/base_provider.dart';
import 'package:fsi_app/utils/colors.dart';
import 'package:fsi_app/utils/constants.dart';
import 'package:fsi_app/widgets/navigation.dart';
import 'package:fsi_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class GetAllBanksPage extends StatelessWidget {
  static var bankCode;
  static var bankName;
  const GetAllBanksPage({Key? key}) : super(key: key);

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
          title: TextOf('Select bank to continue', 20, FontWeight.w500, black),
        ),
        body: Consumer<GetAllBanksProvider>(builder: ((context, value, child) {
          return !value.loading
              ? Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: value.allBanks.length,
                        itemBuilder: ((context, index) {
                          GetAllBanksModel banks = value.allBanks[index];
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
                                        child: TextOf(banks.code!, 15,
                                            FontWeight.w500, white),
                                      ),
                                      decoration: BoxDecoration(
                                          color: orange,
                                          border: Border.all(color: orange),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    XSpace(10),
                                    TextOf(banks.name!, 20, FontWeight.w500,
                                        black),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              GetAllBanksPage.bankCode = banks.code;
                              GetAllBanksPage.bankName = banks.name;
                              Navigation.withReturn(
                                  context, const CreateTransferPage());
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
