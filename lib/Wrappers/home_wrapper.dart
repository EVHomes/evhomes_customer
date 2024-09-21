import 'package:ev_homes_customer/pages/chat.dart';
import 'package:ev_homes_customer/pages/enquiry_form.dart';
import 'package:ev_homes_customer/pages/home_page.dart';
import 'package:ev_homes_customer/pages/my_meetings.dart';
import 'package:ev_homes_customer/pages/offer.dart';
// import 'package:ev_homes_customer/pages/offer_pop_up_page.dart';
// import 'package:ev_homes_customer/pages/offer_pop_up_page.dart';
import 'package:ev_homes_customer/pages/schedule_meeting.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class HomeWrapper extends StatefulWidget {
  const HomeWrapper({super.key});

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  bool _isMenuVisible = false;

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  final List<Widget> _pages = [
    const HomeScreen(),
    MyMeetings(),
    const ChatPage(),
    OfferPage(),  // Add your Offer page here
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      _isMenuVisible = false;
    });
  }

  void _toggleMenu() {
    setState(() {
      if (_isMenuVisible) {
        _animationController.reverse();
      } else {
        _animationController.forward();
      }
      _isMenuVisible = !_isMenuVisible;
    });
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
      reverseDuration: const Duration(milliseconds: 275),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
        reverseCurve: Curves.easeIn,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(child: _pages[_currentIndex]),
        if (_isMenuVisible)
          GestureDetector(
            onTap: () {
              setState(() {
                _isMenuVisible = false;
              });
            },
            child: AnimatedOpacity(
              opacity: _isMenuVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                color: Colors.black.withOpacity(
                  0.4,
                ),
              ),
            ),
          ),
        if (_isMenuVisible) ...[
          Positioned(
            bottom: 170.0,
            right: 16.0,
            child: SlideTransition(
              position: _slideAnimation,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent),
                onPressed: () {
                  setState(() {
                    _isMenuVisible = false;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScheduleMeetingPage(),
                    ),
                  );
                },
                child: const Text(
                  'Schedule Meeting',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 220.0,
            right: 16.0,
            child: SlideTransition(
              position: _slideAnimation,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent),
                onPressed: () {
                  setState(() {
                    _isMenuVisible = false;
                  });

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EnquiryForm(),
                    ),
                  );
                },
                child: const Text(
                  'Enquiry Form',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
        Positioned(
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
                NavItem(
                  label: "Meetings",
                  icon: FluentIcons.stack_20_regular,
                  index: 1,
                  onTap: () {
                    _onItemTapped(1);
                  },
                  currentIndex: _currentIndex,
                ),
                NavItem(
                  label: "Home",
                  icon: FluentIcons.home_20_regular,
                  index: 0,
                  onTap: () {
                    _onItemTapped(0);
                  },
                  currentIndex: _currentIndex,
                ),
                NavItem(
                  label: "Chat",
                  icon: FluentIcons.chat_empty_20_regular,
                  index: 2,
                  onTap: () {
                    _onItemTapped(2);
                  },
                  currentIndex: _currentIndex,
                ),
                NavItem(
                  label: "Offer",
                  icon: FluentIcons.gift_20_regular,
                  index: 3,
                  onTap: () {
                    _onItemTapped(3);
                  },
                  currentIndex: _currentIndex,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 100.0,
          right: 20.0,
          child: FloatingActionButton(
            backgroundColor: Colors.deepPurpleAccent,
            elevation: 10,
            onPressed: _toggleMenu,
            tooltip: 'Menu',
            child: const Icon(
              FluentIcons.add_24_regular,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class NavItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final int index;
  final int currentIndex;
  final Function() onTap;

  const NavItem({
    super.key,
    required this.label,
    required this.icon,
    required this.index,
    required this.onTap,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
              fontWeight: FontWeight.normal,
              color:
                  currentIndex == index ? Colors.deepPurpleAccent : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
