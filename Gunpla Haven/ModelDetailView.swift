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
import MapKit
import Charts
import AVKit

/// A view that displays detailed information about a specific Gunpla model.
struct ModelDetailView: View {
    @EnvironmentObject var modelData: ModelData
    var model: GunplaModel
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedTab = "Details"

    // Computed property to get the index of the current model in the model data.
    var modelIndex: Int {
        modelData.models.firstIndex(where: { $0.id == model.id })!
    }

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(gradient: Gradient(colors: colorScheme == .dark ? [Color.black, Color.gray] : [Color.blue, Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack(spacing: 20) {
                    // Image slider for model images
                    ImageSlider(images: [model.imageName] + model.additionalImages)
                        .frame(height: 300)
                        .padding()

                    // Model name
                    Text(model.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("CustomPrimaryColor"))
                        .padding(.horizontal)

                    favoriteButton

                    // Model series and grade
                    HStack {
                        Text(model.series)
                        Spacer()
                        Text(model.grade)
                    }
                    .padding(.horizontal)
                    .font(.headline)
                    .foregroundColor(Color("TextColor"))

                    // Review stars view
                    ReviewStarsView(reviewStars: Int(model.reviewStars))

                    // Picker for selecting tabs
                    Picker("Details", selection: $selectedTab) {
                        Text("Details").tag("Details")
                        Text("Features").tag("Features")
                        Text("Reviews").tag("Reviews")
                        Text("Popularity").tag("Popularity")
                        Text("Video").tag("Video")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    .accentColor(Color("FavoriteColor"))

                    contentForSelectedTab

                    // Store address information
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Store Address:")
                            .font(.headline)
                            .foregroundColor(Color("CustomPrimaryColor"))
                        Text(model.storeAddress)
                            .foregroundColor(Color("TextColor"))
                    }
                    .padding(.horizontal)

                    // Map view for store location
                    MapView(coordinate: CLLocationCoordinate2D(
                        latitude: model.locationCoordinate.latitude,
                        longitude: model.locationCoordinate.longitude),
                        annotationTitle: model.name,
                        annotationSubtitle: model.storeAddress)
                        .frame(height: 300)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .shadow(radius: 5)

                    socialMediaLinks
                }
                .padding(.vertical)
            }
        }
        .navigationTitle(model.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    /// A button to toggle the favorite status of the model.
    private var favoriteButton: some View {
        Button(action: {
            modelData.models[modelIndex].isFavorite.toggle()
        }) {
            HStack {
                Image(systemName: modelData.models[modelIndex].isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(modelData.models[modelIndex].isFavorite ? Color.red : Color.gray)
                Text(modelData.models[modelIndex].isFavorite ? "Unfavorite" : "Favorite")
                    .fontWeight(.bold)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(colorScheme == .dark ? Color.black.opacity(0.8) : Color(.systemGray6))
            .cornerRadius(10)
            .shadow(radius: 5)
        }
    }

    /// Content view for the selected tab.
    private var contentForSelectedTab: some View {
        Group {
            if selectedTab == "Details" {
                Text(model.details)
                    .padding()
                    .background(colorScheme == .dark ? Color.black.opacity(0.8) : Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .shadow(radius: 5)
            } else if selectedTab == "Features" {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(model.features, id: \.self) { feature in
                        Text(feature)
                    }
                }
                .padding()
                .background(colorScheme == .dark ? Color.black.opacity(0.8) : Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
                .shadow(radius: 5)
            } else if selectedTab == "Reviews" {
                VStack(alignment: .leading) {
                    ForEach(model.reviews, id: \.self) { review in
                        Text(review)
                    }
                }
                .padding()
                .background(colorScheme == .dark ? Color.black.opacity(0.8) : Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
                .shadow(radius: 5)
            } else if selectedTab == "Popularity" {
                VStack {
                    Text("Popularity of Grades")
                        .font(.headline)
                    Chart {
                        ForEach(model.popularityData, id: \.grade) { data in
                            BarMark(
                                x: .value("Grade", data.grade),
                                y: .value("Popularity", data.popularity)
                            )
                            .foregroundStyle(Color("FavoriteColor"))
                        }
                    }
                    .frame(height: 200)
                    .padding()
                }
                .background(colorScheme == .dark ? Color.black.opacity(0.8) : Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
                .shadow(radius: 5)
            } else if selectedTab == "Video" {
                VStack {
                    Text("Model Overview Video")
                        .font(.headline)
                        .foregroundColor(Color("CustomPrimaryColor"))

                    WebView(urlString: model.videoURL)
                        .frame(height: 200)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding()
                .background(colorScheme == .dark ? Color.black.opacity(0.8) : Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
            }
        }
    }

    /// Social media links section.
    private var socialMediaLinks: some View {
        VStack {
            Text("Connect with Us")
                .font(.headline)
                .foregroundColor(Color("CustomPrimaryColor"))

            HStack(spacing: 20) {
                socialMediaButton(imageName: "TwitterIcon", url: "https://twitter.com")
                socialMediaButton(imageName: "FacebookIcon", url: "https://facebook.com")
                socialMediaButton(imageName: "InstagramIcon", url: "https://instagram.com")
            }
            .padding()
        }
        .padding(.horizontal)
    }

    /// Creates a button for a social media link.
    private func socialMediaButton(imageName: String, url: String) -> some View {
        Button(action: {
            openURL(urlString: url)
        }) {
            Image(imageName)
                .resizable()
                .frame(width: 40, height: 40)
        }
    }

    /// Opens a URL in the default web browser.
    private func openURL(urlString: String?) {
        if let urlString = urlString, let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
}

/// A view that displays a star rating for a model.
struct ReviewStarsView: View {
    var reviewStars: Int

    var body: some View {
        HStack {
            ForEach(0..<5) { index in
                Image(systemName: index < reviewStars ? "star.fill" : "star")
                    .foregroundColor(index < reviewStars ? .yellow : .gray)
            }
        }
        .padding(.horizontal)
    }
}

struct ModelDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ModelDetailView(model: ModelData().models[0])
            .environmentObject(ModelData())
    }
}
