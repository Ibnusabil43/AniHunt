import 'package:anihunt/Color/ColorConst.dart';
import 'package:anihunt/models/anime.dart';
import 'package:anihunt/screens/homescreen/bookmarked.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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

  final CarouselController _carouselController = CarouselController();
  static final List<Widget> _bannerWidgets =
      Anime.animeList.map((anime) => _BannerNewRelease(anime: anime)).toList();

  @override
  Widget build(BuildContext context) {
    String greeting = getGreeting();
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
                  style: TextStyle(
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
            SizedBox(
              height: 24,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Text(
                    "Good $greeting!",
                    style: TextStyle(
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
              SizedBox(
                height: 24,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildAppBarButton("Home", 0),
                    SizedBox(width: 12),
                    _buildAppBarButton("Bookmarked", 1),
                    SizedBox(width: 12),
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
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 11),
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
                  bannerWidgets: _bannerWidgets,
                  carouselController: _carouselController,
                  initialIndex: carouselIndex,
                  onPageChanged: (index, reason) {
                    setState(() {
                      carouselIndex = index;
                    });
                  }),
            ],
          ),
        );
      case 1:
        return SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [BookmarkedWidget()],
          ),
        );
      case 2:
        return Center(child: Text('History Content'));
      default:
        return Center(child: Text('Unknown Content'));
    }
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
                color: accent, fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
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

class _BannerNewRelease extends StatelessWidget {
  final Anime anime;
  const _BannerNewRelease({
    required this.anime,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(40)),
            image: DecorationImage(
              image: AssetImage(anime.imageUrl),
              fit: BoxFit.cover,
              colorFilter: const ColorFilter.mode(
                Color.fromRGBO(0, 0, 0, 0.6),
                BlendMode.darken,
              ),
            )),
        child: Padding(
          padding: const EdgeInsets.only(right: 50, left: 50, bottom: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                anime.title,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                anime.description,
                // overflow: TextOverflow.fade,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: textSecondary,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
