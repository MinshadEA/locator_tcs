import 'package:flutter/material.dart';
import 'package:locator_tcs/api/api_service.dart';
import 'package:locator_tcs/models/location_model.dart';
// import 'package:url_launcher/url_launcher.dart';

class HomeScreenController extends ChangeNotifier {
  final ApiService _apiService = ApiService();


  bool isLoading=false;
  TcsLocationModel? tcsLocation;
  Location? ItemDetail;
  void onFetchingHomeData() async {
    isLoading=true;
    notifyListeners();
    TcsLocationModel? response = await _apiService.fetchPosts();

    if (response != null) {
      tcsLocation = response;
      isLoading=false;
      notifyListeners();
    } else {
      isLoading=false;
      notifyListeners();
    }
  }

  void onItemClicked(Location? item,BuildContext context)
  {
    item?.address=item?.address?.replaceAll("\n", " ");
    ItemDetail=item;
    Navigator.pushNamed(
      context,"/details_screen"
    );
  }

  void OpenDialer(String phone)
  async {
    //await launchUrl(Uri(scheme: 'tel',path: phone));
  }
  void OpenEmail(String email)
  async {
    //await launchUrl(Uri(scheme: 'mailto',path: email));
  }

}
