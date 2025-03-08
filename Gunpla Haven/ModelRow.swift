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

/// A view that displays a row of information about a Gunpla model.
struct ModelRow: View {
    var model: GunplaModel
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        HStack(spacing: 15) {
            modelImage
            modelDetails
            Spacer()
            if model.isFavorite {
                favoriteIndicator
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
        .background(rowBackground)
        .padding(.horizontal, 10)
    }

    /// An image of the Gunpla model.
    private var modelImage: some View {
        Image(model.imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 70, height: 70)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 5)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("CustomPrimaryColor"), lineWidth: 2)
            )
    }

    /// Details of the Gunpla model including name, series, and grade.
    private var modelDetails: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(model.name)
                .font(.headline)
                .foregroundColor(Color("CustomPrimaryColor"))

            Text(model.series)
                .font(.subheadline)
                .foregroundColor(Color("CustomSecondaryColor"))

            Text(model.grade)
                .font(.caption)
                .foregroundColor(Color("TextColor"))
        }
    }

    /// An indicator showing if the model is a favorite.
    private var favoriteIndicator: some View {
        Image(systemName: "heart.fill")
            .foregroundColor(.red)
            .padding(.trailing, 10)
    }

    /// The background view of the row, adjusting for light and dark mode.
    private var rowBackground: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(colorScheme == .dark ? Color.black : Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(colorScheme == .dark ? Color.white : Color.black, lineWidth: 1)
            )
    }
}

struct ModelRow_Previews: PreviewProvider {
    static var previews: some View {
        ModelRow(model: ModelData().models[0])
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color("BackgroundColor"))
    }
}
