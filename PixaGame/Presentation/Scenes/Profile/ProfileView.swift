//
//  ProfileView.swift
//  PixaGame
//
//  Created by Didik on 14/07/20.
//  Copyright © 2020 Codingtive. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            List {
                HStack(alignment: .top) {
                    Image("ic_profile")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .cornerRadius(12)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Didik Maulana Ardiansyah")
                            .font(Font.system(size: 24))
                            .fontWeight(.bold)
                        
                        Text("Mobile Engineer")
                            .font(Font.system(size: 18))
                            .foregroundColor(Color.black.opacity(0.8))
                    }
                    .padding(.top, 6)
                    .padding(.leading, 8)
                }
                .listRowInsets(EdgeInsets(top: 24, leading: 16, bottom: 16, trailing: 16))
                
                VStack(alignment: .leading, spacing: 16) {
                    ProfileInformationView(iconName: "ic_location", description: "Yogyakarta, Indonesia")
                    ProfileInformationView(iconName: "ic_email", description: "didikmaulana49@gmail.com")
                    ProfileInformationView(iconName: "ic_link", description: "www.codingtive.com")
                    ProfileInformationView(iconName: "ic_github", description: "@didik-maulana")
                }
                .listRowInsets(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
            }
            .navigationBarTitle("Profile", displayMode: .inline)
        }
    }
}

struct ProfileInformationView: View {
    let iconName: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(iconName)
                .resizable()
                .frame(width: 20, height: 20)
            
            Text(description)
                .font(Font.system(size: 16))
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    
    static var previews: some View {
        ProfileView()
    }
}
