import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripmania/cubit/cubits.dart';
import 'package:tripmania/cubit/state.dart';
import 'package:tripmania/widgets/app-button.dart';
import 'package:tripmania/widgets/app-text.dart';
import 'package:tripmania/widgets/applarge-text.dart';
import 'package:tripmania/widgets/button.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int gottenStars = 4;
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubits, CubitStates>(builder: (_, state) {
      DetailState detail = state as DetailState;

      return Scaffold(
        // ignore: sized_box_for_whitespace
        body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                child: Container(
                  width: double.maxFinite,
                  height: 350,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "http://mark.bslemiyu.com/uploads/" +
                                detail.place.img),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top: 70,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<AppCubits>(context).goHome();
                      },
                      icon: const Icon(Icons.menu),
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 320,
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 500,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppLargeText(
                            text: detail.place.name,
                            color: Colors.black.withOpacity(0.8),
                          ),
                          AppLargeText(
                            text: "\$" + detail.place.price.toString(),
                            color: Colors.blueAccent,
                          )
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          // ignore: prefer_const_constructors
                          Icon(
                            Icons.location_on,
                            color: Colors.black54,
                          ),
                          const SizedBox(width: 5),
                          AppText(
                              text: detail.place.location,
                              color: Colors.grey.withOpacity(0.6)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Wrap(children: [
                            ...List.generate(
                                5,
                                (index) => Icon(
                                      Icons.star,
                                      color: index < detail.place.stars
                                          ? Colors.orangeAccent
                                          : Colors.grey,
                                    )),
                          ]),
                          const SizedBox(width: 5),
                          AppText(
                            text: "(5.0)",
                            color: Colors.grey,
                          )
                        ],
                      ),
                      const SizedBox(height: 30),
                      AppText(
                        text: "People",
                        color: Colors.black.withOpacity(0.9),
                        size: 25,
                      ),
                      const SizedBox(height: 5),
                      AppText(
                        text: "Number of people in your group",
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        children: [
                          ...List.generate(
                              5,
                              (index) => InkWell(
                                    onTap: () => setState(() {
                                      selectedIndex = index;
                                    }),
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      child: AppButton(
                                        color: selectedIndex == index
                                            ? Colors.white
                                            : Colors.black,
                                        backgroundColor: selectedIndex == index
                                            ? Colors.black
                                            : Colors.grey.withOpacity(0.2),
                                        size: 50,
                                        borderColor: selectedIndex == index
                                            ? Colors.black
                                            : Colors.grey.withOpacity(0.2),
                                        text: (index + 1).toString(),
                                      ),
                                    ),
                                  )),
                        ],
                      ),
                      const SizedBox(height: 15),
                      AppLargeText(
                          text: "Description",
                          color: Colors.black.withOpacity(0.8),
                          size: 20),
                      const SizedBox(height: 5),
                      AppText(
                        text: detail.place.description,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Row(
                    children: [
                      AppButton(
                          color: Colors.grey,
                          backgroundColor: Colors.white,
                          size: 60,
                          borderColor: Colors.grey,
                          isIcon: true,
                          icon: Icons.favorite_border),
                      const SizedBox(width: 20),
                      Button(
                        isResponsive: true,
                      ),
                    ],
                  )),
            ],
          ),
        ),
      );
    });
  }
}
