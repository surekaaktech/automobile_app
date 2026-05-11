import 'package:flutter/material.dart';
import '../../Widget/Footer/footer.dart';
import 'write_review_screen.dart';
import '../../State/favorites_state.dart';
import '../Favorite/favorite_screen.dart';
import '../Profile/profile_screen.dart';

class BusinessDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> company;

  const BusinessDetailsScreen({super.key, required this.company});

  @override
  State<BusinessDetailsScreen> createState() => _BusinessDetailsScreenState();
}

class _BusinessDetailsScreenState extends State<BusinessDetailsScreen> {
  late List<Map<String, dynamic>> _reviews;
  late double _averageRating;
  late int _reviewCount;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Initialize with mock reviews or empty
    _reviews = [];
    _reviewCount = 0;
    _averageRating = 0.0;
  }

  void _addReview(Map<String, dynamic> reviewData) {
    setState(() {
      _reviews.add(reviewData);
      _reviewCount = _reviews.length;
      
      // Calculate new average rating
      double sum = 0;
      for (var r in _reviews) {
        sum += r["rating"];
      }
      _averageRating = sum / _reviewCount;
    });
  }

  void _showReviewDialog() {
    int localRating = 0;
    final TextEditingController localCommentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Write Review",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0C1427),
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Rating",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0C1427),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return GestureDetector(
                          onTap: () {
                            setDialogState(() {
                              localRating = index + 1;
                            });
                          },
                          child: Icon(
                            index < localRating ? Icons.star : Icons.star_border,
                            size: 40,
                            color: index < localRating ? const Color(0xFF222845) : Colors.grey.shade300,
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "Comment",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0C1427),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: localCommentController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: "Tell us about your experience...",
                        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text("Cancel"),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (localRating == 0) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Please select a rating")),
                                );
                                return;
                              }
                              _addReview({
                                "rating": localRating.toDouble(),
                                "comment": localCommentController.text,
                              });
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF222845),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text("Submit Review"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back, color: Color(0xFF0C1427)),
        ),
        title: const Text(
          'Business Details',
          style: TextStyle(
            color: Color(0xFF0C1427),
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey.shade200,
            height: 1.0,
          ),
        ),
      ),
      bottomNavigationBar: CustomFooter(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 0) {
            Navigator.of(context).popUntil((route) => route.isFirst);
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FavoriteScreen()),
            ).then((_) => setState(() {}));
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            ).then((_) => setState(() {}));
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main Business Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            widget.company["name"] ?? "Unknown",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0C1427),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              FavoritesState.toggleFavorite(widget.company);
                            });
                          },
                          icon: Icon(
                            FavoritesState.isFavorite(widget.company["id"]) ? Icons.favorite : Icons.favorite_border,
                            color: const Color(0xFF0C1427),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.company["category"] ?? "Category",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            widget.company["location"] ?? "Location",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 20, color: Color(0xFF222845)),
                        const SizedBox(width: 4),
                        Text(
                          _averageRating.toStringAsFixed(1),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFF0C1427),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "($_reviewCount reviews)",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF222845),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            "Open",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.phone_outlined, size: 18),
                            label: const Text("Call Now"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF222845),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.location_on_outlined, size: 18),
                            label: const Text("View Map"),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF0C1427),
                              side: BorderSide(color: Colors.grey.shade300),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.language, size: 18),
                            label: const Text("Website"),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF0C1427),
                              side: BorderSide(color: Colors.grey.shade300),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.share_outlined, size: 18),
                            label: const Text("Share"),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF0C1427),
                              side: BorderSide(color: Colors.grey.shade300),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              
              // About Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "About",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0C1427),
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Fast and affordable bike servicing",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              
              // Business Info Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Business Info",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0C1427),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 18, color: Color(0xFF0C1427)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            widget.company["location"] ?? "Location",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF0C1427),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: const [
                        Icon(Icons.phone_outlined, size: 18, color: Color(0xFF0C1427)),
                        SizedBox(width: 8),
                        Text(
                          "+91 44 2233 4455",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF0C1427),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: const [
                        Icon(Icons.access_time, size: 18, color: Color(0xFF0C1427)),
                        SizedBox(width: 8),
                        Text(
                          "9:00 AM - 6:00 PM",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF0C1427),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Reviews Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Reviews ($_reviewCount)",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0C1427),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _showReviewDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF222845),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    child: const Text(
                      "Write Review",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              if (_reviews.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 32.0),
                    child: Text(
                      "No reviews yet",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _reviews.length,
                  itemBuilder: (context, index) {
                    final review = _reviews[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Row(
                                children: List.generate(5, (i) {
                                  return Icon(
                                    i < review["rating"] ? Icons.star : Icons.star_border,
                                    size: 16,
                                    color: i < review["rating"] ? const Color(0xFF222845) : Colors.grey.shade300,
                                  );
                                }),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                review["rating"].toString(),
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ],
                          ),
                          if (review["comment"] != null && review["comment"].isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                review["comment"],
                                style: const TextStyle(fontSize: 14, color: Color(0xFF0C1427)),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
