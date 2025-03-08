# Gunpla Haven

Welcome to Gunpla Haven, your ultimate app for exploring and admiring Gunpla models! This iOS application showcases a collection of popular Gunpla models with detailed information, interactive features, and a visually engaging design. Built with SwiftUI, Gunpla Haven offers a seamless experience whether you're in light or dark mode.

## Table of Contents

- [Project Description](#project-description)
- [Setup Instructions](#setup-instructions)
- [Usage Examples](#usage-examples)
- [File Structure](#file-structure)
- [Additional Documentation](#additional-documentation)
- [License](#license)

## Project Description

### Overview and Context

Gunpla Haven is an iOS application designed for enthusiasts of Gundam plastic models (Gunpla). The app provides detailed information about various Gunpla models, including images, grades, series, features, and more. Users can explore the models, filter by grade, search by name, and view detailed information for each model.

### Goals

The primary goal of Gunpla Haven is to offer a comprehensive and user-friendly platform for Gunpla enthusiasts to explore and admire their favorite models. The app aims to provide detailed information, high-quality images, and interactive features to enhance the user experience.

### Target Audience

The target audience for Gunpla Haven includes:
- Gunpla enthusiasts and collectors
- Model builders and hobbyists
- Fans of the Gundam series

## Setup Instructions

### Prerequisites

- Xcode 15.4 or later
- iOS 17.5 or later

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/RMIT-Vietnam-Teaching/cosc2659-cosc2813-ios-assignment-1-2024b-LeTranTrongPhuoc.git
   ```
2. Open the project in Xcode:
   ```bash
   open Gunpla\ Haven/Gunpla\ Haven.xcodeproj
   ```
3. Build and run the project on the iPhone 15 Pro Simulator.

## Usage Examples

### Welcome View

- The welcome screen includes the app logo, name, slogan, and navigation buttons to access the list view or author info.

### Model List View

- The list view displays all available Gunpla models with images and short descriptions.
- Users can filter models by grade and search for specific models by name.
- A button allows users to switch between light and dark modes.
- A button to let the users view their favorite models.

### Model Detail View

- The detail view provides comprehensive information about a selected Gunpla model, including images, series, grades, reviews, and features.
- Users can view an image slider, interactive chart, and videos related to the model.
- The map view shows the store location with a pin and annotation.
- List of social media icons that users can click on to reach out to the author (Note: the author's real links are not implemented in the app).

## File Structure

Here is the structure of the project:

```
Gunpla Haven/
├── Gunpla_HavenApp.swift
├── ContentView.swift
├── AuthorInfoView.swift
├── ModelListView.swift
├── WebView.swift
├── ImageSlider.swift
├── ModelDetailView.swift
├── ModelRow.swift
├── MapView.swift
├── ModelData.swift
├── WelcomeView.swift
├── models.json
├── Assets.xcassets
└── Preview Content
```

## Additional Documentation

### Descriptive Comments

Each source code file includes descriptive comments that explain the purpose of the code, the functionality of different components, and any relevant details. Here are some highlights:

- `Gunpla_HavenApp.swift`: Initializes the app and sets up the main environment.
- `ContentView.swift`: Defines the main content view of the app, displaying the welcome screen.
- `AuthorInfoView.swift`: Displays information about the app's author.
- `ModelListView.swift`: Shows a list of Gunpla models with filtering and search functionality.
- `WebView.swift`: Displays web content using a WKWebView.
- `ImageSlider.swift`: Provides an image slider for displaying model images.
- `ModelDetailView.swift`: Displays detailed information about a selected Gunpla model.
- `ModelRow.swift`: Defines the appearance of each row in the model list view.
- `MapView.swift`: Shows the store location on a map with a pin and annotation.
- `ModelData.swift`: Manages the data for Gunpla models, including loading from a JSON file.
- `WelcomeView.swift`: Displays the welcome screen with navigation options.

## Know Limitation 
- The map view currently shows a pin for the store location, but it is not highly interactive.
- The amount of model data is limited, which restricts the implementation of more advanced filtering options.
- The app displays static review stars, and users cannot submit their ratings or feedback.
