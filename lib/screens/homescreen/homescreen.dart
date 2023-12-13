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

  final CarouselController _carouselController = CarouselController();
  static final List<Widget> _bannerWidgets =
      Anime.animeList.map((anime) => _BannerNewRelease(anime: anime)).toList();

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
      ),
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
