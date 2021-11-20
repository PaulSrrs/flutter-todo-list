import 'package:doing/constants/colors.dart';
import 'package:doing/services/shared_preferences.service.dart';
import 'package:doing/widgets/inputs/text_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doing/routes/routes.dart';
import 'package:doing/constants/shared_preferences.dart';
import 'package:doing/components/camera.dart';

class StepperPage extends StatefulWidget {
  const StepperPage({Key? key}) : super(key: key);

  @override
  State<StepperPage> createState() => StepperPageState();
}

/// StatefulWidget that display the stepper when launching the application
/// without any information.
/// Its uses is to get the information before going into the todolist
class StepperPageState extends State<StepperPage> {
  final _formKey = GlobalKey<FormState>();
  static final TextEditingController _firstName = TextEditingController();
  static final TextEditingController _lastName = TextEditingController();
  static final TextEditingController _age = TextEditingController();
  static final TextEditingController _job = TextEditingController();
  bool _noImageSubmitted = false;
  int _currentStep = 0;

  /// method use to switch steps
  tapped(int step) {
    setState(() => _currentStep = step);
  }

  /// method use to save the information when the button continue is pressed
  continued() async {
    if (_currentStep == 0 && _formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      setState(() {
        _currentStep += 1;
      });
    } else if (_currentStep == 1) {
      String? imagePath = await SharedPreferencesService()
          .getString(AppSharedPreferences.profileImage);
      if (imagePath != null) {
        SharedPreferencesService()
            .setString(AppSharedPreferences.firstname, _firstName.text);
        _firstName.clear();
        SharedPreferencesService()
            .setString(AppSharedPreferences.lastname, _lastName.text);
        _lastName.clear();
        SharedPreferencesService()
            .setString(AppSharedPreferences.job, _job.text);
        _job.clear();
        SharedPreferencesService()
            .setString(AppSharedPreferences.age, _age.text);
        _age.clear();
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.home, (r) => false);
      } else {
        setState(() {
          _noImageSubmitted = true;
        });
      }
    }
  }

  /// method called when button cancel is pressed to come back to previous step
  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
    _noImageSubmitted = false;
  }

  /// builder
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stepper(
        type: StepperType.vertical,
        physics: const ScrollPhysics(),
        currentStep: _currentStep,
        controlsBuilder: (BuildContext context,
            {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) {
          return Column(children: [
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(AppColors.primary),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 12.0))),
                  onPressed: onStepContinue,
                  child: const Text('Continue',
                      style: TextStyle(fontSize: 16.0, color: Colors.white)),
                ),
                const SizedBox(width: 16),
                if (_currentStep > 0)
                  TextButton(
                    onPressed: onStepCancel,
                    child: const Text('Cancel',
                        style: TextStyle(
                            fontSize: 16.0, color: AppColors.greyDark)),
                  )
              ],
            )
          ]);
        },
        onStepTapped: (step) => tapped(step),
        onStepContinue: continued,
        onStepCancel: cancel,
        steps: <Step>[
          Step(
              title: const Text('Personal information'),
              isActive: _currentStep >= 0,
              state: _currentStep >= 0 ? StepState.complete : StepState.disabled,
              content: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8.0, width: double.infinity),
                    AppInput(
                      controller: _firstName,
                      placeholder: 'Firstname *',
                      textCapitalization: TextCapitalization.words,
                      errorMessage: "Please enter your firstname",
                    ),
                    const SizedBox(height: 16.0),
                    AppInput(
                      controller: _lastName,
                      placeholder: 'Lastname *',
                      textCapitalization: TextCapitalization.words,
                      errorMessage: "Please enter your lastname",
                    ),
                    const SizedBox(height: 16.0),
                    AppInput(
                      controller: _job,
                      placeholder: 'Job *',
                      textCapitalization: TextCapitalization.sentences,
                      errorMessage: "Please enter your job",
                    ),
                    const SizedBox(height: 16.0),
                    AppInput(
                      controller: _age,
                      placeholder: 'Age *',
                      textCapitalization: TextCapitalization.none,
                      errorMessage: "Please enter your age",
                    ),
                  ],
                ),
              )),
          Step(
            title: const Text('Profile picture'),
            content: Column(children: [
              const SizedBox(height: 16),
              const TakePictureScreen(),
              const SizedBox(height: 16),
              if (_noImageSubmitted)
                const Text('Please select a photo',
                    style: TextStyle(color: AppColors.warning)),
            ]),
            isActive: _currentStep >= 0,
            state: _currentStep >= 1 ? StepState.complete : StepState.disabled,
          ),
        ],
      ),
    );
  }
}
