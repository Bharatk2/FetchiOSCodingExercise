# FetchiOSMeals Coding Exercise

## Overview

The FetchiOSMeals app is a Swift-based iOS application designed to demonstrate fundamental concepts of iOS development using SwiftUI, networking, and modern architecture patterns such as MVVM (Model-View-ViewModel). It utilizes TheMealDB API to fetch and display a variety of dessert recipes, showcasing both a list of desserts and detailed views for each selected dessert.

## Features
List of Desserts: Users can browse through a list of desserts. Each entry in the list displays the name of the dessert.
Dessert Details: By selecting a dessert from the list, users can view detailed information about it, including a high-resolution image, ingredients, and cooking instructions.
Asynchronous Image Loading: Dessert images are loaded asynchronously, ensuring a smooth user experience without blocking the UI.
Network Error Handling: The app gracefully handles network errors, displaying alerts to the user if there's an issue fetching the data.
MVVM Architecture: Implements the MVVM architectural pattern for separation of concerns, making the app more maintainable and testable.
Dynamic UI: Utilizes SwiftUI for a dynamic and responsive user interface that adapts to different iOS devices and orientations.
Custom UI Components: Demonstrates the creation and usage of custom UI components, such as a view modifier for setting view elevations based on design tokens.
Technical Details
SwiftUI: For building the user interface in a declarative manner.
Networking: Uses URLSession for network requests to fetch data from TheMealDB API.
Decodable: For parsing JSON response data into Swift model structures.
ObservableObject & Published: For creating observable objects that notify the view of changes to reload the UI dynamically.
Extensions: Swift extensions are used for enhancing existing types with additional functionality, like a custom modifier for shadows.
AsyncImage: Utilized for asynchronously loading and displaying images from URLs.
Error Handling: Implements custom error types to encapsulate various error states encountered during network requests.
Installation

Clone the repository or download the source code. Ensure you have the latest version of Xcode installed on your macOS system. Open the .xcodeproj file with Xcode, select a simulator or your device, and run the project.

## Usage

Upon launching the app, you're presented with a list of dessert options fetched from TheMealDB API. You can scroll through the list and select any dessert to view its detailed information. The detail view provides an image of the dessert, its ingredients, and cooking instructions. Network errors and loading states are handled gracefully, providing feedback to the user as needed.

## Contributing

While this project is primarily a coding exercise, contributions for bug fixes, improvements, or additional features are welcome. Please open an issue or pull request with your suggestions or contributions.

