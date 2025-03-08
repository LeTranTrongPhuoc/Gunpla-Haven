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

struct ModelListView: View {
    @EnvironmentObject var modelData: ModelData
    @State private var searchText = "" // State variable to manage search text
    @State private var selectedGrade = "All" // State variable to manage selected grade
    @State var isDarkMode: Bool // State variable to manage dark mode
    @State private var showingFavoritesInfo = false // State variable to manage the favorites info alert
    @State private var showingDarkModeInfo = false // State variable to manage the dark mode info alert

    // Computed property to filter models based on selected grade, search text, and favorite status
    var filteredModels: [GunplaModel] {
        modelData.models.filter { model in
            (selectedGrade == "All" || model.grade == selectedGrade) &&
            (!modelData.showFavoritesOnly || model.isFavorite) &&
            (searchText.isEmpty || model.name.lowercased().contains(searchText.lowercased()))
        }
        .sorted { $0.name < $1.name }
    }

    // Computed property to get all unique grades plus "All"
    var grades: [String] {
        var allGrades = Set(modelData.models.map { $0.grade })
        allGrades.insert("All")
        return Array(allGrades).sorted()
    }

    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient that changes based on the dark mode status
                LinearGradient(gradient: Gradient(colors: isDarkMode ? [Color.black, Color.gray] : [Color.blue, Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 0) {
                    HStack {
                        favoriteButton
                        Spacer()
                        darkModeButton
                    }
                    .padding(.vertical)
                    .background(Color("BackgroundColor").opacity(0.7))

                    searchBar

                    // Picker to select model grades
                    Picker("Grade", selection: $selectedGrade) {
                        ForEach(grades, id: \.self) { grade in
                            Text(grade).tag(grade)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    .padding(.bottom, 10)

                    // List of filtered models
                    List {
                        ForEach(filteredModels) { model in
                            NavigationLink(destination: ModelDetailView(model: model)) {
                                ModelRow(model: model)
                                    .padding(.vertical, 5)
                            }
                            .listRowBackground(Color.clear)
                        }
                    }
                    .listStyle(PlainListStyle())
                    .background(Color.clear)
                }
                .background(Color.clear.edgesIgnoringSafeArea(.all))
                .navigationTitle("Gunpla Models")
                .navigationBarTitleTextColor(Color("CustomPrimaryColor"))
                .navigationBarItems(leading: backButton)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    // View for the favorite button with long press gesture to show info alert
    private var favoriteButton: some View {
        Button(action: {
            modelData.showFavoritesOnly.toggle()
            showingFavoritesInfo = false
        }) {
            Image(systemName: modelData.showFavoritesOnly ? "heart.fill" : "heart")
                .font(.headline)
                .foregroundColor(modelData.showFavoritesOnly ? .red : .white)
        }
        .padding(.leading)
        .onLongPressGesture {
            showingFavoritesInfo.toggle()
        }
        .alert(isPresented: $showingFavoritesInfo) {
            Alert(
                title: Text("Favorites Filter"),
                message: Text("Toggle to show only your favorite models."),
                dismissButton: .default(Text("Got it!"))
            )
        }
    }

    // View for the dark mode toggle button with long press gesture to show info alert
    private var darkModeButton: some View {
        Button(action: {
            withAnimation {
                isDarkMode.toggle()
            }
            if let window = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .first?.windows
                .first {
                window.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
            }
            showingDarkModeInfo = false
        }) {
            Image(systemName: isDarkMode ? "moon.fill" : "sun.max.fill")
                .font(.headline)
                .foregroundColor(.white)
        }
        .padding(.trailing)
        .onLongPressGesture {
            showingDarkModeInfo.toggle()
        }
        .alert(isPresented: $showingDarkModeInfo) {
            Alert(
                title: Text("Dark Mode"),
                message: Text("Toggle between light and dark mode."),
                dismissButton: .default(Text("Got it!"))
            )
        }
    }

    // View for the search bar
    private var searchBar: some View {
        HStack {
            TextField("Search", text: $searchText)
                .padding()
                .background(Color(isDarkMode ? .gray : .systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
                .foregroundColor(isDarkMode ? .white : .primary)

            Button(action: {
                searchText = ""
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(Color(isDarkMode ? .gray : .systemGray6))
                    .padding(.trailing)
            }
        }
        .padding(.bottom, 20)
    }

    // View for the back button
    private var backButton: some View {
        NavigationLink(destination: WelcomeView().navigationBarHidden(true)) {
            HStack {
                Image(systemName: "chevron.left")
                Text("Back")
            }
            .foregroundColor(Color("CustomPrimaryColor"))
        }
    }
}

// Extension to change the navigation bar title color
extension View {
    func navigationBarTitleTextColor(_ color: Color) -> some View {
        self.modifier(NavigationBarTitleTextColor(color: UIColor(color)))
    }
}

struct NavigationBarTitleTextColor: ViewModifier {
    init(color: UIColor) {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: color]
        appearance.largeTitleTextAttributes = [.foregroundColor: color]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    func body(content: Content) -> some View {
        content
    }
}

struct ModelListView_Previews: PreviewProvider {
    static var previews: some View {
        ModelListView(isDarkMode: false)
            .environmentObject(ModelData())
    }
}
