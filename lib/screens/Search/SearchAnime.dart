import 'package:anihunt/Color/ColorConst.dart';
import 'package:flutter/material.dart';

class SearchAnime extends StatefulWidget {
  const SearchAnime({super.key});

  @override
  State<SearchAnime> createState() => _SearchAnimeState();
}

class _SearchAnimeState extends State<SearchAnime> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Search",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: textDark,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            formCari(),
            SizedBox(
              height: 18,
            ),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: filteredSongs.length,
            //     itemBuilder: (context, index) {
            //       return songSearchResult(
            //         iniListLagu: filteredSongs[index],
            //         currIdx: index,
            //       );
            //     },
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  Widget formCari() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: ShapeDecoration(
        color: accent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: TextField(
        style: TextStyle(color: Color(0xFFD2AFFF)),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(4),
          prefixIcon: Icon(
            Icons.search,
            color: textSearch,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Find your favorite anime here',
          hintStyle: TextStyle(
            color: textSearch,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        onChanged: (value) {
          setState(() {
            // Update string pencarian saat nilai berubah
          });
        },
      ),
    );
  }
}
