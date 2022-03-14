import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripmania/cubit/cubits.dart';
import 'package:tripmania/cubit/state.dart';
import 'package:tripmania/pages/bar.dart';
import 'package:tripmania/pages/profile.dart';
import 'package:tripmania/pages/search.dart';
import 'package:tripmania/widgets/app-text.dart';
import 'package:tripmania/widgets/applarge-text.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [
    const HomePage(),
    const BarPage(),
    const SearchPage(),
    const Profile(),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 0,
        unselectedFontSize: 0,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        onTap: (int index) => setState(() {
          currentIndex = index;
        }),
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.apps),
          ),
          BottomNavigationBarItem(
            label: "Bar",
            icon: Icon(Icons.bar_chart_sharp),
          ),
          BottomNavigationBarItem(
            label: "Search",
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  var imgs = {
    "balloning.png": "Balloning",
    "hiking.png": "Hiking",
    "kayaking.png": "Kayaking",
    "snorkling.png": "Snorkling",
  };

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);

    return Scaffold(
        body: BlocBuilder<AppCubits, CubitStates>(builder: (_, state) {
      if (state is LoadedState) {
        var info = state.places;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 70, left: 20),
              child: Row(
                children: [
                  Icon(Icons.menu, size: 30, color: Colors.black54),
                  Expanded(child: Container()),
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.withOpacity(0.5)),
                  )
                ],
              ),
            ),
            const SizedBox(height: 25),
            Container(
                margin: const EdgeInsets.only(left: 20),
                child: AppLargeText(text: "Discover")),
            const SizedBox(height: 20),
            //tab bar
            Container(
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  labelPadding: const EdgeInsets.only(left: 20, right: 20),
                  controller: _tabController,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicatorSize: TabBarIndicatorSize.label,
                  isScrollable: true,
                  indicator: CircleTabindicator(
                    color: const Color(0xFF5d69b3),
                    radius: 4,
                  ),
                  tabs: [
                    Tab(text: "Places"),
                    Tab(text: "Inspiration"),
                    Tab(text: "Emotions")
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 15),
              height: 300,
              width: double.maxFinite,
              child: TabBarView(controller: _tabController, children: [
                ListView.builder(
                  itemCount: info.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, int index) {
                    return GestureDetector(
                      onTap: () {
                        BlocProvider.of<AppCubits>(context)
                            .detailPage(info[index]);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 15, top: 10),
                        width: 200,
                        height: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            image: DecorationImage(
                              image: NetworkImage(
                                  "http://mark.bslemeiyu.com/uploads/" +
                                      info[index].img),
                              fit: BoxFit.cover,
                            )),
                      ),
                    );
                  },
                ),
                Text("hello"),
                Text("there")
              ]),
            ),
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppLargeText(text: "Explore more", size: 22),
                  AppText(text: "See all", color: Colors.grey.withOpacity(0.8))
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 100,
              width: double.maxFinite,
              margin: const EdgeInsets.only(left: 20),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (_, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 30),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "img/" + imgs.keys.elementAt(index)),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              child: AppText(
                                text: imgs.values.elementAt(index).toString(),
                                color: Colors.grey.withOpacity(0.5),
                              ),
                            ),
                          ]),
                    );
                  }),
            ),
          ],
        );
      } else {
        return Container();
      }
    }));
  }
}

class CircleTabindicator extends Decoration {
  final Color color;
  double radius;
  CircleTabindicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  double radius;
  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint _paint = Paint();
    _paint.color = color;
    _paint.isAntiAlias = true;
    final Offset circleOffset = Offset(
        configuration.size!.width / 2 - radius / 2,
        configuration.size!.height - radius);

    canvas.drawCircle(offset + circleOffset, radius, _paint);
  }
}
