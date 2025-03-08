/*
  RMIT University Vietnam
  Course: COSC2659|COSC2813 iOS Development
  Semester: 2024B
  Assessment: Assignment 1
  Author: Le Tran Trong Phuoc
  ID: s3927230
  Created  date: 31/07/2024
  Last modified: 31/07/2024
  Acknowledgement: Canvas lectures and tutorials, Stack Overflow, Apple Developer Documentation, and ChatGPT for assistance with error fixing and code formatting.
*/

import SwiftUI
import WebKit

/// A view that displays a web page from a given URL string.
struct WebView: UIViewRepresentable {
    let urlString: String // The URL string of the web page to load.

    /// Creates and returns a `WKWebView` instance.
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    /// Updates the `WKWebView` instance with the provided URL request.
    /// - Parameters:
    ///   - uiView: The `WKWebView` instance to update.
    ///   - context: The context for coordinating with SwiftUI.
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: urlString) { // Ensure the URL string can be converted to a URL.
            let request = URLRequest(url: url) // Create a URL request.
            uiView.load(request) // Load the request in the web view.
        }
    }
}
