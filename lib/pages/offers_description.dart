import 'package:ev_homes_customer/pages/offer.dart';
import 'package:flutter/material.dart';
import 'package:ev_homes_customer/pages/AnimatedGradientScreen.dart'; // Import your AnimatedGradientPage
import 'package:ev_homes_customer/Wrappers/home_wrapper.dart';
// import 'package:ev_homes_customer/pages/login_page.dart'; // Import your login page

class OfferPage extends StatefulWidget {
  const OfferPage({Key? key}) : super(key: key);

  @override
  _OfferPageState createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> {
  final ScrollController _scrollController = ScrollController();
  bool _showTitle = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 200 && !_showTitle) {
      setState(() => _showTitle = true);
    } else if (_scrollController.offset <= 200 && _showTitle) {
      setState(() => _showTitle = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Add the animated gradient as the full-page background
          AnimatedGradient(), // This will cover the entire background
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                expandedHeight: 300.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: _showTitle
                      ? const Text(
                          'Marina Bay 10% Off',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Keep the image but move it within the app bar
                      Image.asset(
                        'assets/images/marinabay.jpg',
                        fit: BoxFit.cover,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7)
                            ],
                          ),
                        ),
                      ),
                      const Positioned(
                        bottom: 16,
                        left: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Marina Bay',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '10% Off Limited Time Offer',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                leading: IconButton(
  icon: const Icon(Icons.arrow_back, color: Colors.white),
  onPressed: () {
    // Navigate to HomeWrapper page using pushReplacement
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeWrapper()),  // Navigate to HomeWrapper instead of LoginPage
    );
  },
),

                actions: [
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildOfferCard(),
                      SizedBox(height: 24),
                      _buildSectionTitle("What's Inside"),
                      _buildDescription(
                        'Discover your dream home with our limited-time EV Homes Offer. Own a modern, spacious, and beautifully designed apartment in one of the city\'s most prestigious residential towers.',
                      ),
                      SizedBox(height: 24),
                      _buildSectionTitle("Why Choose Us?"),
                      _buildFeatureList(),
                      SizedBox(height: 24),
                      _buildSectionTitle("Don't Miss Out!"),
                      _buildDescription(
                        'This limited-time offer won\'t last long! Contact us today to schedule a viewing and explore our beautiful listings. Your dream home awaits—let\'s make it a reality together!',
                      ),
                      SizedBox(height: 24),
                      _buildViewSimilarOffersButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOfferCard() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/evicon.png', height: 40),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '10% Off',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Valid up to 31st Dec 2024',
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            const SizedBox(height: 16),
            const Text(
              'Starts from 1.9 cr, All inclusive',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const OfferDetailPage(showDiolog: true),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                padding:
                    EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: Text('Buy Now', style: TextStyle(fontSize: 16)),
            ),
            SizedBox(height: 8),
            Text(
              '*Terms & Conditions Applied',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDescription(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 16, color: Colors.white),
    );
  }

  Widget _buildFeatureList() {
    final features = [
      'Quality Construction',
      'Customizable Options',
      'Exceptional Customer Service',
    ];

    return Column(
      children: features.map((feature) => _buildFeatureItem(feature)).toList(),
    );
  }

  Widget _buildFeatureItem(String feature) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green),
          SizedBox(width: 8),
          Text(feature, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildViewSimilarOffersButton() {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const OfferDetailPage(showDiolog: false),
            ),
          );
        },
        icon: Icon(Icons.search),
        label: Text('View Similar Offers'),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.purple,
          backgroundColor: Colors.white,
          side: BorderSide(color: Colors.purple),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30)),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    );
  }
}
