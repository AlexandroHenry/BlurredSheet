//
//  Extension+View.swift
//  BlurredSheet
//
//  Created by Seungchul Ha on 2022/12/14.
//

import SwiftUI

extension View {
    // MARK: Custom View Modifier
    func blurredSheet<Content: View>(_ style: AnyShapeStyle, show: Binding<Bool>, onDismiss: @escaping ()->(), @ViewBuilder content: @escaping ()-> Content) -> some View {
        self
            .sheet(isPresented: show, onDismiss: onDismiss) {
                content()
                    .background(RemoveBackgroundColor())
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background {
                        Rectangle()
                            .fill(style)
                            .ignoresSafeArea(.container, edges: .all)
                    }
            }
    }
    
    func blurredFullScreenCover<Content: View>(_ style: AnyShapeStyle, show: Binding<Bool>, onDismiss: @escaping ()->(), @ViewBuilder content: @escaping ()-> Content) -> some View {
        self
            .fullScreenCover(isPresented: show, onDismiss: onDismiss) { // also works with full screen cover
                content()
                    .background(RemoveBackgroundColor())
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background {
                        Rectangle()
                            .fill(style)
                            .ignoresSafeArea(.container, edges: .all)
                    }
            }
    }
}

// AnyShapeStyle -> Materials, Colors, etc.
// show -> Dismiss Status
// onDismiss -> Dismiss Action
// content -> Sheet Content View

// MARK: Helper View
fileprivate struct RemoveBackgroundColor: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        return UIView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        DispatchQueue.main.async {
            uiView.superview?.superview?.backgroundColor = .clear
            
            // uiView         / superview  / superview
            // backgroundView/SwiftUI View/SwiftUI Container View.
        }
    }
}
