import 'package:flutter/material.dart';

class BookmarkedWidget extends StatefulWidget {
  const BookmarkedWidget({Key? key}) : super(key: key);

  @override
  _BookmarkedWidgetState createState() => _BookmarkedWidgetState();
}

class _BookmarkedWidgetState extends State<BookmarkedWidget> {
  bool bookmarkStatus = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage("assets/animeImage.jpg"),
          fit: BoxFit.cover,
          colorFilter: const ColorFilter.mode(
            Color.fromRGBO(0, 0, 0, 0.6),
            BlendMode.darken,
          ),
        ),
      ),
      padding: EdgeInsets.all(20),
      width: double.infinity,
      height: 88,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Godzilla-girl",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  bookmarkStatus = !bookmarkStatus;
                });
              },
              icon: Icon(
                bookmarkStatus ? Icons.bookmark : Icons.bookmark_border,
                size: 30,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
