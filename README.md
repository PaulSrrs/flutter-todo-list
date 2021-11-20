# Doing

A flutter todo-list application

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
