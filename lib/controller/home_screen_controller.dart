import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locator_tcs/api/api_service.dart';
import 'package:locator_tcs/models/location_model.dart';
import 'package:locator_tcs/models/location_model.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreenController extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool isLoading = false;
  TcsLocationModel? tcsLocation;
  List<Location>? filteredtcslocations;
  String _query = "";
  String selectedCountry = "ALL";
  List<String?>? distinctCountries;
  LatLng initialPosition = LatLng(12.9716, 77.5946);

  Location? ItemDetail;
  void onFetchingHomeData() async {
    isLoading = true;
    notifyListeners();
    TcsLocationModel? response = await _apiService.fetchPosts();

    if (response != null) {
      tcsLocation = response;
      filteredtcslocations = tcsLocation?.locations;
      distinctCountries = tcsLocation?.locations
          ?.map((item) => item.area) // Extract the 'country' field
          .toSet() // Remove duplicates
          .toList();
      distinctCountries?.insert(0, 'ALL');
      isLoading = false;
      notifyListeners();
    } else {
      isLoading = false;
      notifyListeners();
    }
  }

  void updateSearchQuery(String query) {
    _query = query;
    selectedCountry=query;
    if (_query == "") {
      sortList(selectedCountry);
    } else {
      filteredtcslocations = (tcsLocation?.locations ?? [])
          .where((item) {
            return
             (item.area ?? "").toLowerCase().contains("latin");
          })
          .toList();
    }
    notifyListeners();
  }

  void onSortByClicked(String? item, BuildContext context) {
    selectedCountry = item ?? "";
    sortList(selectedCountry);
    selectedCountry = "ABC";
    notifyListeners();
    Navigator.pop(context);
  }

  Future<void> sortList(String country) async {
    if (country == "ALL") {
      filteredtcslocations = tcsLocation?.locations;
    } else {
      filteredtcslocations = tcsLocation?.locations
          ?.where((item) =>
              (item.area ?? "").toLowerCase().contains(country.toLowerCase()))
          .toList();
    }
    print("country: $country");
    print(filteredtcslocations);
    //updateSearchQuery(_query);
  }

  String truncateText(String text) {
    if (text.length > 3) {
      return text.substring(0, 3) + '..';
    }
    return text;
  }

  void onItemClicked(Location? item, BuildContext context) {
    item?.address = item?.address?.replaceAll("\n", " ");
    //initialPosition=LatLng(item?.geometry?.lat??37.7749, item?.geometry?.lng??-122.4194);
    ItemDetail = item;
    Navigator.pushNamed(context, "/details_screen");
  }

  void OpenDialer(String phone) async {
    await launchUrl(Uri(scheme: 'tel', path: phone));
  }

  void OpenEmail(String email) async {
    await launchUrl(Uri(scheme: 'mailto', path: email));
  }
}
