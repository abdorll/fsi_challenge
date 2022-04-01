import 'package:fsi_app/services/api_basics.dart';
import 'package:fsi_app/utils/endpoints.dart';

class AllApiOperations {
  //------------------------------------------------------CREATE A TRANSFER
  static createATransfer(
      {account_bank,
      account_number,
      amount,
      narration,
      currency,
      reference,
      callback_url,
      debit_currency}) async {
    Map<String, dynamic> data = {
      "account_bank": account_bank,
      "account_number": account_number,
      "amount": amount,
      "narration": narration,
      "currency": currency,
      "reference": reference,
      "callback_url": callback_url,
      "debit_currency": debit_currency
    };
    return await ApiBasics.makePostRequest(urlcreateAtransfer, data, null);
  }

//----------------------------------------------------- CREATE BULKTRANSFER
  static createBulkTransfer({
    bank_code,
    account_number,
    amount,
    narration,
    currency,
    reference,
  }) async {
    Map<String, dynamic> data = {
      "bank_code": bank_code,
      "account_number": account_number,
      "amount": amount,
      "narration": narration,
      "currency": currency,
      "reference": reference,
    };
    return await ApiBasics.makePostRequest(urlcreateBulkTransfer, data, null);
  }

//----------------------------------------------------- CREATE SAVINGGS PLANS
  static createSavingsPlan({
    amount,
    name,
    interval,
    duration,
  }) async {
    Map<String, dynamic> data = {
      "amount": amount,
      "name": name,
      "interval": interval,
      "duration": duration,
    };
    return await ApiBasics.makePostRequest(urlcreateSavingsPlan, data, null);
  }

//---------------------------------------------------- GET SAVINGS PLANS
  static getSavingsPlans() async {
    return await ApiBasics.makeGetRequest(urlgetSavingsPlans, null);
  }

//----------------------------------------------------- CREATE BILL PAYMENT
  static createBillPayment(
      {country, customer, amount, recurrence, type, reference}) async {
    Map<String, dynamic> data = {
      "country": country,
      "customer": customer,
      "amount": amount,
      "recurrence": recurrence,
      "type": type,
      "reference": reference
    };
    return await ApiBasics.makePostRequest(urlcreateBillPayment, data, null);
  }

//----------------------------------------------------- CREATE BULK BILL PAYMENT
  static createBulkBillPayment(
      {country, customer, amount, recurrence, type, reference}) async {
    Map<String, dynamic> data = {
      "country": country,
      "customer": customer,
      "amount": amount,
      "recurrence": recurrence,
      "type": type,
      "reference": reference
    };
    return await ApiBasics.makePostRequest(
        urlcreateBulkBillPayment, data, null);
  }

  //---------------------------GET BILL CATEGORIES
  static getBillCategories() async {
    return await ApiBasics.makeGetRequest(urlgetBillCategories, null);
  }

  static getMyTransfers() async {
    return await ApiBasics.makeGetRequest(urlgetMyTransfers, null);
  }

  static myBillPayments({String? start, String? end}) async {
    return await ApiBasics.makeGetRequest(
        '${urlmyBillPayments}from=$start&to=$end', null);
  }

  //--------------------------LOGIN ENDPOINT CALLING

  static loginEndpointCalling({
    amount,
    name,
    interval,
    duration,
  }) async {
    Map<String, dynamic> data = {
      "amount": amount,
      "name": name,
      "interval": interval,
      "duration": duration,
    };
    return await ApiBasics.makePostRequest(urlcreateSavingsPlan, data, {
      'sandbox-key': sandboxKey,
      'Authorization': 'dskjdks',
      'Content-Type': 'application/json'
    });
  }
}
