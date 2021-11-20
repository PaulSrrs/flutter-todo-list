import 'package:doing/components/camera.dart';
import 'package:doing/constants/colors.dart';
import 'package:doing/services/shared_preferences.service.dart';
import 'package:doing/widgets/inputs/text_input.dart';
import 'package:flutter/material.dart';
import 'package:doing/constants/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController(text: "");
  TextEditingController lastNameController = TextEditingController(text: "");
  TextEditingController ageController = TextEditingController(text: "");
  TextEditingController jobController = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    firstNameController.text = await SharedPreferencesService().getString(AppSharedPreferences.firstname) ?? '';
    lastNameController.text = await SharedPreferencesService().getString(AppSharedPreferences.lastname) ?? '';
    ageController.text = await SharedPreferencesService().getString(AppSharedPreferences.age) ?? '';
    jobController.text = await SharedPreferencesService().getString(AppSharedPreferences.job) ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.success,
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
          child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16.0, 64.0, 16.0, 32.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: double.infinity),
                      const TakePictureScreen(),
                      const SizedBox(height: 32),
                      AppInput(
                        controller: firstNameController,
                        placeholder: 'Firstname *',
                        textCapitalization: TextCapitalization.words,
                        errorMessage: "Please enter your firstname",
                      ),
                      const SizedBox(height: 16.0),
                      AppInput(
                        controller: lastNameController,
                        placeholder: 'Lastname *',
                        textCapitalization: TextCapitalization.words,
                        errorMessage: "Please enter your lastname",
                      ),
                      const SizedBox(height: 16.0),
                      AppInput(
                        controller: jobController,
                        placeholder: 'Job *',
                        textCapitalization: TextCapitalization.sentences,
                        errorMessage: "Please enter your job",
                      ),
                      const SizedBox(height: 16.0),
                      AppInput(
                        controller: ageController,
                        placeholder: 'Age *',
                        textCapitalization: TextCapitalization.none,
                        errorMessage: "Please enter your age",
                      ),
                    ],
                  )))),
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: MaterialButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          highlightElevation: 0.0,
          elevation: 0.0,
          color: AppColors.success,
          child: const Text('Save', style: TextStyle(fontSize: 16.0, color: Colors.white)),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              SharedPreferencesService().setString(AppSharedPreferences.firstname, firstNameController.text);
              SharedPreferencesService().setString(AppSharedPreferences.lastname, lastNameController.text);
              SharedPreferencesService().setString(AppSharedPreferences.job, jobController.text);
              SharedPreferencesService().setString(AppSharedPreferences.age, ageController.text);
              Navigator.pop(context);
            }
          },
        ),
      ),
    );
  }
}
