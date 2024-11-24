import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:locator_tcs/controller/home_screen_controller.dart';
import 'package:locator_tcs/models/location_model.dart';
import 'package:provider/provider.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({
    super.key,
  });

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  late HomeScreenController cnt;
  @override
  void initState() {
    // TODO: implement initState

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      cnt.onFetchingHomeData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    cnt = Provider.of<HomeScreenController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: const Text(
            "TCS Locator",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: "MontserratRegular",
                fontSize: 18),
          ),
        ),
        backgroundColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Image.asset(
              'assets/images/tcs_logo.png', // Replace with your image path
              height: 80, // Adjust the height as needed
              width: 110, // Adjust the width as needed
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Background color of the search bar
                  borderRadius: BorderRadius.circular(8.0), // Rounded corners
                  border: Border.all(
                    // Border frame
                    color: Colors.black12,
                    width: 1.5,
                  ),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    hintText: "Search here...",
                    border: InputBorder.none, // Removes default underline
                    prefixIcon:
                        Icon(Icons.search, color: Colors.grey), // Search icon
                  ),
                  style: TextStyle(fontFamily: "MontserratMedium"),
                  onChanged: (query) {
                    cnt.updateSearchQuery(query);
                  },
                ),
              )),
              SizedBox(width: 10.0),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(0)),
                      ),
                      builder: (context) {
                        return Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                          color: Colors.white,
                          height: 770,
                          child: ListView.separated(
                            itemCount: (cnt.distinctCountries ?? []).length,
                            itemBuilder: (BuildContext context, int index) {
                              String? country = cnt.distinctCountries?[index];

                              return GestureDetector(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 15),
                                      child: Text(
                                        (country ?? ""),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: "MontserratMedium",
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                onTap: () =>
                                    cnt.onSortByClicked(country, context),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Divider(
                                    color: Colors.black12,
                                    thickness:
                                        1, // Add padding to the right of the line
                                  )
                                ],
                              );
                            },
                          ),
                        );
                      });
                },
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                    width: 80, // Space inside the box
                    decoration: BoxDecoration(
                      color: Colors.white, // Box background color
                      borderRadius:
                          BorderRadius.circular(8.0), // Rounded corners
                      border: Border.all(
                          color: Colors.black12, width: 1.0), // Border
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            cnt.selectedCountry,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "MontserratRegular"),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.sort_sharp, // Sort icon
                          color: Colors.black, // Icon color
                          size: 24.0, // Icon size
                        ),
                      ],
                    )),
              )
            ],
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: ListView.separated(
                itemCount: (cnt.filteredtcslocations ?? []).length,
                itemBuilder: (BuildContext context, int index) {
                  Location? location = cnt.filteredtcslocations?[index];

                  return GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (location?.location ?? ""),
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "MontserratRegular"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                (location?.fulllocation ?? ""),
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black87,
                                    fontFamily: "MontserratMedium"),
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: Icon(
                            Icons.arrow_forward_ios, // Sort icon
                            color: Colors.black54, // Icon color
                            size: 20.0, // Icon size
                          ),
                        )
                      ],
                    ),
                    onTap: () => cnt.onItemClicked(location, context),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 30,
                  );
                },
              ),
            ),
          )
        ]),
      ),
    );
  }
}
