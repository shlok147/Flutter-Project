import 'package:flutter/material.dart';
import 'package:day_night_themed_switcher/day_night_themed_switcher.dart';

class setting extends StatefulWidget {
  const setting({super.key});

  @override
  State<setting> createState() => _settingState();
}

class _settingState extends State<setting> with SingleTickerProviderStateMixin {
  late AnimationController settings;

  @override
  void initState() {
    super.initState();
    settings = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();
    ThemeMode theme = ThemeMode.light;
  }

  @override
  void dispose() {
    settings.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeMode theme = ThemeMode.light;
    bool pushNotifications = true;
    bool newMessages = true;
    bool newMatches = true;
    bool profileUpdates = false;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF800020),
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Roteation_Icon(0.0, 1.0),
              Text(
                " Settings ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w500),
              ),
              Roteation_Icon(1.0, 0.0),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xFFFFF8F0),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Theme Card
                      Card(
                        color: Colors.white,
                        elevation: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Theme Mode",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: DayNightSwitch(
                                size: 50,
                                onChange: (dark) => setState(() {
                                  theme =
                                      dark ? ThemeMode.dark : ThemeMode.light;
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        elevation: 2,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 15, right: 15, bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title
                              Text(
                                'Account Settings',
                                style: TextStyle(
                                    color: Color(0xFF800020),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),

                              // List settings
                              Column(
                                children: [
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: Icon(
                                      Icons.person,
                                      color: Colors.black,
                                    ),
                                    title: Text(
                                      'Edit Profile',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400),
                                    ),
                                    trailing:
                                        Icon(Icons.arrow_forward_ios, size: 16,color: Colors.black,),
                                    onTap: () {},
                                  ),
                                  Divider(),
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: Icon(Icons.lock,color: Colors.black,),
                                    title: Text(
                                      'Change Password',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400),
                                    ),
                                    trailing:
                                        Icon(Icons.arrow_forward_ios, size: 16,color: Color(0xFF000000),),
                                    onTap: () {},
                                  ),
                                  Divider(),
                                ],
                              ),

                              const SizedBox(height: 10),

                              // Notification section
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: Icon(Icons.notifications,
                                        size: 25, color: Colors.black),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Notifications',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),

                                        // Switches and messages
                                        SwitchListTile(
                                          contentPadding: EdgeInsets.zero,
                                          title: Text('Push Notifications'),
                                          value: pushNotifications,
                                          onChanged: (val) {
                                            setState(
                                                () => pushNotifications = val);
                                          },
                                        ),
                                        SwitchListTile(
                                          contentPadding: EdgeInsets.zero,
                                          title: Text('New Messages'),
                                          value: newMessages,
                                          onChanged: (val) {
                                            setState(() => newMessages = val);
                                          },
                                        ),
                                        if (newMessages)
                                          _buildMessageCard(
                                            icon: Icons.person,
                                            name: 'Alex',
                                            message:
                                                'Hey, I liked your profile! Let\'s connect.',
                                            time: 'Now',
                                          ),
                                        SwitchListTile(
                                          contentPadding: EdgeInsets.zero,
                                          title: Text('New Matches'),
                                          value: newMatches,
                                          onChanged: (val) {
                                            setState(() => newMatches = val);
                                          },
                                        ),
                                        if (newMatches)
                                          _buildMatchCard(
                                            message: 'You have a new match!',
                                            details:
                                                'Sarah is interested in your profile. View now!',
                                            time: '2m ago',
                                          ),
                                        SwitchListTile(
                                          contentPadding: EdgeInsets.zero,
                                          title: Text('Profile Updates'),
                                          value: profileUpdates,
                                          onChanged: (val) {
                                            setState(
                                                () => profileUpdates = val);
                                          },
                                        ),
                                        if (profileUpdates)
                                          _buildProfileTipCard(
                                            message: 'Profile Tip',
                                            details:
                                                'Add more photos to get 3x more matches.',
                                            time: '1h ago',
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 110,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 40,
              ),
              child: Center(
                child: Container(
                  width: 200,
                  height: 20,
                  decoration: BoxDecoration(
                      // gradient: LinearGradient(
                      //   begin: Alignment.topCenter,
                      //   end: Alignment.bottomCenter,
                      //   colors: [
                      //     Color(0xFF800020),
                      //     Color(0xFF800020),
                      //
                      //     Color(0xFFFFF8F0), Color(0xFFFFF8F0),
                      //     //
                      //     // Colors.white,
                      //     // Color(0xFFFFF8F0),
                      //     Color(0xFF800020),
                      //     Color(0xFF800020),
                      //   ],
                      // ),
                      color: Color(0xFF800020).withOpacity(0.5),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget Roteation_Icon(double start, double end) {
    return RotationTransition(
        turns: Tween(
          begin: start,
          end: end,
        ).animate(settings),
        child: Icon(
          Icons.settings,
          size: 30,
          color: Colors.white,
        ));
  }

  Widget _buildMessageCard(
      {required IconData icon,
      required String name,
      required String message,
      required String time}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: CircleAvatar(child: Icon(icon)),
        title: Text('New Message from $name',
            style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(message),
        trailing: Text(time, style: TextStyle(color: Colors.grey)),
      ),
    );
  }

  Widget _buildMatchCard(
      {required String message,
      required String details,
      required String time}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(Icons.favorite, color: Colors.red, size: 32),
        title: Text(message,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
        subtitle: Text(details),
        trailing: Text(time, style: TextStyle(color: Colors.grey)),
      ),
    );
  }

  Widget _buildProfileTipCard(
      {required String message,
      required String details,
      required String time}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(Icons.campaign, color: Colors.blue, size: 32),
        title: Text(message, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(details),
        trailing: Text(time, style: TextStyle(color: Colors.grey)),
      ),
    );
  }
}
