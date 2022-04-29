//
//  ModelView.swift
//  HBCase
//
//  Created by Recep on 29.04.2022.
//

import Foundation

class ModelView : ObservableObject {

    @Published var results : [Result]?
    
    func getPageData(searchText: String,selected: String) async  -> [Result] {
        guard let url = URL(string: "https://itunes.apple.com/search?term=\(searchText)&entity=\(selected)&limit=20&offset=0") else {
            print("Invalid URL")
            return []
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
            }else{
                
                }
            // more code to come
        } catch {
          
        }
        return results ?? []
    }
    func updateAll(){
        results?.removeAll()
    }
}
