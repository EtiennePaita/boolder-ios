//
//  SteepnessPickerView.swift
//  Boolder
//
//  Created by Etienne Païta on 17/05/2025.
//  Copyright © 2025 Nicolas Mondollot. All rights reserved.
//

import SwiftUI

struct SteepnessPickerView: View {
    @Environment(\.presentationMode) var presentationMode
    //@Binding var filters: Filters
    
    let mapState: MapState
    
    @State private var steepnessSelection: Set<Steepness> = Set()
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(Steepness.allCases, id: \.self) { steepness in
                        Button {
                            if steepnessSelection.contains(steepness) {
                                steepnessSelection.remove(steepness)
                            } else {
                                steepnessSelection.insert(steepness)
                            }
                        } label: {
                            HStack {
                                Image(steepness.imageName)
                                    .frame(minWidth: 16)
                                Text(steepness.localizedName)
                                Spacer()
                                Image(systemName: steepnessSelection.contains(steepness) ? "largecircle.fill.circle" : "circle")
                                    .font(Font.body.weight(.bold)).frame(width: 20, height: 20)
                                    .foregroundColor(.appGreen)
                            }
                            .foregroundColor(.primary)
                        }
                    }
                }
                
            }
            .task {
                steepnessSelection = mapState.filters.steepness
            }
            .navigationTitle("filters.steepness")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                    mapState.clearFilters()
                }) {
                    Text("filters.clear")
                        .padding(.vertical)
                        .font(.body)
                },
                trailing: Button {
                    mapState.selectSteepness(steepnessSelection)
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("OK")
                        .bold()
                        .padding(.vertical)
                        .padding(.leading, 32)
                }
            )
        }
    }
}

