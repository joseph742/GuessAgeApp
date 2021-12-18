//
//  UserView.swift
//  GuessAgeApp
//
//  Created by Joseph Umoru on 29/11/2021.
//

import SwiftUI
import Combine

struct UserView: View {
    @ObservedObject var viewModel: UserViewModel
    
    init(viewModel: UserViewModel) {
        UITableView.appearance().backgroundColor = UIColor(Color(hex: "D11149"))
        self.viewModel = viewModel
    }
    var body: some View {
        VStack {
            
            if let users = viewModel.users?.data {
                List(users) { user in
                    UserRowView(user: user)
                }
            } else {
                Text("Unable to get data from the server")
                    .font(.title2)
                    .fontWeight(.medium)
            }
        }
        .navigationBarTitle("Accurate guesses", displayMode: .inline)
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(viewModel: UserViewModel())
    }
}
