//
//  Home.swift
//  Compositional Layout Demo (iOS)
//
//  Created by Sai Nikhit Gulla on 04/01/21.
//

import SwiftUI

struct Home: View {
    @StateObject var jsonViewModel = JSONViewModel()
    var body: some View {
        
        VStack{
            HStack {
                HStack{
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    TextField("Search", text: $jsonViewModel.searchText)
                }
                .padding(.vertical,10)
                .padding(.horizontal)
                .background(Color.primary.opacity(0.06))
                .cornerRadius(10)
                
                Button(action: {}, label: {
                    
                    Image(systemName: "qrcode.viewfinder")
                        .font(.system(size: 30))
                        .foregroundColor(.primary)
                })
            }
            .padding()
            
            if jsonViewModel.cards.isEmpty{
                
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            else {
                
                ScrollView{
                    
                    VStack(spacing: 4){
                        
                        ForEach(jsonViewModel.compositionalLayout.indices,id: \.self){index in


                            if index == 0 || index % 6 == 0{

                                Layout1(cards: jsonViewModel.compositionalLayout[index])
                            }
                            else if index % 3 == 0{

                                Layout3(cards: jsonViewModel.compositionalLayout[index])
                            }
                            else{

                                Layout2(cards: jsonViewModel.compositionalLayout[index])
                            }
                        }
                    }
                    .padding(.horizontal)
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
