import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'colors.dart' as CustomColor;

class VideoInfo extends StatefulWidget {
  const VideoInfo({super.key});

  @override
  State<VideoInfo> createState() => _VideoInfoState();
}

class _VideoInfoState extends State<VideoInfo> {
  List<dynamic> videos = []; // Specify the type of the list

  // Load JSON data asynchronously
  Future<void> _initData() async {
    try {
      String data = await DefaultAssetBundle.of(context)
          .loadString('json/videoinfo.json');
      setState(() {
        videos = json.decode(data);
      });
      print(videos
          .length); // Move print statement here to ensure it runs after data is loaded
    } catch (error) {
      print('Error loading JSON data: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    _initData(); // Load data when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          CustomColor.AppColor.gradientFirst.withOpacity(0.8),
          CustomColor.AppColor.gradientSecond
        ], begin: const FractionalOffset(0.0, 0.4))),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icons shows at top
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                          color: CustomColor.AppColor.secondPageIconColor,
                        ),
                      ),
                      Expanded(child: Container()),
                      Icon(
                        Icons.info_outline,
                        size: 20,
                        color: CustomColor.AppColor.secondPageIconColor,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Next Workout",
                    style: TextStyle(
                        fontSize: 16,
                        color: CustomColor.AppColor.secondPageTitleColor),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Legs Toning",
                    style: TextStyle(
                        fontSize: 25,
                        color: CustomColor.AppColor.secondPageTitleColor),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 90,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(colors: [
                              CustomColor
                                  .AppColor.secondPageContainerGradient1stColor,
                              CustomColor
                                  .AppColor.secondPageContainerGradient2ndColor
                            ])),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.timer,
                                size: 20,
                                color: CustomColor.AppColor.secondPageIconColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "68 min",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: CustomColor
                                        .AppColor.secondPageIconColor),
                              )
                            ]),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 200,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(colors: [
                              CustomColor
                                  .AppColor.secondPageContainerGradient1stColor,
                              CustomColor
                                  .AppColor.secondPageContainerGradient2ndColor
                            ])),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.handyman_rounded,
                                size: 20,
                                color: CustomColor.AppColor.secondPageIconColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Resistent Band,Kettle",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: CustomColor
                                        .AppColor.secondPageIconColor),
                              )
                            ]),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  )
                ],
              ),
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(70))),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        "Circuit 1: Legs Toning",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: CustomColor.AppColor.circuitsColor),
                      ),
                      Expanded(child: Container()),
                      Row(
                        children: [
                          Icon(
                            Icons.loop_outlined,
                            size: 30,
                            color: CustomColor.AppColor.loopColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "3 sets",
                            style: TextStyle(
                                fontSize: 15,
                                color: CustomColor.AppColor.setsColor),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: ListView.builder(
                          padding:
                              EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                          itemCount: videos.length,
                          itemBuilder: (_, int videoIndex) {
                            // because of clickable
                            return GestureDetector(
                              onTap: () {
                                debugPrint(videoIndex.toString());
                              },
                              child: Container(
                                height: 135,
                                //color: Colors.redAccent,
                                // each video section
                                child: Column(
                                  children: [
                                    // First row whcih contain thumbnail and details text
                                    Row(
                                      children: [
                                        // image as thumnail
                                        Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      videos[videoIndex]
                                                          ['thumbnail']))),
                                        ),

                                        SizedBox(
                                          width: 10,
                                        ),

                                        // details text
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              videos[videoIndex]['title'],
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 3),
                                              child: Text(
                                                videos[videoIndex]["time"],
                                                style: TextStyle(
                                                    color: Colors.grey[500]),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 18,
                                    ),
                                    // second row for dashed outline
                                    Row(
                                      children: [
                                        // first for pills type line
                                        Container(
                                          width: 80,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              color: Color(0xFFeaeefc),
                                              borderRadius:
                                                  BorderRadius.circular(10)),

                                          // text of that pill shows in center
                                          child: Center(
                                            child: Text(
                                              "15sec rest",
                                              style: TextStyle(
                                                  color: Color(0xFF839FED)),
                                            ),
                                          ),
                                        ),

                                        // dotted line
                                        Row(
                                          children: [
                                            // create a container which will be create that dotted type line

                                            for (int i = 0; i < 70; i++)
                                              i.isEven
                                                  ? Container(
                                                      width: 3,
                                                      height: 1,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xFF839FED),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(2)),
                                                    )
                                                  : Container(
                                                      width: 3,
                                                      height: 1,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(2)),
                                                    )
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }))
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
