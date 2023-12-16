import 'package:anihunt/Color/ColorConst.dart';
import 'package:flutter/material.dart';

class ProfileDetail extends StatefulWidget {
  const ProfileDetail({super.key});

  @override
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Profile",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: textDark,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding:
            const EdgeInsets.only(top: 1.3, right: 20, left: 20, bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: secondary,
              ),
              height: MediaQuery.of(context).size.height * 0.22,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.height * 0.1,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("assets/ProfilePictureTest.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Titit Mledak",
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.022,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                      Text(
                        "Tititmledak@gmail.com",
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.height * 0.012,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.only(left: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: secondary,
              ),
              height: MediaQuery.of(context).size.height * 0.48,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Watched Anime",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.022,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                  const SizedBox(height: 5),
                  Text("307",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.04,
                          fontWeight: FontWeight.w700,
                          color: Colors.white)),
                  const SizedBox(height: 15),
                  Text("Bookmarked Anime",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.022,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                  const SizedBox(height: 5),
                  Text("28",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.04,
                          fontWeight: FontWeight.w700,
                          color: Colors.white)),
                ],
              ),
            ),
            const SizedBox(height: 5),
            InkWell(
              onTap: () {},
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: logoutButton,
                  ),
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.white,
                        size: MediaQuery.of(context).size.height * 0.04,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text("Logout",
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.022,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
