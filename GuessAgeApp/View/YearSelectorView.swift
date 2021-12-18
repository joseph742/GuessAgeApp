//
//  YearSelectorView.swift
//  GuessAgeApp
//
//  Created by Joseph Umoru on 27/11/2021.
//

import SwiftUI
import Combine
struct YearSelectorView: View {
    
    @Binding var birthYear: Int
    @Binding var showYearSelector: Bool
    
    var body: some View {
        ZStack {
            Color(.black)
                .opacity(0.4)
                .ignoresSafeArea()
            VStack {
                VStack {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 20) {
                            ForEach((1...100), id: \.self) { year in
                                Button {
                                    birthYear = year
                                    withAnimation(.easeIn) {
                                        showYearSelector = false
                                    }
                                } label: {
                                    Text(String(year))
                                        .foregroundColor(.primary)
                                        .font(.title2)
                                        .fontWeight(.medium)
                                }

                            }
                        }
                    }
                    .frame(height: 200)
                }
                .padding()
                .frame(width: 100)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 20)
            }
        }
    }
}

struct YearSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        YearSelectorView(birthYear: .constant(0), showYearSelector: .constant(true))
    }
}
