# Mars Photo App

![App Screenshot](screenshot.png)

Welcome to the Mars Photo App, an iOS application that allows you to explore stunning photos captured by rovers on Mars. This README file provides an overview of the app, its features, and the skills showcased in its development.

## Features

1. **SwiftUI Framework**: The Mars Photo App is built entirely using SwiftUI, Apple's modern framework for building user interfaces across all Apple platforms. SwiftUI allows for declarative and intuitive UI development, making the app easy to maintain and extend.

2. **MVVM Architecture**: The app follows the Model-View-ViewModel (MVVM) architectural pattern, which promotes separation of concerns and makes the codebase more modular and testable.

3. **API Calling with Multithreading**: The app efficiently handles API calls using multithreading. Background threads are utilized for making network requests, ensuring that the main UI thread remains responsive and smooth.

4. **Use of Codable & JSON Parsing**: Codable protocol is utilized for easy parsing of JSON data received from the API responses. Swift's Codable capabilities enable seamless serialization and deserialization of JSON data into custom model objects.

5. **Offline Support using Core Data**: The app provides offline support by caching the fetched photos and their details in Core Data. This allows users to view previously loaded photos even when there is no internet connection.

6. **Unit Testing**: Robust unit tests have been written to ensure the correctness and reliability of critical app functionalities. XCTest framework is used for writing unit tests, and the app is designed with testability in mind.

7. **Push Notification Structure**: The app is designed with a structured foundation for handling push notifications. Although push notification implementation is not included in this version, the app is ready to integrate push notifications with minimal effort.

8. **Proper Managers and Web Services**: The app employs well-organized managers and web services for handling API calls. These components abstract the networking layer and provide a clean and consistent interface for making API requests.

9. **API Calling through Pagination**: The app efficiently fetches data through pagination to load more photos as the user scrolls, providing a seamless browsing experience.

10. **Grid View with Filtering**: The app displays Mars photos in a LazyVGrid, allowing users to scroll through images effortlessly. It also supports filtering based on camera type with three categories: "Curiosity," "Opportunity," and "Spirit." Clicking on a category fetches data specific to that category.


## Requirements

- iOS 15.0+
- Xcode 13.0+
- Swift 5.5+

## How to Run

1. Clone the repository or download the ZIP file.
2. Open the `MarsPhotosApp.xcworkspace` file in Xcode. If you don't find it in directory then install through pods. 
3. Choose the desired simulator or a connected iOS device.
4. Press the "Run" button (or use the shortcut `Cmd + R`) to build and run the app.

## Contributing

Contributions to the Mars Photo App are welcome! If you find any bugs, have feature suggestions, or want to contribute improvements, please feel free to open a pull request.

## Credits

The Mars Photo App is developed by [Sham Kumar]. If you have any questions or need assistance, you can reach out to me at [ksham1999@gmail.com].

## License

The Mars Photo App is released under the [MIT License](LICENSE). You are free to use, modify, and distribute the app as per the terms of the license.

---

Thank you for using the Mars Photo App. We hope you enjoy exploring the fascinating Martian landscapes through the lens of rovers! Happy exploring! 🚀🪐
