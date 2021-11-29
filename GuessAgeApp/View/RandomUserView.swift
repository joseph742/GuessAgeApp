//
//  RandomUserView.swift
//  GuessAgeApp
//
//  Created by Qasim Ahmed on 27/11/2021.
//

import SwiftUI

struct RandomUserView: View {
    
    @ObservedObject var viewModel: RandomUserViewModel
    @State var selectedDate = Date()
    
    init(viewModel: RandomUserViewModel) {
        self.viewModel = viewModel
    }
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(hex: "D11149")
                    .ignoresSafeArea()
                
                VStack {
                    VStack(spacing: 20) {
                        if let result = viewModel.randomUserData?.results, let imageURl = URL(string: result[0].picture.large) {
                            HStack {
                                Spacer()
                                AsyncImage(url: imageURl) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(maxWidth: 200, maxHeight: 200)
                                            .clipShape(Circle())
                                            .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                                        
                                    case .failure:
                                        Image(systemName: "person.crop.circle")
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                Spacer()
                            }
                            
                            VStack {
                                HStack {
                                    Text(result[0].name.title)
                                        .font(.title2)
                                        .fontWeight(.medium)
                                    Text(result[0].name.first)
                                        .font(.title2)
                                        .fontWeight(.medium)
                                    Text(result[0].name.last)
                                        .font(.title2)
                                        .fontWeight(.medium)
                                }
                                
                                Text(result[0].location.country)
                                    .font(.title2)
                                    .fontWeight(.medium)
                                if result[0].gender == "male" {
                                    Text("Can you guess his birth year?")
                                        .font(.title2)
                                        .fontWeight(.medium)
                                } else {
                                    Text("Can you guess her birth year?")
                                        .font(.title2)
                                        .fontWeight(.medium)
                                }

                                
                            }
                            
                            Button {
                                withAnimation(.easeIn) {
                                    viewModel.showYearSelector = true
                                }
                            } label: {
                                Text("Select age")
                                    .font(.title2)
                                    .fontWeight(.medium)
                            }
                            .foregroundColor(.white)
                            .padding(.vertical, 5)
                            .padding(.horizontal)
                            .background(Capsule().fill(Color(hex: "3ABEFF")))
                            
                        } else {
                            
                            
                            Text("Unable to get data from the server")
                                .font(.title2)
                                .fontWeight(.medium)
                        }
                        
                        Button {
                            viewModel.fetchRandomUser()
                        } label: {
                            Image(systemName: "arrow.triangle.2.circlepath.circle")
                                .font(.largeTitle)
                        }

                        

                    }
                    .padding()
                    .background(Color(hex: "FFFFB3"))
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 20)
                    
                    Spacer()
                }
                .padding()
                
                
                YearSelectorView(birthYear: $viewModel.birthYear, showYearSelector: $viewModel.showYearSelector)
                    .opacity(viewModel.showYearSelector ? 1 : 0)
                
                SuccessOrFailureView(showSuccessOrFailureView: $viewModel.showSuccessOrFailureView, sucessOrFailure: $viewModel.successOrFailure, message: $viewModel.message)
                    .opacity(viewModel.showSuccessOrFailureView ? 1 : 0)
            }
            .navigationTitle("Guess age")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                NavigationLink(destination: UserView(viewModel: UserViewModel())) {
                    Image(systemName: "person.crop.rectangle.stack.fill")
                        .font(.title)
                        .foregroundColor(Color(hex: "FFFFB3"))
                }

            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct RandomUserView_Previews: PreviewProvider {
    static var previews: some View {
        RandomUserView(viewModel: RandomUserViewModel())
    }
}
