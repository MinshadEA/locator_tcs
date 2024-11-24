import 'dart:async';

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
    if (_query.isEmpty) {
      sortList(selectedCountry);
    } else {
      filteredtcslocations = (filteredtcslocations ?? [])
          .where((item) =>
              (item.location ?? "")
                  .toLowerCase()
                  .contains(_query.toLowerCase()) ||
              (item.geo ?? "").toLowerCase().contains(_query.toLowerCase()) ||
              (item.area ?? "").toLowerCase().contains(_query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void onSortByClicked(String? item, BuildContext context) {
    selectedCountry = item ?? "";
    sortList(selectedCountry);
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
    if (_query.isNotEmpty) {
      updateSearchQuery(_query);
    }
  }

  void onItemClicked(Location? item, BuildContext context) async {
    item?.address = item?.address?.replaceAll("\n", " ");
    ItemDetail = item;
    Navigator.pushNamed(context, "/details_screen");
    _goToTheTcsLocation(onGetLocation(LatLng(
        ItemDetail?.geometry?.lat ?? 0, ItemDetail?.geometry?.lng ?? 0)));
    notifyListeners();
  }

  void OpenDialer(String phone) async {
    await launchUrl(Uri(scheme: 'tel', path: phone));
  }

  void OpenEmail(String email) async {
    await launchUrl(Uri(scheme: 'mailto', path: email));
  }

  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();

  CameraPosition onGetLocation(LatLng latlng) {
    CameraPosition _kGooglePlex = CameraPosition(
      target: latlng,
      zoom: 14.4746,
    );
    return _kGooglePlex;
  }

  Future<void> _goToTheTcsLocation(CameraPosition val) async {
    final GoogleMapController controller = await mapController.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(val));
  }
}
