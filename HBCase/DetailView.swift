//
//  DetailView.swift
//  HBCase
//
//  Created by Recep on 29.04.2022.
//

import SwiftUI

struct DetailView: View {
    var object: Result
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: "\(object.artworkUrl100)"))
            Text(object.trackName)
                .font(.headline)
            Text(object.collectionName)
            Spacer()
        }.padding()
    }
}
