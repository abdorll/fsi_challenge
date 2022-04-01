import 'package:flutter/material.dart';
import 'package:fsi_app/helpers/Alerts.dart';
import 'package:fsi_app/models/getMyPayments.dart';
import 'package:fsi_app/screens/bill_payment/bulk_payment.dart';
import 'package:fsi_app/services/all_apis_calling.dart';
import 'package:fsi_app/utils/base_provider.dart';
import 'package:fsi_app/utils/colors.dart';
import 'package:fsi_app/widgets/navigation.dart';
import 'package:fsi_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class PaymentDate extends StatefulWidget {
  static String? start;
  static String? end;
  PaymentDate({
    Key? key,
  }) : super(key: key);

  @override
  _PaymentDateState createState() => _PaymentDateState();
}

class _PaymentDateState extends State<PaymentDate> {
  DateTime? selectedDate;
  DateTime? secondDselectedDate;
  String getNewDate() {
    if (selectedDate == null) {
      return 'yyyy-mm-dd';
    } else {
      return '${selectedDate!.year}-${selectedDate!.month.toString().length > 1 ? selectedDate!.month : '0${selectedDate!.month}'}-${selectedDate!.day.toString().length > 1 ? selectedDate!.day : '0${selectedDate!.day}'}';
    }
  }

  String secondGetNewDate() {
    if (secondDselectedDate == null) {
      return 'yyyy-mm-dd';
    } else {
      return '${secondDselectedDate!.year}-${secondDselectedDate!.month.toString().length > 1 ? secondDselectedDate!.month : '0${secondDselectedDate!.month}'}-${secondDselectedDate!.day.toString().length > 1 ? secondDselectedDate!.day : '0${secondDselectedDate!.day}'}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        leading: InkWell(
          child: IconOf(Icons.arrow_back_ios_new_rounded, black, 20),
          onTap: () {
            Navigation.previous(context);
          },
        ),
        backgroundColor: white,
        centerTitle: true,
        title: TextOf('Bill payments', 20, FontWeight.w500, black),
      ),
      body: SafeArea(
        child: Consumer<MyPaymentsProvider>(builder: (context, value, child) {
          Future.delayed(const Duration(milliseconds: 300), () {
            value.setstartDate = getNewDate();
            value.setendDate = secondGetNewDate();
          });
          return SideSpace(
            10,
            10,
            Column(
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  YSpace(20),
                  TextOf('Bill payments by date', 23, FontWeight.w700, black),
                  YSpace(25),
                  TextOfDecoration(
                      'Get your bill payments based on the date you payed',
                      20,
                      FontWeight.w500,
                      ash,
                      TextAlign.left),
                  YSpace(45),
                ]),
                Expanded(
                  child: Column(children: [
                    YSpace(10),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            dateSelector(context);
                          },
                          child: Material(
                            borderRadius: BorderRadius.circular(20),
                            elevation: 6.0,
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                children: [
                                  Container(
                                    height: 100,
                                    child: Center(
                                      child: SideSpace(
                                          10,
                                          10,
                                          TextOf('From', 15, FontWeight.w500,
                                              white)),
                                    ),
                                    decoration: BoxDecoration(
                                        color: orange,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                  XSpace(10),
                                  TextOfDecoration(getNewDate(), 20,
                                      FontWeight.w400, ash, TextAlign.left),
                                ],
                              ),
                            ),
                          ),
                        ),
                        YSpace(10),
                        InkWell(
                          onTap: () {
                            secondDateSelector(context);
                          },
                          child: Material(
                            borderRadius: BorderRadius.circular(20),
                            elevation: 6.0,
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                children: [
                                  Container(
                                    height: 100,
                                    child: Center(
                                      child: SideSpace(
                                          10,
                                          10,
                                          TextOf('To      ', 15,
                                              FontWeight.w500, white)),
                                    ),
                                    decoration: BoxDecoration(
                                        color: orange,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                  XSpace(10),
                                  TextOfDecoration(secondGetNewDate(), 20,
                                      FontWeight.w400, ash, TextAlign.left),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    YSpace(40),
                    value.formValidity == true
                        ? InkWell(
                            onTap: () {
                              value.getAllBillPayments(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: white, width: 2),
                                  color: orange,
                                  borderRadius: BorderRadius.circular(13)),
                              child: Center(
                                child: SideSpace(
                                    30,
                                    15,
                                    TextOf("Get payments", 20, FontWeight.w800,
                                        white)),
                              ),
                            ))
                        : InkWell(
                            child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: white, width: 2),
                                color: Colors.grey.shade400,
                                borderRadius: BorderRadius.circular(13)),
                            child: Center(
                              child: SideSpace(
                                  30,
                                  15,
                                  TextOf("Get payments", 20, FontWeight.w800,
                                      white)),
                            ),
                          )),
                    YSpace(10),
                    // PaymentDate()
                  ]),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Future dateSelector(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) {
      Future.delayed(Duration(seconds: 1));
      Alerts.errorAlert(
          context, 'Both dates are required', Navigation.previous(context));
    }
    setState(() {
      selectedDate = newDate;
    });
  }

  Future secondDateSelector(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) {
      Future.delayed(Duration(seconds: 1));
      Alerts.errorAlert(
          context, 'Both dates are required', Navigation.previous(context));
    }

    setState(() {
      secondDselectedDate = newDate;
    });
  }
}

//------------------------------------MY TRANSFERS PROVIFER

class MyPaymentsProvider extends BaseProvider {
  String? _startDate;
  String? _endDate;
  bool formValidity = false;

  String get startDate => _startDate ?? '';
  String get endDate => _endDate ?? '';

  set setstartDate(String startDate) {
    _startDate = startDate;
    checkFormValidity();
    notifyListeners();
  }

  set setendDate(String endDate) {
    _endDate = endDate;
    checkFormValidity();
    notifyListeners();
  }

  void checkFormValidity() {
    if ((startDate != 'yyyy-mm-dd') && (endDate != 'yyyy-mm-dd')) {
      formValidity = true;
    } else {
      formValidity = false;
    }
    notifyListeners();
  }

  List<MyBillPaymentsModel> allPaymentDates = [];
  void getAllBillPayments(
    BuildContext context,
  ) async {
    print("trying to pay get payments");
    try {
      setLoading = true;
      Alerts.loadingAlert(context, 'Getting bils...');
      var savingssList = await AllApiOperations.myBillPayments(
          start: _startDate!, end: _endDate!);
      List rawsavingssList = List.from(savingssList['data']['transactions']);
      print(rawsavingssList);
      allPaymentDates = rawsavingssList
          .map((json) => MyBillPaymentsModel.fromJson(json))
          .toList();
      setLoading = false;
      if (savingssList['status'] == 'success') {
        Navigation.previous(context);
        Navigation.withReturn(context, const BulkBilPaymentPage());
      } else {
        print('UNABLE TO FETCH BILL PAYMENTS');
      }
    } catch (e) {
      print(e);
    }
  }

  MyPaymentsProvider(context) {
    getAllBillPayments(context);
  }
}
