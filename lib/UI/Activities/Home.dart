import 'package:book_buy_and_sell/Constants/Colors.dart';
import 'package:book_buy_and_sell/UI/Activities/BookDetails.dart';
import 'package:book_buy_and_sell/UI/Activities/Categories.dart';
import 'package:book_buy_and_sell/UI/Activities/SubCategory.dart';
import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:book_buy_and_sell/common/preference_manager.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> assetImages = [
    'assets/icons/eng.png',
    'assets/icons/med.png',
    'assets/icons/music.png',
    'assets/icons/mgt.png',
    'assets/icons/notes.png',
    'assets/icons/exam.png',
    'assets/bg/logo.png',
    'assets/icons/notes.png',
    'assets/icons/notes.png',
    'assets/icons/notes.png',
    'assets/icons/mgt.png'
  ];

  List<String> text = [
    'Engineering',
    'Medical',
    'Music',
    'Management',
    'Notes',
    'Competitive Exams',
    'Arts',
    'Accessories',
    'Novels',
    'Comics',
    'Entrance Exams'
  ];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(backgroundColor),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.02,
                  vertical: SizeConfig.blockSizeVertical * 2),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      var usrId = PreferenceManager.getUserId();
                      print(usrId);
                    },
                    child: ImageIcon(
                      AssetImage('assets/icons/drawer.png'),
                      color: Color(colorBlue),
                      size: SizeConfig.blockSizeVertical * 4,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 5,
                        right: SizeConfig.screenWidth * 0.35),
                    child: Row(
                      children: [
                        Text(
                          "Current Location",
                          style: TextStyle(color: Color(black)),
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 2,
                        ),
                        ImageIcon(
                          AssetImage('assets/icons/current.png'),
                          color: Color(colorBlue),
                          size: SizeConfig.blockSizeVertical * 3,
                        )
                      ],
                    ),
                  ),
                  ImageIcon(
                    AssetImage('assets/icons/notification.png'),
                    color: Color(colorBlue),
                    size: SizeConfig.blockSizeVertical * 4,
                  )
                ],
              ),
            ),
            Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.05,
                  vertical: SizeConfig.blockSizeVertical),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Color(colorBlue))),
              child: Row(
                children: [
                  Container(
                    width: SizeConfig.screenWidth * 0.8,
                    child: TextFormField(
                      textInputAction: TextInputAction.search,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: SizeConfig.blockSizeVertical * 1.5,
                              horizontal: SizeConfig.blockSizeHorizontal * 5),
                          hintText: "Search an item",
                          hintStyle: TextStyle(
                            color: Color(hintGrey),
                            fontWeight: FontWeight.w500,
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                  Icon(
                    Icons.search,
                    color: Color(colorBlue),
                  ),
                ],
              ),
            ),
            Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.05,
                  vertical: SizeConfig.blockSizeVertical),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: ClipRRect(
                  child: Image.asset('assets/bg/home bg.png'),
                  borderRadius: BorderRadius.circular(15)),
            ),
            Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.05,
                  vertical: SizeConfig.blockSizeVertical),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Categories",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Color(black)),
                      ),
                      Container(
                        width: SizeConfig.screenWidth * 0.2,
                        height: SizeConfig.blockSizeVertical * 0.2,
                        decoration: BoxDecoration(color: Color(colorBlue)),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Categories();
                      }));
                    },
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Color(colorBlue),
                      size: SizeConfig.blockSizeVertical * 2.5,
                    ),
                  ),
                ],
              ),
            ),
            Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight * 0.15,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.05,
                    vertical: SizeConfig.blockSizeVertical),
                child: ListView.builder(
                  itemBuilder: (context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SubCategory(
                            text: text[index],
                            img: assetImages[index],
                          );
                        }));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: SizeConfig.blockSizeHorizontal * 2,
                            vertical: SizeConfig.blockSizeVertical),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[200],
                                        spreadRadius: 1,
                                        blurRadius: 3)
                                  ]),
                              padding: EdgeInsets.all(8),
                              margin: EdgeInsets.only(
                                  bottom: SizeConfig.blockSizeVertical),
                              child: ImageIcon(
                                AssetImage(
                                  assetImages[index],
                                ),
                                size: SizeConfig.blockSizeVertical * 5,
                                color: Color(colorBlue),
                              ),
                            ),
                            Container(
                              width: SizeConfig.screenWidth * 0.2,
                              alignment: Alignment.center,
                              child: Text(
                                text[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(0XFF06070D),
                                  fontSize: SizeConfig.blockSizeVertical * 1.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  shrinkWrap: true,
                  itemCount: assetImages.length,
                  scrollDirection: Axis.horizontal,
                )),
            Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.05,
                  vertical: SizeConfig.blockSizeVertical),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nearby Products",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Color(black)),
                      ),
                      Container(
                        width: SizeConfig.screenWidth * 0.3,
                        height: SizeConfig.blockSizeVertical * 0.2,
                        decoration: BoxDecoration(color: Color(colorBlue)),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Color(colorBlue),
                    size: SizeConfig.blockSizeVertical * 2.5,
                  ),
                ],
              ),
            ),
            Container(
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.05,
                    vertical: SizeConfig.blockSizeVertical),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 3 / 4,
                      crossAxisCount: 2,
                      crossAxisSpacing: SizeConfig.blockSizeHorizontal * 3,
                      mainAxisSpacing: SizeConfig.blockSizeVertical * 2),
                  itemBuilder: (context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return BookDetail();
                        }));
                      },
                      child: Stack(
                        children: [
                          Card(
                            child: Align(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left:
                                            SizeConfig.blockSizeHorizontal * 4,
                                        bottom: SizeConfig.blockSizeVertical),
                                    child: Text(
                                      "₹ 200",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        right:
                                            SizeConfig.blockSizeHorizontal * 4,
                                        bottom: SizeConfig.blockSizeVertical),
                                    child: Text(
                                      "Buy Now",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                              alignment: Alignment.bottomCenter,
                            ),
                            color: Color(colorBlue),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            elevation: 5.0,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    topLeft: Radius.circular(15)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[200],
                                      blurRadius: 5.0,
                                      spreadRadius: 2.0),
                                ]),
                            margin: EdgeInsets.only(
                                bottom: SizeConfig.blockSizeVertical * 5,
                                right: SizeConfig.blockSizeHorizontal,
                                left: SizeConfig.blockSizeHorizontal),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      topLeft: Radius.circular(15)),
                                  child: Image.asset(
                                    'assets/icons/book1.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 2),
                                  child: Text(
                                    "Physics",
                                    style: TextStyle(
                                        color: Color(0XFF06070D),
                                        fontWeight: FontWeight.w600,
                                        fontSize:
                                            SizeConfig.blockSizeVertical * 1.5),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 2,
                                      right:
                                          SizeConfig.blockSizeHorizontal * 2),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Author Name",
                                        style: TextStyle(
                                            color: Color(0XFF656565),
                                            fontWeight: FontWeight.w600,
                                            fontSize:
                                                SizeConfig.blockSizeVertical *
                                                    1.25),
                                      ),
                                      Text(
                                        "Edition Details",
                                        style: TextStyle(
                                            color: Color(0XFF656565),
                                            fontWeight: FontWeight.w600,
                                            fontSize:
                                                SizeConfig.blockSizeVertical *
                                                    1.25),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: 5,
                  shrinkWrap: true,
                  primary: false,
                )),
          ],
        ),
      ),
    ));
  }
}
