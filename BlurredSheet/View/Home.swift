//
//  Home.swift
//  BlurredSheet
//
//  Created by Seungchul Ha on 2022/12/14.
//

import SwiftUI
import MapKit

struct Home: View {
    
    // MARK: Sheet Property
    @State var showSheet: Bool = false
    @State var showFullScreenCover: Bool = false
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            // MARK: Sample Map Region
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 25.2048, longitude: 55.2708), latitudinalMeters: 10000, longitudinalMeters: 10000)
            Map(coordinateRegion: .constant(region))
                .ignoresSafeArea()
            
            // MARK: Sheet Button
            HStack {
                Button {
                    showSheet.toggle()
                } label: {
                    Image(systemName: "dock.rectangle")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                .padding(15)
                .blurredSheet(.init(.ultraThinMaterial), show: $showSheet) {
                    
                } content: {
                    Text("Hello From Sheets") // Works with Presentation Detents
                        .presentationDetents([.large, .medium, .height(150)]) // 3 different sizes
                }
                
                Spacer()
                
                Button {
                    showFullScreenCover.toggle()
                } label: {
                    Image(systemName: "dock.rectangle")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                .padding(15)
                // Note: It won't work for NavigationStack, since it requires background color for its push/pop animation.
                .blurredFullScreenCover(.init(.ultraThinMaterial), show: $showFullScreenCover) {
                    
                    
                } content: {
                    Text("Hello From Sheets") // Works with Presentation Detents
                    
                    Button{
                        showFullScreenCover.toggle()
                    } label: {
                        Text("Close")
                    }
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
