import 'package:flutter/material.dart';
import 'package:project_demo/data.dart';
import 'package:project_demo/view/styles.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: kDefaultPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Discover',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
                sizedHeight(30),
                TextField(
                  decoration: InputDecoration(
                      hintText: 'Search here',
                      isCollapsed: true,
                      suffixIcon: const Icon(Icons.search),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      filled: true,
                      fillColor: Colors.grey,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                sizedHeight(30),
                Container(
                  width: double.infinity,
                  height: 220,
                  padding: kDefaultPadding,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.3), BlendMode.darken),
                          image: const AssetImage('assets/topbg.jpg'),
                          fit: BoxFit.cover)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Upcoming Event\nBook Fair',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              width: 100,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: whiteColor.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Join us',
                                    style: TextStyle(
                                        color: blackColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 12,
                                    color: blackColor,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                sizedHeight(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Popular Now',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                    Text('See all')
                  ],
                ),
                sizedHeight(30),
                SizedBox(
                  width: 900,
                  height: 400,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: getBooks.length,
                      itemBuilder: (context, index) {
                        final data = getBooks[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 200,
                              height: 280,
                              margin: const EdgeInsets.only(right: 20),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                      data.imgDIr,
                                    ),
                                    fit: BoxFit.contain),
                              ),
                            ),
                            sizedHeight(10),
                            SizedBox(
                                width: 200,
                                child: Text(
                                  data.title,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ))
                          ],
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
