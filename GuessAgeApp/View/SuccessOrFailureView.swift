//
//  SuccessOrFailureView.swift
//  GuessAgeApp
//
//  Created by Qasim Ahmed on 28/11/2021.
//

import SwiftUI

struct SuccessOrFailureView: View {
    @Binding var showSuccessOrFailureView: Bool
    @Binding var sucessOrFailure: Bool
    @Binding var message: String
    
    var body: some View {
        ZStack {
            Color(.black)
                .opacity(0.4)
                .ignoresSafeArea()
            
            VStack {
                VStack {
                    VStack(spacing: 20) {
                        if sucessOrFailure {
                            Image(systemName: "checkmark.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 200, maxHeight: 200)
                                .foregroundColor(.green)
                                .clipShape(Circle())
                            
                        } else {
                            Image(systemName: "xmark.octagon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 200, maxHeight: 200)
                                .foregroundColor(.red)
                                .clipShape(Circle())
                        }

                        
                    }
                    .frame(height: 200)

                }
                .padding()
                .frame(width: 200)
                .background(Color(.secondarySystemBackground))
                .clipShape(Circle())
            .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 20)
                
                VStack {
                    Text(message)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Button {
                        withAnimation(.easeIn) {
                            showSuccessOrFailureView = false
                        }
                    } label: {
                        Text("Done")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    .padding()

                }
                .padding()
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 20)
            }
            
        }
    }
}

struct SuccessOrFailureView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessOrFailureView(showSuccessOrFailureView: .constant(false), sucessOrFailure: .constant(true), message: .constant("Date of Birth"))
    }
}
