# Pomo Tempus

#### Video Demo: https://www.youtube.com/watch?v=x76ibsahvpM

#### Description:

Pomo Tempus is a Windows 11 application developed with the cross platform Flutter framework.

Basically its a Pomodoro Timer like application, but for desktop.

#### The user can:

- Change focus, short and long break timer duration, default timers are 25, 5, 15.
- Windows notification
- Change color theme

It is developed based on best practices of [Flutter Architecture guide](https://docs.flutter.dev/app-architecture)

#### Patterns

- Singleton
  Design pattern to create a unique instance of a class, useful to maintain the class state through the various calls.
- Result
- Dependency Injection
  Good practice to bring external resources to be used at the class, creating a well maintainable code base.

#### Layers

##### Data Layer

- Repositories
  - settings_repository.dart
    The file responsible for managing the domain model, and interact with datasources, bringing data and sending it to the ui layer.
    - Get from the local service
    - Send to local service
- Services
  - shared_preferences_service.dart
    Service that encapsulate the use of shared preferences package, used to store and retrieve values locally in the device.
    - Get from local device
    - Save at local device
  - theme_service.dart
    Singleton service to handle the changing the theme on the fly in the entire application.
    - Initial value of the color theme
    - Update the color theme globally

##### Domain

- Models
  - settings.dart
  - settings.freezed.dart
  - settings.g.dart
    All theses files represent the Settings model used to store the values the user preferred to use, the .g file and freezed are automatically created to handle immutability and json serialization/deserialization. The use of Freezed package is recommend by the Flutter team.

##### UI

- View models
  - home_view_model.dart
    The responsible for handle the logic of the page, it have all the states, all the logics to of the home page.
    - The initial state, retrieving from the repository if exist stored settings, or populating it with the initial one.
    - Playing or paused state
    - Timer logic
      - The unique part of the code that Gen AI was used to help construct the method. Others users of AI was only in code completion
    - Change timer logic
    - Handle changes of the form at view
    - Update settings, sending it to the repository
- Widgets
  - home_page.dart
    Has all the visual artifacts and less logic possible, enough to handle basic thing to the page
    - Besides the page, it also has the Settings modal, where the user put the data that him want update, with Form validation.

#### Utils

- result.dart
  Declare the Result pattern, used through the entire application.
  Its a pattern to handle the result of the request and interaction between the layers.
  Helps improve the code readability and the Error handling.

#### Main

- main.dart
  - runApp
    The start of the application, it has the initial configuration of the dependency injection with the Provider package, and start the MainApp.
  - MainApp
    Handles the theme declaration and changes, also the declaration of the application routing with the GoRouter package.

### Packages

- windows_notification
  Package used to make the interfaced with the C++ native code and make possible to do notifications in the windows

- msix
  Package used to do the build of the application to Windows 11 platform, and being possible to publish at Microsoft Store. Generating a msix bundle (handle some configurations to build for the platform)

- provider
  Recommended package by the Flutter team, to handle the dependency injection pattern
- go_router
  Another package recommended by the Flutter team, this one is to handle the routing of the application, actually the app have only one route, but, this is very useful and easy to configure.
- flutter_colorpicker
  This package i used to let the user select a color easily trough a very powerful and beautiful widget.
- shared_preferences
  This one like already said before is used to store and retrieve locally.
- app_links
  App links is used to create deeplinks in the app, this one is installed to create deeplinks, so when the user clicks at the notification, open the app again.
- freezed_annotation
  This is used at the domain model, to annotate the class, so the freezed package could work.
- json_annotation
  Followed by freezed_annotation, this is used by the json_serializable, to make possible json_serializable work

### Dev packages

- flutter_launcher_icons
  I used this to create the icons for the application through a png icon, this generate the icon for all platforms.
- freezed
  Uses the freezed_annotation to identify the classes to implement the methods creating a immutable entity
- json_serializable
  this is used by freezed, identifying json annotations to serialize and deserialize for json
- build_runner
  Used to automatic generate the files for freezed and json_serializable for

### Usage

To run the app in debug mode, make sure to have the Flutter framework installed with a version of 3.29 or greater, in a Windows 11 OS.
Also need to have Visual Studio 2022 installed to be possible to build the app for Windows.
Try to use the [Flutter official documentation for windows](https://docs.flutter.dev/get-started/install/windows/desktop) if you have any difficulties.

Or just install the pomo_tempus.exe found in the root folder of the repository.
