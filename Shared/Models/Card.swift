//
//  Card.swift
//  Compositional Layout Demo (iOS)
//
//  Created by Sai Nikhit Gulla on 04/01/21.
//

import Foundation


struct Card: Decodable, Identifiable, Hashable {
    var id: String
    var download_url: String
    var author: String
}
