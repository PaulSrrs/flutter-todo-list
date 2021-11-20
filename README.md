# Doing

A simple flutter todo-list application, it works on IOS and Android.

## How to launch

### Method 1

You have to install flutter CLI on this link : https://docs.flutter.dev/reference/flutter-cli <br />
Once installed, you just have to install an IOS or Android emulator or connect a mobile or tablet device. <br />
Then, just execute the following command at the root of the repository : <br />

> flutter run

### Method 2

You have to install Android Studio and open the project, then, run on the device of your choice.

## Routing

* /stepper = Page in charge of getting personal information when we haven't any of these
* /task = Page in charge of showing and editing your tasks
* /task/update = Page in charge of editing an existant task
* /task/add = Page in charge of creating a new task
* /profile = Page in charge of showing and editing our personal information
* /settings = Page in charge of accessing to the settings of the applications
* /our-team = Page in charge of showing overview of every member of our team
* /our-team/member = Page in charge of showing a member of our team

You can find a routing schema here : [schema](https://github.com/Emilien-Delevoye/Flutter-I/blob/develop/lib/routes/routing_schema.png)

See routes file here : [routes](https://github.com/Emilien-Delevoye/Flutter-I/blob/develop/lib/routes/routes.dart)

## Figma

We have [mock-ups](https://github.com/Emilien-Delevoye/Flutter-I/tree/master/mock_up) created thanks to Figma software

## Models

We have a [models](https://github.com/Emilien-Delevoye/Flutter-I/tree/master/lib/models) folder when you can find two models :
- One for the todo item : the "Todo" model
- One for the user of the application: the "User" model which is an abstract class

Two other model inherit from User model: AppUser and TeamMember.

## Authors

* **Paul Surrans** _alias_ [@PaulSrrs](https://github.com/PaulSrrs)
