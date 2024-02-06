import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'colors.dart' as CustomColor;

//1:48

class VideoInfo extends StatefulWidget {
  const VideoInfo({super.key});

  @override
  State<VideoInfo> createState() => _VideoInfoState();
}

class _VideoInfoState extends State<VideoInfo> {
  List<dynamic> videos = []; // Specify the type of the list
  bool _playAreaShown = false;
  bool _isPlaying = false;
  bool _disposed = false;
  int _isPlayingIndex = -1;

  VideoPlayerController? _controller;
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
  void dispose() {
    _disposed = true;
    _controller?.pause();
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: _playAreaShown == false
            ? BoxDecoration(
                gradient: LinearGradient(colors: [
                CustomColor.AppColor.gradientFirst.withOpacity(0.8),
                CustomColor.AppColor.gradientSecond
              ], begin: const FractionalOffset(0.0, 0.4)))
            : BoxDecoration(color: CustomColor.AppColor.gradientSecond),
        child: Column(
          children: [
            // container for play area and header
            _playAreaShown == false
                ? Container(
                    padding:
                        const EdgeInsets.only(top: 70, left: 30, right: 30),
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
                                    CustomColor.AppColor
                                        .secondPageContainerGradient1stColor,
                                    CustomColor.AppColor
                                        .secondPageContainerGradient2ndColor
                                  ])),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.timer,
                                      size: 20,
                                      color: CustomColor
                                          .AppColor.secondPageIconColor,
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
                                    CustomColor.AppColor
                                        .secondPageContainerGradient1stColor,
                                    CustomColor.AppColor
                                        .secondPageContainerGradient2ndColor
                                  ])),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.handyman_rounded,
                                      size: 20,
                                      color: CustomColor
                                          .AppColor.secondPageIconColor,
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
                  )
                :

                //video player and controls
                Container(
                    child: Column(children: [
                      // back button and info button section
                      Container(
                        height: 100,
                        padding:
                            const EdgeInsets.only(top: 50, left: 30, right: 30),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                debugPrint("You clicked on back");
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
                              color:
                                  CustomColor.AppColor.secondPageTopIconColor,
                            )
                          ],
                        ),
                      ),

                      // area for playing the video
                      _playVideo(context),
                      _controllerView(context),
                    ]),
                  ),
            // container for video lists
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
                  Expanded(child: _listView())
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

//===========================================================================
// custom function for code readability
//===========================================================================

  Widget _controllerView(BuildContext context) {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width,
      color: CustomColor.AppColor.gradientSecond,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // rewind button
          TextButton(
            onPressed: () async {
              final index = _isPlayingIndex - 1;
              if (index >= 0 && videos.length >= 0) {
                _initializeVideo(index);
              } else {
                Get.snackbar(
                  "Video",
                  "",
                  snackPosition: SnackPosition.BOTTOM,
                  icon: Icon(
                    Icons.face,
                    size: 30,
                    color: Colors.white,
                  ),
                  backgroundColor: CustomColor.AppColor.gradientSecond,
                  colorText: Colors.white,
                  messageText: Text(
                    "No videos ahed!",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                );
              }
            },
            child: Icon(
              Icons.fast_rewind,
              size: 36,
              color: Colors.white,
            ),
          ),
          // Play / pause
          TextButton(
            onPressed: () async {
              if (_isPlaying) {
                setState(() {
                  _isPlaying = false;
                });
                _controller?.pause();
              } else {
                setState(() {
                  _isPlaying = true;
                });
                _controller?.play();
              }
            },
            child: Icon(
              _isPlaying ? Icons.pause_circle : Icons.play_arrow,
              size: 36,
              color: Colors.white,
            ),
          ),

          // fast forward
          TextButton(
            onPressed: () async {
              final index = _isPlayingIndex + 1;
              if (index <= videos.length - 1) {
                _initializeVideo(index);
              } else {
                Get.snackbar(
                  "Video",
                  "",
                  snackPosition: SnackPosition.BOTTOM,
                  icon: Icon(
                    Icons.face,
                    size: 30,
                    color: Colors.white,
                  ),
                  backgroundColor: CustomColor.AppColor.gradientSecond,
                  colorText: Colors.white,
                  messageText: Text(
                    "Currently You are watching the last video from the playlist",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                );
              }
            },
            child: Icon(
              Icons.fast_forward,
              size: 36,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  _listView() {
    return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        itemCount: videos.length,
        itemBuilder: (_, int videoIndex) {
          // because of clickable
          return GestureDetector(
              onTap: () {
                _onTapVideo(videoIndex);
                setState(() {
                  if (!_playAreaShown) {
                    _playAreaShown = true;
                  }
                });
              },
              child: _buildCards(videoIndex));
        });
  }

  _buildCards(int videoIndex) {
    return Container(
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
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage(videos[videoIndex]['thumbnail']))),
              ),

              SizedBox(
                width: 10,
              ),

              // details text
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    videos[videoIndex]['title'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Text(
                      videos[videoIndex]["time"],
                      style: TextStyle(color: Colors.grey[500]),
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
                    borderRadius: BorderRadius.circular(10)),

                // text of that pill shows in center
                child: Center(
                  child: Text(
                    "15sec rest",
                    style: TextStyle(color: Color(0xFF839FED)),
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
                                color: Color(0xFF839FED),
                                borderRadius: BorderRadius.circular(2)),
                          )
                        : Container(
                            width: 3,
                            height: 1,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2)),
                          )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _playVideo(BuildContext context) {
    final controller = _controller;
    if (controller != null && controller.value.isInitialized) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: VideoPlayer(controller),
      );
    } else {
      return AspectRatio(
          aspectRatio: 16 / 9, child: Center(child: Text("Preparing..")));
    }
  }

  _onTapVideo(int videoIndex) {
    _initializeVideo(videoIndex);
  }

  var _onUpdateControllerTime;
  void _onControllerUpdate() async {
    if (_disposed) {
      return;
    }
    _onUpdateControllerTime = 0;
    final now = DateTime.now().millisecondsSinceEpoch;
    if (_onUpdateControllerTime > now) {
      return;
    }
    _onUpdateControllerTime = now + 500;
    final controller = _controller;
    if (controller == null) {
      debugPrint("controller is null");
      return;
    }
    if (!controller.value.isInitialized) {
      debugPrint("controller is not initialized");
      return;
    }
    final playing = controller.value.isPlaying;
    _isPlaying = playing;
  }

  _initializeVideo(int videoIndex) {
    final controller =
        VideoPlayerController.network(videos[videoIndex]["videoUrl"]);
    final old = _controller;
    _controller = controller;
    if (old != null) {
      old.removeListener(_onControllerUpdate);
      old.pause();
    }
    setState(() {});
    controller
      ..initialize().then((_) {
        old?.dispose();
        _isPlayingIndex = videoIndex;
        // add a listener
        controller.addListener(_onControllerUpdate);
        controller.play();
        setState(() {});
      });
  }
}
