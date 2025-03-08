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

/// A view that presents the welcome screen of the Gunpla Haven app.
struct WelcomeView: View {
    @State private var showingAuthorInfo = false
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer()
                
                // App icon
                Image("AppIconImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .padding(.top, 60)
                    .padding(.bottom, 20)

                // App title
                Text("Gunpla Haven")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color("CustomPrimaryColor"))

                // App tagline
                Text("Build. Collect. Admire.")
                    .font(.title3)
                    .foregroundColor(Color("CustomSecondaryColor"))
                    .padding(.bottom, 40)

                // Navigation link to Model List View
                NavigationLink(destination: ModelListView(isDarkMode: colorScheme == .dark).navigationBarHidden(true)) {
                    Text("Start")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("FavoriteColor"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                }
                .padding(.bottom, 20)

                // Button to show author information
                Button(action: {
                    showingAuthorInfo.toggle()
                }) {
                    HStack {
                        Image(systemName: "info.circle")
                            .font(.title)
                        Text("About Author")
                            .font(.title3)
                    }
                    .foregroundColor(Color("CustomSecondaryColor"))
                }
                .padding(.bottom, 40)
                .sheet(isPresented: $showingAuthorInfo) {
                    AuthorInfoView()
                }

                Spacer()
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: colorScheme == .dark ? [Color.black, Color.gray] : [Color.blue, Color.white]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
