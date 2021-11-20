import 'package:doing/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:doing/models/user.model.dart';

class OurTeamPage extends StatelessWidget {
  const OurTeamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Our Team"),
      ),
      body: ListView(
        children: <Widget>[
          ..._buildListTile(context, "Alfred", "Deschildre"),
          ..._buildListTile(context, "Emilien", "Delevoye"),
          ..._buildListTile(context, "Paul", "Surrans"),
          ..._buildListTile(context, "William", "Petitprez")
        ],
      ),
    );
  }

  List<StatelessWidget> _buildListTile(
      BuildContext context, String firstname, String lastname) {
    return [
      ListTile(
        title: Text("$firstname $lastname", style: Theme.of(context).textTheme.bodyText1),
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.ourTeamMember,
            arguments: {
              'member': TeamMember(firstname, lastname),
            });
        },
      ),
      const Divider(height: 1),
    ];
  }
}
