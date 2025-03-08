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

struct AuthorInfoView: View {
    @Environment(\.presentationMode) var presentationMode // Environment variable to manage the presentation mode
    @Environment(\.colorScheme) var colorScheme // Environment variable to manage the color scheme (light/dark mode)

    var body: some View {
        ZStack {
            // Background gradient that changes based on the color scheme
            LinearGradient(
                gradient: Gradient(colors: colorScheme == .dark ? [Color.black, Color.gray] : [Color.blue, Color.white]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                // Author information title
                Text("Author Information")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("CustomPrimaryColor"))
                    .padding(.top, 40)

                // Author details
                VStack(alignment: .leading, spacing: 10) {
                    Text("Name: Le Tran Trong Phuoc")
                        .font(.headline)
                        .foregroundColor(Color("TextColor"))

                    Text("Student ID: s3927230")
                        .font(.headline)
                        .foregroundColor(Color("TextColor"))

                    Text("COSC2813 Assignment 1 2024")
                        .font(.headline)
                        .foregroundColor(Color("TextColor"))
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal, 20)
                .shadow(radius: 5)

                Spacer()

                // Close button to dismiss the view
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Close")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("FavoriteColor"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                }
                .padding(.bottom, 40)
                .shadow(radius: 10)
            }
        }
    }
}

struct AuthorInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorInfoView()
    }
}
