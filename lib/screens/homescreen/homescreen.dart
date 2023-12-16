import 'package:anihunt/Color/colorconst.dart';
import 'package:anihunt/models/anime.dart';
import 'package:anihunt/screens/homescreen/bookmarked.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:anihunt/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String getGreeting() {
    var hour = DateTime.now().hour;

    if (hour >= 0 && hour < 5) {
      return 'Night';
    } else if (hour >= 5 && hour < 12) {
      return 'Morning';
    } else if (hour >= 12 && hour < 17) {
      return 'Afternoon';
    } else {
      return 'Evening';
    }
  }

  int carouselIndex = 0;
  int _selectedIndex = 0;

  int thisSeasonIndex = 0;
  final CarouselController _carouselController = CarouselController();
  final CarouselController _thisSeasonController = CarouselController();

  // METHOD FOR SET LIST OF ANIME INTO LIST OF WIDGETS USED FOR BANNER
  static final List<Widget> _newReleaseBannerWidgets = Anime.animeList
      .map((anime) => AnimeBanner(
            anime: anime,
          ))
      .toList();

  // METHOD FOR SET LIST OF ANIME INTO LIST OF WIDGETS USED FOR CARD
  static final List<Widget> _thisSeasonBannerWidgets = Anime.animeList
      .map((anime) => AnimeCard(
            anime: anime,
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    String greeting = getGreeting();
    return Scaffold(
        backgroundColor: primary,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          toolbarHeight: 153,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Good $greeting!",
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  ClipOval(
                    child: Image.asset(
                      "assets/ProfilePictureTest.jpg",
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildAppBarButton("Home", 0),
                    const SizedBox(width: 12),
                    _buildAppBarButton("Bookmarked", 1),
                    const SizedBox(width: 12),
                    _buildAppBarButton("History", 2),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: _buildBodyContent(_selectedIndex)
        //     SingleChildScrollView(
        //   child: Column(
        //     children: [
        //       _NewRelease(
        //           bannerWidgets: _bannerWidgets,
        //           carouselController: _carouselController,
        //           initialIndex: carouselIndex,
        //           onPageChanged: (index, reason) {
        //             setState(() {
        //               carouselIndex = index;
        //             });
        //           }),
        //     ],
        //   ),
        // ),
        );
  }

  Widget _buildAppBarButton(String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
        decoration: BoxDecoration(
          color: _selectedIndex == index
              ? const Color.fromARGB(255, 0, 0, 0)
              : const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF565656),
            width: 1,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: _selectedIndex == index
                ? const Color.fromARGB(255, 255, 255, 255)
                : const Color(0xFF565656),
          ),
        ),
      ),
    );
  }

  Widget _buildBodyContent(int index) {
    switch (index) {
      case 0:
        return SingleChildScrollView(
          child: Column(
            children: [
              _NewRelease(
                  bannerWidgets: _newReleaseBannerWidgets,
                  carouselController: _carouselController,
                  initialIndex: carouselIndex,
                  onPageChanged: (index, reason) {
                    setState(() {
                      carouselIndex = index;
                    });
                  }),
              const SizedBox(height: 40),
              _ThisSeason(
                  bannerWidgets: _thisSeasonBannerWidgets,
                  controller: _thisSeasonController,
                  initialIndex: thisSeasonIndex,
                  onPageChanged: (index, reason) {
                    setState(() {
                      thisSeasonIndex = index;
                    });
                  })
            ],
          ),
        );
      case 1:
        return const SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [BookmarkedWidget()],
          ),
        );
      case 2:
        return const Center(child: Text('History Content'));
      default:
        return const Center(child: Text('Unknown Content'));
    }
  }
}

class _ThisSeason extends StatefulWidget {
  final int initialIndex;
  final CarouselController controller;
  final List<Widget> bannerWidgets;
  final Function(int index, CarouselPageChangedReason reason) onPageChanged;
  const _ThisSeason(
      {required this.bannerWidgets,
      required this.controller,
      required this.initialIndex,
      required this.onPageChanged});

  @override
  State<_ThisSeason> createState() => _ThisSeasonState();
}

class _ThisSeasonState extends State<_ThisSeason> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 40, bottom: 10),
          child: Text(
            'This Season',
            style: TextStyle(
                color: textDark, fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.6,
          child: Stack(
            children: [
              CarouselSlider(
                  items: widget.bannerWidgets,
                  carouselController: widget.controller,
                  options: CarouselOptions(
                    enableInfiniteScroll: true,
                    // disableCenter: true,
                    padEnds: false,
                    height: double.infinity,
                    enlargeCenterPage: false,
                    viewportFraction: 0.8,
                    onPageChanged: widget.onPageChanged,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}

class _NewRelease extends StatefulWidget {
  final int initialIndex;
  final CarouselController carouselController;
  final List<Widget> bannerWidgets;
  final Function(int index, CarouselPageChangedReason reason) onPageChanged;
  const _NewRelease(
      {required this.bannerWidgets,
      required this.carouselController,
      required this.initialIndex,
      required this.onPageChanged});

  @override
  State<_NewRelease> createState() => _NewReleaseState();
}

class _NewReleaseState extends State<_NewRelease> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 40, bottom: 10),
          child: Text(
            'New Release',
            style: TextStyle(
                color: textDark, fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.shortestSide * 0.6,
          child: Stack(
            children: [
              CarouselSlider(
                  items: widget.bannerWidgets,
                  carouselController: widget.carouselController,
                  options: CarouselOptions(
                    height: double.infinity,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayInterval: const Duration(milliseconds: 2500),
                    viewportFraction: 1,
                    onPageChanged: widget.onPageChanged,
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.navigate_before_rounded),
                        iconSize:
                            MediaQuery.of(context).size.shortestSide * 0.12,
                        onPressed: () =>
                            widget.carouselController.previousPage(),
                        color: const Color.fromRGBO(167, 173, 177, 1),
                      ),
                      IconButton(
                        icon: const Icon(Icons.navigate_next_rounded),
                        iconSize:
                            MediaQuery.of(context).size.shortestSide * 0.12,
                        onPressed: () => widget.carouselController.nextPage(),
                        color: const Color.fromRGBO(167, 173, 177, 1),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: AnimatedSmoothIndicator(
                    activeIndex: widget.initialIndex,
                    count: widget.bannerWidgets.length,
                    effect: const WormEffect(
                      dotColor: Color.fromRGBO(217, 217, 217, 0.5),
                      activeDotColor: Color.fromRGBO(217, 217, 217, 1),
                      dotWidth: 30,
                      dotHeight: 5,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
