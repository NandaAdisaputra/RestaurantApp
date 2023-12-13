import 'package:flutter/material.dart';
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
                child: IconButton(icon: Icon(Icons.arrow_back),
                  onPressed: (){
                  Navigator.pop(context);
                  },))
        ),
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
          child: Column(
            children: [
              Image.network(restaurant.pictureId),
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      style:
                      TextStyle(fontSize: displayWidth(context)  * 0.05, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text(
                          restaurant.city,
                          style: TextStyle(fontSize: displayWidth(context)  * 0.05),
                        ),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
                        Text(
                          '|',
                          style: TextStyle(fontSize: 25),
                        ),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 3.0)),
                        Text(
                          'Rating : ' + restaurant.rating.toString(),
                          style: TextStyle(fontSize: displayWidth(context)  * 0.05),
                        ),
                      ],
                    ),
                    Divider(
                      color: Color(0XFF8C8282),
                      thickness: 5,
                    ),
                    Padding(padding: EdgeInsets.all(3)),
                    Text(
                      'Deskripsi',
                      style:
                      TextStyle(fontSize: displayWidth(context)  * 0.05, fontWeight: FontWeight.bold),
                    ),
                    Padding(padding: EdgeInsets.all(5)),
                    Text(
                      restaurant.description,
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: displayWidth(context)  * 0.05),
                    ),
                    Divider(
                      color: Color(0XFF8C8282),
                      thickness: 5,
                    ),
                    Padding(padding: EdgeInsets.all(3)),
                    Text(
                      'Menu',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(5)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: restaurant.menus.foods.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Text(
                                  '- ' + restaurant.menus.foods[index].name,
                                  style: TextStyle(fontSize: 18),
                                );
                              },
                            )),
                        Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              shrinkWrap: true,
                              itemCount: restaurant.menus.drinks.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Text(
                                  '- ' + restaurant.menus.drinks[index].name,
                                  style: TextStyle(fontSize:displayWidth(context)  * 0.05),
                                );
                              },
                            ))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
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