//
//  UserRowView.swift
//  GuessAgeApp
//
//  Created by Qasim Ahmed on 29/11/2021.
//

import SwiftUI

struct UserRowView: View {
    var user: Datum
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 20) {
                HStack(alignment: .lastTextBaseline, spacing: 20) {
                    
                    AsyncImage(url: URL(string: user.picture)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 100, maxHeight: 100)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                            
                        case .failure:
                            Image(systemName: "person.crop.circle")
                        @unknown default:
                            EmptyView()
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text(user.title.rawValue)
                            .font(.title2)
                            .fontWeight(.medium)
                        Text(user.firstName)
                            .font(.title2)
                            .fontWeight(.medium)
                        Text(user.lastName)
                            .font(.title2)
                            .fontWeight(.medium)
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

struct UserRowView_Previews: PreviewProvider {
    static var previews: some View {
        UserRowView(user: Datum(id: "123", title: Title.mr, firstName: "gilgamies", lastName: "suboolo", picture: "https://randomuser.me/api/portraits/med/women/8.jpg"))
    }
}
