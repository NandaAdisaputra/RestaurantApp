import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        '/detail': (context) => DetailScreen(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant,
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
  List<Restaurant> restaurantItems = [];
  List<Restaurant>? restaurant = [];
  var items =<Restaurant>[];
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000), () {
      setState(() {
        isLoaded = true;
      });
    });
  }
  void filterSearchResults(String query) {
    items.clear();
    setState(() {
      for(int i = 0; i < restaurant!.length; i++){
        if( restaurant![i].name.contains(query.toLowerCase())){
          items.add(restaurant![i]);
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    List<Restaurant> restaurantFilterItems = [];
    if (controller.text.isNotEmpty) {
      restaurantFilterItems = restaurantItems
          .where((element) => element.name
          .toLowerCase()
          .contains(controller.text.toLowerCase()))
          .toList();
    } else {
      restaurantFilterItems = restaurantItems;
    }
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
              child: Column(
                  children: <Widget>[
              Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: controller,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
              Expanded(
              child: FutureBuilder<String>(
                  future: DefaultAssetBundle.of(context)
                      .loadString('assets/data/local_restaurant.json'),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                    final List<Restaurant> restaurant = controller.text.isNotEmpty?
                    items : parseRestaurants(snapshot.data);
                      return ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: restaurant.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.white60,
                            elevation: 8,
                            child: Column(children: [
                              if ((restaurant[index].pictureId).isEmpty)
                                _buildErrorImage()
                              else
                                isLoaded
                                    ? _buildRestaurantItem(
                                        context, restaurant[index])
                                    : getShimmerLoading(),
                            ]),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return _buildErrorWidget(snapshot.error as String);
                    } else {
                      return _buildLoadingWidget();
                    }
                  }),
            )]))));
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Hero(
        tag: restaurant.pictureId,
        child: Image.network(
          restaurant.pictureId,
          fit: BoxFit.fitHeight,
          width: displayWidth(context) * 0.2,
        ),
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
                    fontSize: displayWidth(context) * 0.04,
                    color: Colors.orange),
              )
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              RatingBar.builder(
                ignoreGestures: true,
                itemSize: displayWidth(context) * 0.05,
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

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Text("Error: $error"),
    );
  }

  Widget _buildLoadingWidget() {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.5,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorImage() {
    return Stack(
      children: [
        Container(
          width: 80.0,
          height: 120.0,
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.1),
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            shape: BoxShape.rectangle,
          ),
        ),
        const Positioned(
          bottom: 0.0,
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: Icon(
            Icons.broken_image_rounded,
            color: Colors.red,
          ),
        ),
      ],
    );
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
