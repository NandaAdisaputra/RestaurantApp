import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:submission01flutter/data/restaurant.dart';
import 'package:submission01flutter/helper/sizes_helpers.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = '/detail_page';

  final Restaurant restaurant;

  const DetailScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Detail Restaurant'),
            backgroundColor: Colors.deepOrange,
            foregroundColor: Colors.white,
            elevation: 4,
            leading: Padding(
                padding: const EdgeInsets.all(12),
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ))),
        endDrawer: Drawer(
          child: SafeArea(
            child: Column(
              children: const <Widget>[
                MenuTile(title: 'Home'),
                MenuTile(title: 'Tentang Kami'),
                MenuTile(title: 'Menu'),
                MenuTile(title: 'Delivery Order'),
                MenuTile(title: 'Hubungi Kami'),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Image.network(restaurant.pictureId),
          Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Text(
                      restaurant.name,
                      style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: displayWidth(context) * 0.08,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Helvetica'),
                    )),
                    Row(
                      children: [
                        Center(
                          child: Icon(
                            Icons.location_on_outlined,
                            color: Colors.orange,
                          ),
                        ),
                        SizedBox(width: displayWidth(context) * 0.008),
                        Center(
                          child: Text(
                            restaurant.city,
                            style: TextStyle(
                                fontSize: displayWidth(context) * 0.06,
                                color: Colors.orange),
                          ),
                        ),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
                        Text(
                          '|',
                          style: TextStyle(
                              fontSize: displayWidth(context) * 0.09,
                              color: Colors.deepOrange),
                        ),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 3.0)),
                        RatingBar.builder(
                          ignoreGestures: true,
                          itemSize: displayWidth(context) * 0.055,
                          initialRating: restaurant.rating,
                          glowColor: Colors.transparent,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.blue,
                          ),
                          onRatingUpdate: (rating) {},
                        ),
                        SizedBox(width: displayWidth(context) * 0.085),
                        Row(
                          children: [
                            Text(
                              restaurant.rating.toString(),
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: displayWidth(context) * 0.05),
                            ),
                          ],
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.deepOrange,
                      thickness: 5,
                    ),
                    Padding(padding: EdgeInsets.all(3)),
                    Text(
                      'Deskripsi',
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: displayWidth(context) * 0.05,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Helvetica'),
                    ),
                    Padding(padding: EdgeInsets.all(5)),
                    Text(
                      restaurant.description,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: displayWidth(context) * 0.05,
                          fontWeight: FontWeight.normal),
                    ),
                    Divider(
                      color: Colors.deepOrange,
                      thickness: 5,
                    ),
                    Padding(padding: EdgeInsets.all(3)),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Menus',
                        style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: displayWidth(context) * 0.06,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Helvetica'),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(5)),
                    Column(children: [
                      Container(
                        color: Colors.blueAccent,
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
                        height: displayHeight(context) * 0.05,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Text("Menu Makanan",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: displayWidth(context) * 0.05,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Helvetica'))),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.0)),
                            Text(
                              '|',
                              style: TextStyle(
                                  fontSize: displayWidth(context) * 0.06,
                                  color: Colors.white),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3.0)),
                            Expanded(
                                child: Text("Menu Minuman",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: displayWidth(context) * 0.05,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Helvetica')))
                          ],
                        ),
                      ),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: restaurant.menus.foods.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                    color: Colors.orange,
                                    elevation: 4,
                                    margin: EdgeInsets.all(8),
                                    child: Column(children: [
                                      Text(
                                          '- ' +
                                              restaurant
                                                  .menus.foods[index].name,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                displayWidth(context) * 0.05,
                                          )),
                                    ]));
                              },
                            )),
                            Expanded(
                                child: ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              shrinkWrap: true,
                              itemCount: restaurant.menus.drinks.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                    color: Colors.deepOrange,
                                    elevation: 4,
                                    margin: EdgeInsets.all(8),
                                    child: Column(children: [
                                      Text(
                                        '- ' +
                                            restaurant.menus.drinks[index].name,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                displayWidth(context) * 0.05,
                                            fontWeight: FontWeight.normal),
                                      )
                                    ]));
                              },
                            )),
                          ])
                    ])
                  ]))
        ])));
  }
}

class MenuTile extends StatelessWidget {
  final String title;

  const MenuTile({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      trailing: const Icon(
        Icons.navigate_next,
        color: Colors.black,
      ),
    );
  }
}
