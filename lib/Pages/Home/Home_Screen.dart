import 'package:flutter/material.dart';
import '../../Theme/app_colors.dart';
import '../../Widget/Header/header.dart';
import '../../Widget/Footer/footer.dart';
import '../Subcategory/subcategory_screen.dart';
import '../Profile/profile_screen.dart';
import '../Favorite/favorite_screen.dart';
import '../Menu/Menu_Screen.dart';
import '../Emergency/Emergency_Screen.dart';
import '../Laws/Laws_Screen.dart';
import '../Company/company_listing_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomHeader(),
      endDrawer: const MenuScreen(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return _buildMainLayout(context, constraints.maxWidth);
        },
      ),
      bottomNavigationBar: const CustomFooter(currentIndex: 0),
    );
  }

  Widget _buildMainLayout(BuildContext context, double maxWidth) {
    int fuelGridCount = maxWidth > 600 ? 2 : 1;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16), // Space between header and HeroBanner
              _buildHeroBanner(context, height: maxWidth > 600 ? 300 : 240),
              _buildCategoryHeader(context, "Fuel Prices Today"),
              _buildFuelPriceGrid(context, crossAxisCount: maxWidth > 600 ? 4 : 2),
              _buildSectionHeader(context, "Nearby Fuel Pumps", () {}),
              _buildFuelPumpsList(context, crossAxisCount: fuelGridCount),
              _buildCategoryHeader(context, "Browse by Category"),
              _buildCategorySection(context, crossAxisCount: maxWidth > 900 ? 6 : 3),
              _buildSectionHeader(context, "New Launches", () {}),
              _buildNewLaunchesList(context, crossAxisCount: maxWidth > 600 ? 3 : 0), // 0 means horizontal scroll
              _buildSectionHeader(context, "Watch & Explore"),
              _buildWatchExploreSection(context, maxWidth),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeroBanner(BuildContext context, {required double height}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0), // Side margins for better floating look
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Opacity(
              opacity: 0.45,
              child: Image.network(
                'https://images.unsplash.com/photo-1617788138017-80ad40651399?q=80&w=2070&auto=format&fit=crop',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),

          // 🏎️ Supercar HUD Speedometer Backdrop Accent in top right corner
          Positioned(
            top: -30,
            right: -30,
            child: Opacity(
              opacity: 0.12,
              child: Container(
                width: 190,
                height: 190,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                ),
                child: Center(
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5, style: BorderStyle.solid),
                    ),
                    child: const Icon(Icons.speed_outlined, color: Colors.white, size: 70),
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "LIMITED OFFER",
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Get 20% Off on\nFull Car Service",
                  style: TextStyle(
                    color: AppColors.textLight,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.surface,
                    foregroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                  ),
                  child: const Text("Book Now", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection(BuildContext context, {required int crossAxisCount}) {
    final categories = [
      {"icon": Icons.pedal_bike, "label": "2-Wheeler"},
      {"icon": Icons.directions_car, "label": "4-Wheeler"},
      {"icon": Icons.local_shipping_outlined, "label": "3-Wheeler"},
      {"icon": Icons.electric_bolt, "label": "EV"},
      {"icon": Icons.local_shipping, "label": "Commercial"},
      {"icon": Icons.apps, "label": "All"},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: crossAxisCount > 3 ? 1.3 : 0.85,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubcategoryScreen(
                    categoryName: categories[index]["label"] as String,
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.border),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.08),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      categories[index]["icon"] as IconData,
                      color: AppColors.primary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    categories[index]["label"] as String,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoryHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Row(
        children: [
          // 🏎️ Double Racing Stripe Icon Separator
          Container(
            width: 4,
            height: 20,
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 3),
          Container(
            width: 4,
            height: 20,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
              fontFamily: 'Outfit',
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewLaunchesList(BuildContext context, {int crossAxisCount = 0}) {
    final cars = [
      {"name": "Ola S1 Pro", "brand": "Ola Electric", "price": "₹1,47,499"},
      {"name": "Maruti Suzuki Fronx", "brand": "Maruti Suzuki", "price": "₹7,46,000"},
      {"name": "Honda Activa 6G", "brand": "Honda", "price": "₹76,234"},
    ];

    if (crossAxisCount > 0) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.8,
          ),
          itemCount: cars.length,
          itemBuilder: (context, index) {
            return _buildNewLaunchCard(cars[index]);
          },
        ),
      );
    }

    return SizedBox(
      height: 240,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: cars.length,
        itemBuilder: (context, index) {
          return _buildNewLaunchCard(cars[index], width: 200);
        },
      ),
    );
  }

  Widget _buildNewLaunchCard(Map<String, String> car, {double? width}) {
    return Container(
      width: width,
      margin: EdgeInsets.only(right: width != null ? 16 : 0, bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Center(
                child: Icon(Icons.directions_car_outlined, size: 60, color: AppColors.secondary.withOpacity(0.5)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    "New",
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  car["name"]!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  car["brand"]!,
                  style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWatchExploreSection(BuildContext context, double maxWidth) {
    final double videoHeight = maxWidth > 600 ? 350 : 220;
    return Container(
      height: videoHeight,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.circular(24),
        image: const DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1544636331-e26879cd4d9b?q=80&w=2038&auto=format&fit=crop'),
          fit: BoxFit.cover,
          opacity: 0.45,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withOpacity(0.95),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.play_arrow, color: AppColors.textPrimary, size: 50),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Review: The Future of EVs",
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.textLight,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(color: Colors.black45, blurRadius: 10)],
                  ),
                ),
                const Text(
                  "Watch now • 12:45",
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.silver, // silver-white
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "HD 4K",
                style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFuelPumpsList(BuildContext context, {int crossAxisCount = 1}) {
    final pumps = [
      {"name": "Bharat Petroleum", "distance": "1.2 km", "price": "₹96.72"},
      {"name": "Indian Oil", "distance": "2.5 km", "price": "₹96.50"},
      {"name": "Shell Station", "distance": "3.8 km", "price": "₹102.40"},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: crossAxisCount > 1 ? 3.2 : 3.5,
        ),
        itemCount: pumps.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.local_gas_station, color: AppColors.primary),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        pumps[index]["name"]!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "${pumps[index]["distance"]!} away",
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      pumps[index]["price"]!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.primary,
                      ),
                    ),
                    const Text(
                      "per litre",
                      style: TextStyle(fontSize: 10, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, [VoidCallback? onSeeAll]) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          if (onSeeAll != null)
            TextButton(
              onPressed: onSeeAll,
              child: const Text("See All", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
            ),
        ],
      ),
    );
  }

  Widget _buildFuelPriceGrid(BuildContext context, {required int crossAxisCount}) {
    final fuelData = [
      {"label": "Petrol", "price": "₹102.63", "change": "-0.5 ₹/L", "isDown": true},
      {"label": "Diesel", "price": "₹94.24", "change": "+0.3 ₹/L", "isDown": false},
      {"label": "CNG", "price": "₹75.61", "change": "0 ₹/kg", "isDown": null},
      {"label": "EV", "price": "₹8.5", "change": "-0.2 ₹/kWh", "isDown": true},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: crossAxisCount > 2 ? 1.45 : 1.85,
        ),
        itemCount: fuelData.length,
        itemBuilder: (context, index) {
          final data = fuelData[index];
          final isDown = data["isDown"] as bool?;
          
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data["label"] as String,
                    style: const TextStyle(color: AppColors.silver, fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    data["price"] as String,
                    style: const TextStyle(color: AppColors.textLight, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      if (isDown != null)
                        Icon(
                          isDown ? Icons.south_west : Icons.north_east,
                          color: isDown ? Colors.greenAccent : Colors.redAccent,
                          size: 11,
                        ),
                      const SizedBox(width: 4),
                      Text(
                        data["change"] as String,
                        style: TextStyle(
                          color: isDown == null 
                              ? AppColors.silver.withOpacity(0.6) 
                              : (isDown ? Colors.greenAccent : Colors.redAccent),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}
