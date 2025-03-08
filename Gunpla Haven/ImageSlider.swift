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

/// A view that displays a slider of images with pagination indicators.
struct ImageSlider: View {
    var images: [String] // Array of image names to display in the slider.
    @State private var currentIndex = 0 // The current index of the displayed image.

    var body: some View {
        ZStack(alignment: .bottom) {
            // Tab view to display images with paging.
            TabView(selection: $currentIndex) {
                ForEach(0..<images.count, id: \.self) { index in
                    Image(images[index])
                        .resizable()
                        .scaledToFill()
                        .tag(index)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 5)
                        .padding()
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 300)
            
            // Pagination indicators.
            HStack(spacing: 8) {
                ForEach(0..<images.count, id: \.self) { index in
                    Circle()
                        .fill(index == currentIndex ? Color("CustomPrimaryColor") : Color.gray)
                        .frame(width: 8, height: 8)
                }
            }
            .padding(.bottom, 20)
        }
    }
}

struct ImageSlider_Previews: PreviewProvider {
    static var previews: some View {
        ImageSlider(images: ["rx_78_2_gundam", "rx_78_2_gundam_2", "rx_78_2_gundam_3"])
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color("BackgroundColor"))
    }
}
