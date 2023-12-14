import 'package:anihunt/Color/ColorConst.dart';
import 'package:anihunt/models/anime.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
  static final List<Widget> _newReleaseBannerWidgets = Anime.animeList
      .map((anime) => _BannerNewRelease(
            anime: anime,
          ))
      .toList();
  static final List<Widget> _thisSeasonBannerWidgets = Anime.animeList
      .map((anime) => _ThisSeasonBanner(
            anime: anime,
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        title: const Text('homepage'),
        centerTitle: true,
      ),
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

class _ThisSeasonBanner extends StatefulWidget {
  final Anime anime;
  final Function()? onPressedLiked;
  final Function()? onPressedBookmarked;
  const _ThisSeasonBanner({
    required this.anime,
    this.onPressedLiked,
    this.onPressedBookmarked,
  });

  @override
  State<_ThisSeasonBanner> createState() => _ThisSeasonBannerState();
}

class _ThisSeasonBannerState extends State<_ThisSeasonBanner> {
  bool tapLike = false;
  bool tapBookmark = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.7,
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(40)),
          image: DecorationImage(
            image: AssetImage(widget.anime.imageUrl),
            fit: BoxFit.cover,
            colorFilter: const ColorFilter.mode(
              Color.fromRGBO(0, 0, 0, 0.2),
              BlendMode.darken,
            ),
          )),
      child: Stack(children: [
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            onTap: () {},
            child: Container(
              height: MediaQuery.of(context).size.shortestSide * 0.13,
              width: MediaQuery.of(context).size.shortestSide * 0.13,
              decoration: BoxDecoration(
                  color: primary,
                  borderRadius:
                      const BorderRadius.only(topLeft: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.only(left: 5, top: 5),
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(255, 114, 114, 1),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Icon(
                    Icons.window,
                    color: primary,
                    size: MediaQuery.of(context).size.shortestSide * 0.07,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 50, left: 15, bottom: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.anime.title,
                style: TextStyle(
                  color: textLight,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Flexible(
                    child: FilledButton(
                        style: FilledButton.styleFrom(
                            // fixedSize: Size.square(
                            //     MediaQuery.of(context).size.shortestSide * 0.01),
                            backgroundColor:
                                const Color.fromRGBO(173, 170, 170, 0.75),
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ))),
                        onPressed: () {
                          setState(() {
                            tapLike = !tapLike;
                            widget.onPressedLiked;
                          });
                        },
                        child: Icon(
                          tapLike ? Icons.thumb_up : Icons.thumb_up_outlined,
                        )),
                  ),
                  const SizedBox(width: 2),
                  Flexible(
                    child: FilledButton(
                        style: FilledButton.styleFrom(
                            // fixedSize: Size.square(
                            //     MediaQuery.of(context).size.shortestSide * 0.01),
                            backgroundColor:
                                const Color.fromRGBO(173, 170, 170, 0.75),
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ))),
                        onPressed: () {
                          setState(() {
                            tapBookmark = !tapBookmark;
                            widget.onPressedBookmarked;
                          });
                        },
                        child: Icon(
                          tapBookmark ? Icons.bookmark : Icons.bookmark_outline,
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ]),
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
                style: TextStyle(
                  color: textLight,
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
