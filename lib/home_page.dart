import 'package:flutter/material.dart';
import 'colors.dart' as CustomColor;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.AppColor.homePageBackground,
      body: Container(
        padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Training",
                  style: TextStyle(
                      fontSize: 30,
                      color: CustomColor.AppColor.homePageTitle,
                      fontWeight: FontWeight.w700),
                ),
                Expanded(child: Container()), // space between text and icons
                Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: CustomColor.AppColor.homePageIcons,
                ),
                const SizedBox(
                  width: 10,
                ), // for spacing between icons
                Icon(
                  Icons.calendar_today_outlined,
                  size: 20,
                  color: CustomColor.AppColor.homePageIcons,
                ),
                const SizedBox(
                  width: 15,
                ), // for spacing between icons
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 20,
                  color: CustomColor.AppColor.homePageIcons,
                ),
              ],
            ),
            // distance between first row and second row,
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Text(
                  "Your Program",
                  style: TextStyle(
                      fontSize: 20,
                      color: CustomColor.AppColor.homePageSubtitle,
                      fontWeight: FontWeight.w700),
                ),
                // spacing between texts
                Expanded(
                  child: Container(),
                ),
                Text(
                  "Details",
                  style: TextStyle(
                    fontSize: 20,
                    color: CustomColor.AppColor.homePageDetail,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.arrow_forward,
                  size: 20,
                  color: CustomColor.AppColor.homePageIcons,
                )
              ],
            ),
            // fancy box with play button
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width, // get width dynamically
              height: 200,
              // If You want to use border radius within container , You have to use constructor called Box decoration
              // If You have Box decoration inside container then color should be inside box decoration
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      CustomColor.AppColor.gradientFirst.withOpacity(0.8),
                      CustomColor.AppColor.gradientSecond.withOpacity(0.9),
                    ],
                    // from where gradient effect should work
                    begin: Alignment.bottomLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(80),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),

                  // shadow effect right and bottom
                  boxShadow: [
                    BoxShadow(
                        // offset means how much shadow spread left and right
                        offset: Offset(5, 10),
                        blurRadius: 20,
                        color: CustomColor.AppColor.gradientSecond
                            .withOpacity(0.2))
                  ]),

              // text inside container
              child: Container(
                padding: EdgeInsets.only(left: 20, top: 25, right: 20),
                child: Column(
                  // this is like flex start
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // in order to apply some padding , wrap the column in a container
                  children: [
                    Text(
                      "Next Workout",
                      style: TextStyle(
                          fontSize: 16,
                          color:
                              CustomColor.AppColor.homePageContainerTextSmall),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Legs Toning",
                      style: TextStyle(
                          fontSize: 25,
                          color:
                              CustomColor.AppColor.homePageContainerTextSmall),
                    ),
                    Text(
                      "And Glotes Workout",
                      style: TextStyle(
                          fontSize: 25,
                          color:
                              CustomColor.AppColor.homePageContainerTextSmall),
                    ),
                    SizedBox(
                      height: 11.0,
                    ),
                    // for footer , play button and timer icon
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // one row for timer and duration
                        // then empty container
                        //then a play button
                        Row(
                          children: [
                            Icon(
                              Icons.timer,
                              size: 20,
                              color: CustomColor
                                  .AppColor.homePageContainerTextSmall,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "60",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: CustomColor
                                      .AppColor.homePageContainerTextSmall),
                            )
                          ],
                        ),
                        Expanded(child: Container()),

                        // to apply shadow around play button , wrap inside a container
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              boxShadow: [
                                BoxShadow(
                                    color: CustomColor.AppColor.gradientFirst,
                                    blurRadius: 10,
                                    offset: Offset(4, 4))
                              ]),
                          child: Icon(
                            Icons.play_circle_fill,
                            color: Colors.white,
                            size: 60,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 5,
            )
            // Second Section
            ,
            Container(
              height: 180,
              width: MediaQuery.of(context).size.width,
              // stack I am using because there are 2 images overlapped , in order to achieve that I need that Stck widget
              child: Stack(
                children: [
                  // image will be placed just like background of this Container
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(top: 30),
                    height: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                            image: AssetImage("assets/card.jpg"),
                            fit: BoxFit.fill),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              offset: const Offset(5, 5),
                              color: CustomColor.AppColor.gradientSecond
                                  .withOpacity(.3)),
                          BoxShadow(
                              blurRadius: 10,
                              offset: const Offset(-1, -5),
                              color: CustomColor.AppColor.gradientSecond
                                  .withOpacity(.3))
                        ]),
                  ),

                  // Girl sitting above above container
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    // margin for position of girl
                    margin: const EdgeInsets.only(right: 200, bottom: 30),
                    decoration: BoxDecoration(
                      // uncomment color to test
                      //color: Colors.redAccent.withOpacity(.2),
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: AssetImage("assets/figure1.png"),
                        //fit: BoxFit.fill
                      ),
                    ),
                  ),

                  // text beside girl
                  Container(
                    // with max finite , it takes available width
                    width: double.maxFinite,
                    height: 100,
                    //color: Colors.amber.withOpacity(0.3),
                    margin: EdgeInsets.only(left: 150, top: 50),

                    // now place the text
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "You are doing great",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: CustomColor.AppColor.homePageDetail),
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        // RichText widget has a benefit of apply style for all its children
                        RichText(
                            text: TextSpan(
                                text: "Keep it up \n",
                                style: TextStyle(
                                    color:
                                        CustomColor.AppColor.homePagePlanColor,
                                    fontSize: 16),
                                children: [
                              TextSpan(text: "Stick to your plan")
                            ]))
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
