import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit/cubit/app_cubit_states.dart';
import 'package:flutter_cubit/cubit/app_cubits.dart';
import 'package:flutter_cubit/misc/colors.dart';
import 'package:flutter_cubit/model/data_model.dart';
import 'package:flutter_cubit/widgets/app_large_text.dart';
import 'package:flutter_cubit/widgets/app_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  Map<String,String> images = {
    "balloning.png": "Balloning",
    "hiking.png": "Hiking",
    "kayaking.png": "Kayaking",
    "snorkling.png": "Snorkling"
  };

  @override
  Widget build(BuildContext context) {
  TabController _tabController = TabController(length: 3, vsync: this);

    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<AppCubits, CubitStates>(
          builder: (context, state){
            if(state is LoadedState) {
              List<DataModel> info = state.places;

              return ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // menu text
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.menu, size: 30, color: Colors.black,),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.5)
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),

                  // discover text
                  Padding(padding: const EdgeInsets.only(left: 20), child: AppLargeText(text: "Discover")),

                  //tab bar
                  TabBar(
                    controller: _tabController,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  indicator: const CircleTabIndicator(color: AppColors.mainColor, radius: 4),
                  dividerHeight: 0,
                    tabs: const [
                      Tab(text: "Places",),
                      Tab(text: "Inspiration",),
                      Tab(text: "Emotions",)
                    ],
                  ),

                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    height: 250,
                    width: double.maxFinite,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        ListView.builder(
                          itemCount: info.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: (){
                                BlocProvider.of<AppCubits>(context).detailPage(info[index]);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 15, top: 10),
                                width: 175,
                                height: 250,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      "http://mark.bslmeiyu.com/uploads/${info[index].img}",
                                    ),
                                    fit: BoxFit.cover
                                  ),
                                ),
                              ),
                            );
                          }
                        ),
                        Text("There"),
                        Text("By")
                      ],
                    ),
                  ),

                  const SizedBox(height: 20,),
                  
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppLargeText(text: "Explore more", size: 22,),
                        AppText(text: "See all")
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),

                  Container(
                    height: 120,
                    width: double.maxFinite,
                    padding:const EdgeInsets.only(left: 20),
                    child: ListView.builder(
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 30),
                          child: Column(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  image: DecorationImage(
                                    image: AssetImage(
                                      "img/${images.keys.elementAt(index)}"
                                    ),
                                    fit: BoxFit.cover
                                  )
                                ),
                              ),

                              const SizedBox(height: 5,),
                        
                              AppText(text: images.values.elementAt(index))
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            } else {
              return Container();
            }
          },
        )
      ),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  final double radius;

  const CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    // TODO: implement createBoxPainter
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
    final Offset circleOffSet = Offset(configuration.size!.width / 2 - radius / 2, configuration.size!.height - radius * 2);

    canvas.drawCircle(offset + circleOffSet, radius, _paint);
  }
}