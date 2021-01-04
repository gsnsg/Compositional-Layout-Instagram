//
//  JSONViewModel.swift
//  Compositional Layout Demo (iOS)
//
//  Created by Sai Nikhit Gulla on 04/01/21.
//

import SwiftUI
import Combine


final class JSONViewModel: ObservableObject {
    @Published var cards: [Card] = []
    
    @Published var searchText: String = ""
    
    @Published var compositionalLayout: [[Card]] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.fetchCards()
    }
    
    
    func fetchCards() {
        let url = URL(string: "https://picsum.photos/v2/list?page=2&limit=100")!
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response)  in
                guard let httpResponse = response  as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Card].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }) { cards in
                self.cards = cards
                self.setupCompositionalLayout()
            }.store(in: &cancellables)
    }
    
    func setupCompositionalLayout() {
        
        var currentCardsArray:[Card] = []
        
        cards.forEach{ card in
            currentCardsArray.append(card)
            if currentCardsArray.count == 3 {
                self.compositionalLayout.append(currentCardsArray)
                currentCardsArray.removeAll()
            } else if card.id == cards.last!.id {
                self.compositionalLayout.append(currentCardsArray)
                currentCardsArray.removeAll()
            }
        }
    }
    
}
