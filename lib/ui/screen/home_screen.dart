import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shimmer/shimmer.dart';
import 'package:submission01flutter/data/restaurant.dart';
import 'package:submission01flutter/helper/sizes_helpers.dart';
import 'package:submission01flutter/ui/screen/splash_screen.dart';
import 'detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/splashscreen',
      routes: {
        '/splashscreen': (context) => SplashScreen(),
        '/home': (context) => HomeScreen(),
        '/detail': (context) =>
            DetailScreen(
              restaurant:
              ModalRoute
                  .of(context)
                  ?.settings
                  .arguments as Restaurant,
            )
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  double rating = 3.5;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000), () {
      setState(() {
        isLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
              title: Text('Home Page'),
              backgroundColor: Colors.deepOrange,
              foregroundColor: Colors.white,
              elevation: 4,
              leading: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Image.asset('assets/images/sendok_garpu.png'))),
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
          body: Container(
            child: FutureBuilder<String>(
                future: DefaultAssetBundle.of(context)
                    .loadString('assets/data/local_restaurant.json'),
                builder: (context, snapshot) {
                  final List<Restaurant> restaurant =
                  parseRestaurants(snapshot.data);
                  if (snapshot.hasData) {
                    return ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: restaurant.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.white60,
                          elevation: 8,
                          child: Column(children: [
                            isLoaded
                                ? _buildRestaurantItem(
                                context, restaurant[index])
                                : getShimmerLoading(),
                          ]),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ));
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return ListTile(
      contentPadding:
      const EdgeInsets.fromLTRB(8, 2, 8, 2),
      leading: Hero(
        tag: restaurant.pictureId,
          child: Container(
            width: displayWidth(context)  * 0.2,
            child: AspectRatio(
                aspectRatio: 1/1,
                child: Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200.0),
                        boxShadow:[
                          BoxShadow(
                              color: Color.fromARGB(60, 0, 0, 0),
                              blurRadius: 8.0,
                              offset: Offset(5.0, 5.0)
                          )
                        ],
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: Image.network(restaurant.pictureId,width:  displayWidth(context)  * 0.8,height: displayHeight(context) * 0.8).image
                        )
                    )
                )
            ),
          )
      ),


      subtitle: Column(
        children: [
          Row(
            children: [
              Text(
                restaurant.name,
                style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: displayWidth(context) * 0.05,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Helvetica'),
              )
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: Colors.orange,
              ),
              SizedBox(width: 8),
              Text(
                restaurant.city,
                style: TextStyle(
                    fontSize: displayWidth(context) * 0.03,
                    color: Colors.orange),
              )
            ],
          ),
          SizedBox(height:12),
          Row(
            children: [
              RatingBar.builder(
                itemSize: displayWidth(context) * 0.05,
                initialRating: restaurant.rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) =>
                    Icon(
                      Icons.star,
                      color: Colors.blue,
                    ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              SizedBox(width: 50),
              Row(
                children: [
                  Text(
                    restaurant.rating.toString(),
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
      onTap: () {
        Navigator.pushNamed(context, '/detail', arguments: restaurant);
      },
    );
  }
}

Shimmer getShimmerLoading() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 100,
          width: 100,
          color: Colors.white,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 18.0,
                color: Colors.white,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 14.0,
                color: Colors.white,
              ),
            ],
          ),
        )
      ],
    ),
  );
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
        style: Theme
            .of(context)
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
