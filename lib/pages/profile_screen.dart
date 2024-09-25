import 'package:ev_homes_customer/Wrappers/auth_wrapper.dart';
import 'package:ev_homes_customer/core/services/auth_service.dart';
import 'package:ev_homes_customer/flutterflow/flutter_flow_theme.dart';
import 'package:ev_homes_customer/flutterflow/flutter_flow_widgets.dart';
import 'package:ev_homes_customer/pages/account_info_page.dart';
import 'package:ev_homes_customer/pages/reset_password_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      body: SafeArea(
        top: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoTile(
              title: 'My Account Information',
              onTap: () => Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    const begin = Offset(1.0, 0.0); // Slide from right
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;

                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                        position: offsetAnimation,
                        child: const AccountProfilePage());
                  },
                  transitionDuration: const Duration(milliseconds: 600),
                ),
              ),
            ),
            _buildInfoTile(
              title: 'Change Password',
              onTap: () => Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    const begin = Offset(1.0, 0.0); // Slide from right
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;

                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                        position: offsetAnimation,
                        child: const ResetPasswordScreen());
                  },
                  transitionDuration: const Duration(milliseconds: 600),
                ),
              ),
            ),
            _buildLogoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile({required String title, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 1.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 70.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            boxShadow: [
              BoxShadow(
                blurRadius: 0.0,
                color: FlutterFlowTheme.of(context).alternate,
                offset: const Offset(0.0, 1.0),
              )
            ],
            shape: BoxShape.rectangle,
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: FlutterFlowTheme.of(context).subtitle2.override(
                        fontFamily: 'Manrope',
                        letterSpacing: 0.0,
                      ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 20.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 36.0, 0.0, 0.0),
      child: Center(
        child: FFButtonWidget(
          onPressed: () async {
            await AuthService().signOut(); // Ensure the user is logged out
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const AuthWrapper(), // Replace with your Login page widget
              ),
            );
          },
          text: 'Log Out',
          options: FFButtonOptions(
            width: 130.0,
            height: 50.0,
            padding: EdgeInsets.zero,
            iconPadding: EdgeInsets.zero,
            color: FlutterFlowTheme.of(context).secondaryBackground,
            textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                  fontFamily: 'Manrope',
                  color: Colors.deepPurpleAccent,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                ),
            elevation: 0.0,
            borderSide: const BorderSide(
              color: Colors.deepPurpleAccent,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    );
  }
}
