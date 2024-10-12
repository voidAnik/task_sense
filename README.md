# Task Sense

## Table of Contents
1. [Project Overview](#project-overview)
2. [Resources](#resources)
3. [Features](#features)
4. [App Screenshots](#app-screenshots)
5. [Technical Specifications](#technical-specifications)
    - [Architecture](#architecture)
    - [State Management](#state-management)
    - [Database](#database)
    - [Routing](#routing)
    - [Dependency Injection](#dependency-injection)
    - [Localization](#localization)
    - [Flavor Configuration](#flavor-configuration)
6. [Installation](#installation)
7. [Running the App](#running-the-app)
    - [With Android Studio](#with-android-studio)
    - [From Command Line](#from-command-line)

## Project Overview
Task Sense is a Flutter-based mobile application designed to help users manage their tasks efficiently while integrating sensor tracking for real-time activity monitoring. This application includes essential features like task creation, editing, deletion, and organization, alongside advanced functionalities such as reminders, due dates, and categorization. The app is optimized for offline use and follows clean code practices and modern architectural patterns to ensure a robust user experience.

## Resources
- **Local Database**: `sqflite` for local data storage and caching.
- **Dependency Injection**: `GetIt` for managing service instances.
- **State Management**: `flutter_bloc` for handling state changes.
- **Route Management**: `go_router` for route management.
- **Sensor Data**: `sensors_plus` for accessing real-time sensor data.

## Features
### Core Functionality
- **Task Management**: Users can create, edit, and delete tasks with associated details like due dates, notes, and completion status.
- **Task Categories**: Ability to categorize tasks based on user-defined labels for better organization.
- **Reminders**: Set reminders for tasks to receive notifications on due dates.
- **Search Functionality**: Quickly find tasks by title or keywords.
- **Offline Support**: All tasks and categories are accessible offline, with data synced to local storage.

### Sensor Tracking
- **Real-Time Sensor Data**: Displays two graphs showing real-time data from the gyroscope and accelerometer sensors.
- **Movement Alert**: Generates an alert when there is significant movement on any two axes simultaneously, indicating high activity.

## App Screenshots
<p float="left">
  <img src="/assets/ss/s1.jpeg" width="150" />&nbsp;&nbsp;&nbsp;
  <img src="/assets/ss/s2.jpeg" width="150" />&nbsp;&nbsp;&nbsp;
  <img src="/assets/ss/s3.jpeg" width="150" />&nbsp;&nbsp;&nbsp;
  <img src="/assets/ss/s4.jpeg" width="150" />&nbsp;&nbsp;&nbsp;
  <img src="/assets/ss/s5.jpeg" width="150" />&nbsp;&nbsp;&nbsp;
  <img src="/assets/ss/s6.jpeg" width="150" />&nbsp;&nbsp;&nbsp;
  <img src="/assets/ss/s7.jpeg" width="150" />&nbsp;&nbsp;&nbsp;
  <img src="/assets/ss/s8.jpeg" width="150" />&nbsp;&nbsp;&nbsp;
  <img src="/assets/ss/s9.jpeg" width="150" />&nbsp;&nbsp;&nbsp;
  <img src="/assets/ss/s10.jpeg" width="150" />
</p>

## Technical Specifications
### Architecture
- **Clean Architecture**: Applied to ensure separation of concerns, scalability, maintainability, and testability. The architecture is divided into data, domain, and presentation layers.

### State Management
- **BLoC**: Used for managing the app's state, handling different states like loading, success, and error efficiently.

### Database
- **Local Storage**: `sqflite` is used for caching data, enabling offline access. The database includes tables for tasks, categories, and reminders.

### Routing
- **go_router**: Manages navigation and routing within the app, providing a clear and concise setup for different screens and flows.

### Dependency Injection
- **GetIt**: Utilized for dependency injection, managing and providing instances of services and repositories throughout the app, improving modularity and testability.

### Localization
- **Multi-language Support**: The app uses localization to support multiple languages based on user preferences.

### Flavor Configuration
- **Different App Flavors**: Configured for development and production environments.


## Installation
1. Clone the repository:
   ```terminal
   git clone https://github.com/voidAnik/task_sense
   ```
3. Navigate to the project directory and install dependencies:
   ```terminal
   flutter pub get
   ```
   

## Running the App
### With Android Studio
- Open the project in Android Studio, where launch configurations for different flavors (**development** and **production**) are saved.
- Select the appropriate configuration and run the app.
- Also Select **All Test** to run the tests.

### From Command Line
- For development flavor:
  ```terminal
  flutter run --flavor development -t lib/app/env/main_development.dart
  ```
  
- For production flavor:
  ```terminal
  flutter run --flavor production -t  lib/app/env/main_production.dart
  ```

- For test:
  ```terminal
  flutter test
  ```
- For informative test:
  ```terminal
  flutter test --reporter expanded

- For Building Apk
    ```terminal
    flutter build apk --flavor development -t lib/app/env/main_development.dart
    ```
    ```terminal
    flutter build apk --flavor production -t  lib/app/env/main_production.dart
    ```
