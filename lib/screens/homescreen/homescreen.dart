import 'package:anihunt/Color/ColorConst.dart';
import 'package:anihunt/models/anime.dart';
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
  int carouselIndex = 0;
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
    return Scaffold(
      backgroundColor: primary,
      body: SingleChildScrollView(
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
      ),
    );
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
