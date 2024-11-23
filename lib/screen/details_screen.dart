import 'package:flutter/material.dart';
import 'package:locator_tcs/controller/home_screen_controller.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late HomeScreenController cnt;
  @override
  Widget build(BuildContext context) {
    cnt = Provider.of<HomeScreenController>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "TCS Locator",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          iconTheme: IconThemeData(color: Colors.white),
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
        body: Column(
          children: [
            Expanded(
                child: Container(
              color: Colors.black54,
            )),
            Expanded(
                child: Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(15,20,15,10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ("TCS Center Name"),
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.grey),
                            ),
                            Text(
                              (cnt.ItemDetail?.location ?? ""),
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                        Center(
                          child:
                          Icon(
                            Icons.business, // Sort icon
                            color: Colors.grey, // Icon color
                            size: 25.0, // Icon size
                          ),
                        )

                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ("Location"),
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.grey),
                                ),
                                Text(
                                  (cnt.ItemDetail?.fulllocation??""),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                        Center(
                          child:
                          Icon(
                            Icons.pin_drop, // Sort icon
                            color: Colors.grey, // Icon color
                            size: 25.0, // Icon size
                          ),
                        )

                      ],
                    ),
                    SizedBox(height: 12),
                    GestureDetector(
                      child: Row(
                        children: [
                          Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ("Phone"),
                                    style: const TextStyle(
                                        fontSize: 10, color: Colors.grey),
                                  ),
                                  Text(
                                    (cnt.ItemDetail?.phone??""),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                          Center(
                            child:
                            Icon(
                              Icons.call, // Sort icon
                              color: Colors.grey, // Icon color
                              size: 25.0, // Icon size
                            ),
                          )

                        ],
                      ),
                      onTap: () => cnt.OpenDialer(cnt.ItemDetail?.phone??""),
                    ),
                    SizedBox(height: 12),
                    GestureDetector(
                      child: Row(
                        children: [
                          Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ("Email"),
                                    style: const TextStyle(
                                        fontSize: 10, color: Colors.grey),
                                  ),
                                  Text(
                                    (cnt.ItemDetail?.email??""),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                          Center(
                            child:
                            Icon(
                              Icons.email, // Sort icon
                              color: Colors.grey, // Icon color
                              size: 25, // Icon size
                            ),
                          )

                        ],
                      ),
                      onTap: () => cnt.OpenEmail(cnt.ItemDetail?.email??""),
                    ),
                    SizedBox(height: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          ("Address"),
                          style: const TextStyle(
                              fontSize: 10, color: Colors.grey),
                        ),
                        Text(
                          (cnt.ItemDetail?.address??""),
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          ("Office Type"),
                          style: const TextStyle(
                              fontSize: 10, color: Colors.grey),
                        ),
                        Text(
                          (cnt.ItemDetail?.officetype??""),
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ))
          ],
        ));
  }
}