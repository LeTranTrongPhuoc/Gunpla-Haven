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

/// A view that displays a map with a specified coordinate and an optional annotation.
struct MapView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D
    var annotationTitle: String?
    var annotationSubtitle: String?
    
    /// Creates a coordinator to manage the map view.
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    /// Creates the MKMapView instance.
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.layer.cornerRadius = 10
        mapView.clipsToBounds = true
        return mapView
    }

    /// Updates the MKMapView instance with new data.
    func updateUIView(_ view: MKMapView, context: Context) {
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = annotationTitle
        annotation.subtitle = annotationSubtitle
        
        if view.annotations.isEmpty {
            view.addAnnotation(annotation)
        } else {
            view.removeAnnotations(view.annotations)
            view.addAnnotation(annotation)
        }
    }

    /// A coordinator to manage MKMapView delegate methods.
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(parent: MapView) {
            self.parent = parent
        }
        
        /// Provides a view for the annotation.
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "Placemark"
            
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
            
            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                annotationView?.glyphTintColor = .white
                annotationView?.markerTintColor = UIColor(named: "CustomPrimaryColor")
                annotationView?.glyphImage = UIImage(systemName: "star.fill")
            } else {
                annotationView?.annotation = annotation
            }
            
            return annotationView
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(
            coordinate: CLLocationCoordinate2D(latitude: 34.011286, longitude: -116.166868),
            annotationTitle: "Sample Location",
            annotationSubtitle: "Subtitle"
        )
    }
}
