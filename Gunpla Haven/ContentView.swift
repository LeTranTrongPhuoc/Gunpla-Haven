/*
  RMIT University Vietnam
  Course: COSC2659|COSC2813 iOS Development
  Semester: 2024B
  Assessment: Assignment 1
  Author: Le Tran Trong Phuoc
  ID: s3927230
  Created  date: 29/07/2024
  Last modified: 31/07/2024
  Acknowledgement: Canvas lectures and tutorials, Stack Overflow, Apple Developer Documentation, and ChatGPT for assistance with error fixing and code formatting.
*/

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var modelData: ModelData // Access the shared model data

    var body: some View {
        WelcomeView() // Display the welcome view as the main content
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData()) // Provide a preview with a mock ModelData environment object
    }
}
