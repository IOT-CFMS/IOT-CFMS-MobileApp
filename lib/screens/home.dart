import 'package:carousel_slider/carousel_slider.dart';
import 'package:coffee_app/screens/menu.dart';
import 'package:coffee_app/screens/widgets/banner.dart';
import 'package:coffee_app/screens/widgets/category_item.dart';
import 'package:coffee_app/screens/widgets/item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedCategory = 0;
  List<String> list = ['Cappuccino', 'Machiato', 'Latte', 'Americano'];
  String _currentLocation = "Loading...";

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location service is enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _currentLocation = "Location Disabled";
      });
      return;
    }

    // Request permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _currentLocation = "Permission Denied";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _currentLocation = "Permission Permanently Denied";
      });
      return;
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Reverse geocoding to get place name
    List<Placemark> placemarks =
    await placemarkFromCoordinates(position.latitude, position.longitude);

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;
      setState(() {
        _currentLocation = "${place.locality}, ${place.country}";
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      body: Stack(
        children: [
          Container(
            height: 280,
            width: size.width,
            decoration: const BoxDecoration(color: Color(0xff131313)),
          ),
          Column(
            children: [
              Center(
                child: SizedBox(
                  width: 315,
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.060,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Location",
                                style: GoogleFonts.sora(
                                  color: const Color(0xffB7B7B7),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    _currentLocation,
                                    style: GoogleFonts.sora(
                                      color: const Color(0xffDDDDDD),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.white,
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            width: 44,
                            height: 44,
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (content) => const MenuPage() ),
                                );
                              },
                            child: Image.asset(
                              "assets/images/avatar.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.030,
                      ),
                      SizedBox(
                        height: 52,
                        child: TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xff313131),
                            contentPadding: const EdgeInsets.only(
                              top: 23,
                              bottom: 2,
                              right: 5,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            hintText: "Search coffee",
                            hintStyle: GoogleFonts.sora(
                              color: const Color(0xff989898),
                            ),
                            prefixIcon: const Icon(
                              Iconsax.search_normal,
                              color: Colors.white,
                              size: 20,
                            ),
                            suffixIcon: Container(
                              width: 44,
                              height: 44,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xffC67C4E),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Iconsax.setting_4,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.020,
                      ),
                      SizedBox(
                        width: 315,
                        height: 140,
                        child: CarouselSlider(
                          options: CarouselOptions(
                              viewportFraction: 1,
                              enlargeFactor: 0.3,
                              height: size.height * 0.22,
                              enlargeCenterPage: true,
                              autoPlay: true,
                          ),
                          items: List.generate(
                            5,
                            (index) => const BannerCard(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.030,
                      ),
                      SizedBox(
                        height: 40,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              list.length,
                              (index) => CategoryItem(
                                index: index,
                                title: list[index],
                                selectedCategory: selectedCategory,
                                onClick: () {
                                  setState(() => selectedCategory = index);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 430,
                width: 315,
                alignment: Alignment.center,
                child: GridView(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: size.width / 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 239,
                  ),
                  children: const [
                    Item(
                      image: "assets/images/1.png",
                    ),
                    Item(
                      image: "assets/images/2.png",
                    ),
                    Item(
                      image: "assets/images/3.png",
                    ),
                    Item(
                      image: "assets/images/4.png",
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
