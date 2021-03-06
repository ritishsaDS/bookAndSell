import 'dart:convert';

import 'package:book_buy_and_sell/Constants/Colors.dart';
import 'package:book_buy_and_sell/Constants/StringConstants.dart';
import 'package:book_buy_and_sell/UI/Activities/BookDetails.dart';
import 'package:book_buy_and_sell/UI/Activities/Categories.dart';
import 'package:book_buy_and_sell/UI/Activities/SubCategory.dart';
import 'package:book_buy_and_sell/Utils/ApiCall.dart';
import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:book_buy_and_sell/Utils/commonLV.dart';
import 'package:book_buy_and_sell/Utils/constantString.dart';
import 'package:book_buy_and_sell/common/common_snackbar.dart';
import 'package:book_buy_and_sell/common/preference_manager.dart';
import 'package:book_buy_and_sell/model/ClassModel/BookListModel.dart';
import 'package:book_buy_and_sell/model/ClassModel/SliderModel.dart';
import 'package:book_buy_and_sell/model/apiModel/responseModel/CategoriesResponseModel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'SelectedBook.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _searchField = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
resizeToAvoidBottomInset: false,

      body: SafeArea(
        child: SingleChildScrollView(
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
                        controller: _searchField,
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
                    InkWell(
                      onTap: () {
                        if (_searchField.text != "") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return SelectedBook(
                                    searchedWord: _searchField.text,catId: "",);
                              },
                            ),
                          );
                        } else {
                          CommonSnackBar.snackBar(
                              message: "Search Item cannot be empty");
                        }
                      },
                      child: Icon(
                        Icons.search,
                        color: Color(colorBlue),
                      ),
                    ),
                  ],
                ),
              ),
              _getSliders(),
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
                                  fontWeight: FontWeight.w600,
                                  color: Color(black)),
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
                            child: Icon(Icons.arrow_forward_ios_rounded,
                                color: Color(colorBlue),
                                size: SizeConfig.blockSizeVertical * 2.5))
                      ])),
              Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight * 0.15,
                  margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 0.05,
                      vertical: SizeConfig.blockSizeVertical),
                  child: CommonLV(dataCallingMethod: getCategories())),
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
                          "Book List",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Color(black)),
                        ),
                        Container(
                          width: 80,
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
              _getBookList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getSliders() {
    return FutureBuilder<List<SliderDataModel>>(
        future: _callSliderAPI(),
        builder: (context, AsyncSnapshot<List<SliderDataModel>> snapshot) {
          if (snapshot.hasData) {
            return CarouselSlider(
              options: CarouselOptions(height: 150,autoPlay: true),
              items: snapshot.data.map((slider) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: SizeConfig.screenWidth,
                      margin: EdgeInsets.symmetric(
                          horizontal: SizeConfig.screenWidth * 0.01,
                          vertical: SizeConfig.blockSizeVertical),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: ClipRRect(
                          child: Image.network(slider.image,fit: BoxFit.fill,),
                          borderRadius: BorderRadius.circular(15)),
                    );
                  },
                );
              }).toList(),
            );
          } else {
            return Container();
          }
        });
  }

  Future<Widget> getCategories() async {
    // CommonVM commonVM = Get.find();

    Map<String, dynamic> body = {
      "user_id": "${PreferenceManager.getUserId()}",
      "session_key": PreferenceManager.getSessionKey(),
      "parent_id": "0"
    };
    var res = await ApiCall.apiCall(categoryURL, body);
    var jsonDecoded = jsonDecode(res.body);
    if (jsonDecoded["status"] == "200") {
      List<CategoriesModel> categoriesModel =
          (jsonDecoded["category_data"] as List)
              .map((e) => CategoriesModel.fromJson(e))
              .toList();
      if (categoriesModel.length > 0) {
        return ListView.builder(
          itemBuilder: (context, int index) {
            return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return categoriesModel[index].subcategory == "Yes"
                        ? SubCategory(
                            id: categoriesModel[index].id,
                            text: categoriesModel[index].name,
                            img: categoriesModel[index].image)
                        : SelectedBook(searchedWord: "",catId: categoriesModel[index].id.toString());
                  }));
                },
                child: Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[200],
                                  spreadRadius: 1,
                                  blurRadius: 3)
                            ]),
                      //  padding: EdgeInsets.all(15),
                        // margin: EdgeInsets.only(
                        //     bottom: SizeConfig.blockSizeVertical),
                        child: ImageIcon(
                          NetworkImage(categoriesModel[index].image),
                          size: SizeConfig.blockSizeVertical * 5,
                          color: Color(colorBlue),
                        ),
                      ),

                      SizedBox(height: 10,),
                      Container(
                          width: SizeConfig.screenWidth * 0.25,
                          alignment: Alignment.center,
                          child: Text(
                            categoriesModel[index].name,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0XFF06070D),
                                fontSize:10),
                            textAlign: TextAlign.center,
                          ))
                    ])));
          },
          shrinkWrap: true,
          itemCount: categoriesModel.length,
          scrollDirection: Axis.horizontal,
        );
      } else {
        return Text("No Data found");
      }
    } else {
      return Text(jsonDecoded['message']);
    }
  }

  /*
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

  */

  Widget _getBookList() {
    return FutureBuilder<BookListModel>(
        future: ApiCall.callBookListAPI("",""),
        builder: (context, AsyncSnapshot<BookListModel> snapshot) {
          if (snapshot.hasData) {
            return Container(
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
                          return BookDetail(
                              snapshot.data.date[index].id.toString());
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
                                      "$rs ${snapshot.data.date[index].price}",
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
                                Container(
                                  height: 150,
width: SizeConfig.blockSizeVertical * 50,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        topLeft: Radius.circular(15)),
                                    child: Image.network(snapshot.data.image_url +
                                        "/" +
                                        snapshot.data.date[index].image1,fit: BoxFit.fill,),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 2),
                                  child: Text(
                                    snapshot.data.date[index].name,
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
                                        snapshot.data.date[index].auther_name,
                                        style: TextStyle(
                                            color: Color(0XFF656565),
                                            fontWeight: FontWeight.w600,
                                            fontSize:
                                                SizeConfig.blockSizeVertical *
                                                    1.25),
                                      ),
                                      Text(
                                        snapshot
                                            .data.date[index].edition_detail,
                                        maxLines: 2,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
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
                  itemCount: snapshot.data.date.length,
                  shrinkWrap: true,
                  primary: false,
                ));
          } else {
            return Container();
          }
        });
  }

  Future<List<SliderDataModel>> _callSliderAPI() async {
    Map<String, dynamic> body = {
      "user_id": "${PreferenceManager.getUserId()}",
      "session_key": PreferenceManager.getSessionKey(),
    };

    var res = await ApiCall.post(sliderURL, body);

    var jsonResponse = json.decode(json.encode(res).toString());

    var data = new SliderModel.fromJson(jsonResponse);
    return data.SliderData;
  }
}
