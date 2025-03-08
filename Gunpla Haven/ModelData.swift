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

import Foundation
import Combine

/// The main model data class that holds the list of Gunpla models and manages the favorite filter.
final class ModelData: ObservableObject {
    /// Published property that holds the list of Gunpla models.
    @Published var models: [GunplaModel] = load("models.json")
    /// Published property that determines whether to show only favorite models.
    @Published var showFavoritesOnly = false
}

/// Struct representing a Gunpla model.
struct GunplaModel: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var imageName: String
    var grade: String
    var series: String
    var details: String
    var isFavorite: Bool
    var storeAddress: String
    var locationCoordinate: Coordinate
    var additionalImages: [String]
    var features: [String]
    var reviews: [String]
    var videoURL: String
    var reviewStars: Double
    var popularityData: [PopularityData]
    
    /// Struct representing the coordinates of the Gunpla model store.
    struct Coordinate: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
    
    /// Struct representing the popularity data of the Gunpla model.
    struct PopularityData: Hashable, Codable {
        var grade: String
        var popularity: Int
    }
}

/// Loads and decodes a JSON file from the main bundle.
func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    /// Ensure the file exists in the main bundle.
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    /// Load the data from the file.
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    /// Decode the data into the specified type.
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
