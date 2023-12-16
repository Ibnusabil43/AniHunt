import 'package:anihunt/Color/ColorConst.dart';
import 'package:anihunt/models/anime.dart';
import 'package:flutter/material.dart';

class AnimeCard extends StatefulWidget {
  final Anime anime;
  final Function()? onPressedLiked;
  final Function()? onPressedBookmarked;
  const AnimeCard({
    super.key,
    required this.anime,
    this.onPressedLiked,
    this.onPressedBookmarked,
  });

  @override
  State<AnimeCard> createState() => _ThisSeasonBannerState();
}

class _ThisSeasonBannerState extends State<AnimeCard> {
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
        Padding(
          padding: const EdgeInsets.only(right: 50, left: 15, bottom: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.anime.title,
                maxLines: 2,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  color: textLight,
                  fontWeight: FontWeight.w600,
                  fontSize: MediaQuery.of(context).size.shortestSide * 0.06,
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
      ]),
    );
  }
}
