//
//  HomeView.swift
//  Weather
//
//  Created by Ahmed Shawky on 03/04/2025.
//

import SwiftUI
import BottomSheet

enum BottomSheetPosition: CGFloat, CaseIterable {
    case top = 0.83  // 702/844
    case middle = 0.385  // 325/844
}

struct HomeView: View {
    @State private var isPresented = true
    @State private var selectedDetent: BottomSheet.PresentationDetent = .small
        @State private var sheetPosition: BottomSheetPosition = .middle
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundGrad
                    .ignoresSafeArea()
                
                Image("Background")
                    .resizable()
                    .ignoresSafeArea()
                
                Image("House")
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(.top, 257)
                
                VStack {
                    Text("Cairo")
                        .font(.largeTitle)
                    
                    VStack {
                        
                        Text(attributedString)
                        
                        Text("H:24°   L:18°")
                            .font(.title3.weight(.semibold))
                    }
                    
                    Spacer()
                }
                .padding(.top, 51)
                
                VStack {}
                .sheetPlus(
                    isPresented: $isPresented,
                    background: Color.clear,
                    onDrag: { translation in
                        print("Dragged to: \(translation)")
                    },
                    main: {
                        ForecastView()
                            .presentationDetentsPlus(
                                [
                                    .fraction(0.385),
                                    .fraction(0.90)
                                ],
                                selection: $selectedDetent
                            )
                            .presentationDragIndicatorPlus(.hidden)
                            .presentationBackgroundInteractionPlus(.enabled)
                    }
                )
                
                TabBar(action: {})
            }
            .navigationBarHidden(true)
        }
    }
    
    private var attributedString: AttributedString {
        var string = AttributedString("19°" + "\n " + "Mostily Clear")
        
        if let temp = string.range(of: "19°") {
            string[temp].font = .system(size: 96, weight: .thin)
            string[temp].foregroundColor = .primary
        }
        
        if let pipe = string.range(of: " | ") {
            string[pipe].font = .title3.weight(.semibold)
            string[pipe].foregroundColor = .secondary
        }
        
        if let weather = string.range(of: "Mostily Clear") {
            string[weather].font = .title3.weight(.semibold)
            string[weather].foregroundColor = .secondary
        }
        
        return string
    }
}

#Preview {
    HomeView()
        .preferredColorScheme(.dark)
}
