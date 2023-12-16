import 'package:anihunt/Color/ColorConst.dart';
import 'package:anihunt/models/anime.dart';
import 'package:flutter/material.dart';

class AnimeBanner extends StatelessWidget {
  final Anime anime;
  const AnimeBanner({
    super.key,
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
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
