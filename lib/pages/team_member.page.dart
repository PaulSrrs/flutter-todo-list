import 'package:flutter/material.dart';
import 'package:doing/models/user.model.dart';

class TeamMemberPage extends StatefulWidget {
  const TeamMemberPage({Key? key}) : super(key: key);

  @override
  TeamMemberPageState createState() {
    return TeamMemberPageState();
  }
}

class TeamMemberPageState extends State<TeamMemberPage> {
  TeamMember? member;

  @override
  void didChangeDependencies() {
    Map? data = ModalRoute.of(context)!.settings.arguments as Map?;
    setState(() {
      member = data?['member'];
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${member?.firstname} ${member?.lastname}"),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: (member != null)
              ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                  const SizedBox(width: double.infinity),
                  const Text("\n", style: TextStyle(fontSize: 24)),
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/img/asset-flutter-" +
                        member!.firstname +
                        ".png"),
                    minRadius: 50,
                    maxRadius: 75,
                  ),
                  Text("\n${member!.firstname}",
                      style: Theme.of(context).textTheme.headline2),
                  Text("${member!.lastname} \n",
                      style: Theme.of(context).textTheme.headline2),
                  Text("${member!.getAge()} \n",
                      style: Theme.of(context).textTheme.headline3),
                  Text(member!.getJob(),
                      style: Theme.of(context).textTheme.headline3),
                  const SizedBox(height: 32)
                ])
              : null),
    );
  }
}
