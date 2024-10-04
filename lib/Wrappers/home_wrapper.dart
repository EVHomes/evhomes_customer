
import 'package:ev_homes_customer/component/emi_calculator.dart';
// import 'package:ev_homes_customer/pages/chat.dart';
import 'package:ev_homes_customer/pages/chat_screen.dart';
import 'package:ev_homes_customer/pages/enquiry_form.dart';
import 'package:ev_homes_customer/pages/home_screen.dart';
import 'package:ev_homes_customer/pages/my_meetings.dart';
import 'package:ev_homes_customer/pages/offer.dart';
// import 'package:ev_homes_customer/pages/offers_description.dart';
import 'package:ev_homes_customer/pages/schedule_meeting.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class HomeWrapper extends StatefulWidget {
  const HomeWrapper({Key? key}) : super(key: key);

  @override
  _HomeWrapperState createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  bool _isMenuVisible = false;
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<double> _iconAnimation;

  final List<Widget> _pages = [
    HomeScreen(),
  MyMeetings(),
    ChatScreen(),
    OfferDetailPage(showDiolog: true,),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration:
          const Duration(milliseconds: 1000), // Slide-in (coming) duration
      reverseDuration:
          const Duration(milliseconds: 600), // Slide-out (going) duration
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _iconAnimation = Tween<double>(begin: 0, end: 0.125).animate(_animation);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      _isMenuVisible = !_isMenuVisible;
      if (_isMenuVisible) {
        _animationController.forward(); // Slide-in
      } else {
        _animationController.reverse(); // Slide-out
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pages[_currentIndex],
          if (_isMenuVisible) _buildBottomSheet(),
          _buildBottomNavBar(),
          _buildFloatingActionButton(),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
  return Positioned(
    bottom: 20,
    left: 20,
    right: 20,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: _buildNavItem("Home", FluentIcons.home_20_regular, 0),
          ),
          Expanded(
            child: _buildNavItem("Meetings", Icons.meeting_room_rounded, 1),
          ),
          const SizedBox(width: 25), // Spacing for the floating action button
          Expanded(
            child: _buildNavItem("Offers", Icons.local_offer, 3),
          ),
          Expanded(
            child: _buildNavItem("Chat", FluentIcons.chat_empty_20_regular, 2),
          ),
        ],
      ),
    ),
  );
}

  Widget _buildNavItem(String label, IconData icon, int index) {
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color:
                currentIndex == index ? Colors.deepPurpleAccent : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Manrope',
              fontWeight: FontWeight.normal,
              color: _currentIndex == index ? Colors.black : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return Positioned(
      bottom: 50.0,
      left: MediaQuery.of(context).size.width / 2 - 25,
      child: GestureDetector(
        onTap: _toggleMenu,
        child: AnimatedBuilder(
          animation: _iconAnimation,
          builder: (context, child) {
            return Transform.rotate(
              angle: _iconAnimation.value * 2 * 3.14159,
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: const Color(0xFF2e2252),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF2e2252).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBottomSheet() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, (1 - _animation.value) * 450),
            child: child,
          );
        },
        child: Container(
          height: 450,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: _buildActionCard(
                        'Enquiry Form',
                        Icons.description,
                        'Create a new enquiry',
                        () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const EnquiryForm())),
                      ),
                    ),
                    Expanded(
                      child: _buildActionCard(
                        'meeting',
                        Icons.label,
                        'schedule your meetings',
                        () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ScheduleMeeting())),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: _buildActionCard(
                        'EMI Calculator',
                        Icons.calculate,
                        'Calculate your Emi',
                        () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const EmiCalculator())),
                      ),
                    ),
                    Expanded(
                      child: _buildActionCard(
                        'Settings',
                        Icons.settings,
                        'Adjust app settings',
                        () {
                          // Navigate to Settings screen
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                    height:
                        100), // Extra space to account for the navigation bar
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard(
      String title, IconData icon, String description, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF2e2252).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: const Color(0xFF2e2252), size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2e2252),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
