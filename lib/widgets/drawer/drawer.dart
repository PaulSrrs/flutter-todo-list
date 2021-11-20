import 'package:flutter/material.dart';
import 'package:doing/routes/routes.dart';
import 'drawer_header.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: Material(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const AppDrawerHeader(),
            ..._buildListTile(context, Icons.settings, 'Settings', AppRoutes.settings, topDivider: true),
            ..._buildListTile(context, Icons.groups, 'Our team', AppRoutes.ourTeam)
          ],
        ),
      ),
    );
  }

  List<StatelessWidget> _buildListTile(
      BuildContext context, IconData icon, String text, String routePath, {bool topDivider = false}) {
    return [
      //if the var topDivider is set to true, then, add a top divider, else, add nothing
      ...topDivider ? [const Divider(height: 1)] : [],
      ListTile(
        title: Text(text, style: Theme.of(context).textTheme.bodyText1),
        leading: Icon(icon, size: 24.0),
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, routePath);
        },
      ),
      const Divider(height: 1),
    ];
  }
}
