// ignore_for_file: avoid_print

import 'package:fsi_app/models/getAllBanksModel.dart';
import 'package:fsi_app/services/api_basics.dart';
import 'package:fsi_app/utils/base_provider.dart';
import 'package:fsi_app/utils/endpoints.dart';

class GetAllBanksProvider extends BaseProvider {
  List<GetAllBanksModel> allBanks = [];
  void getBanks() async {
    try {
      setLoading = true;
      var banksList = await ApiBasics.makeGetRequest(urlgetAllBanks, null);
      List rawBnaksList = List.from(banksList['data']);
      print(rawBnaksList);
      allBanks =
          rawBnaksList.map((json) => GetAllBanksModel.fromJson(json)).toList();
      setLoading = false;
    } catch (e) {
      print(e);
    }
  }

  GetAllBanksProvider() {
    getBanks();
  }
}
