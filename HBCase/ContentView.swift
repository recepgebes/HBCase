//
//  ContentView.swift
//  HBCase
//
//  Created by Recep on 25.04.2022.
//

import SwiftUI

struct ContentView: View {
    var mediaTypes = ["Movies" ,"Music", "Ebook", "Podcast"]
    @State var searchText: String = ""
    @State var selected = WrapperType.podcast.rawValue
    @StateObject   var modelView = ModelView()
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer().frame(width:8)
                    TextField("Search ...", text: $searchText)
                                   .padding(7)
                                   .padding(.horizontal, 25)
                                   .background(Color(.systemGray6))
                                   .cornerRadius(8)
                                   .padding(.horizontal, 10)
                                   .onChange(of: searchText) { newValue in
                                       callme()
                                   }
                                   .frame(height: 80)
                                   .overlay(
                                       HStack {
                                           Spacer().frame(width:8)
                                           Image(systemName: "magnifyingglass")
                                               .foregroundColor(.gray)
                                               .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                               .padding(.leading, 8)
                                    
                                           if !searchText.isEmpty {
                                               Button(action: {
                                                   self.searchText = ""
                                               }) {
                                                   Image(systemName: "multiply.circle.fill")
                                                       .foregroundColor(.gray)
                                                       .padding(.trailing, 8)
                                               }
                                           }
                                           Spacer().frame(width:8)
                                       }
                                   )
                    Spacer().frame(width: 8)
                }
                HStack {
                    Spacer().frame(width:18)
                    ControlGroup {
                        Button(action: {
                            selected = WrapperType.movie.rawValue
                            callme()
                        }) {
                            Text(mediaTypes[0])
                        }
                        Button(action: {
                            selected = WrapperType.music.rawValue
                            callme()
                        }) {
                            Text(mediaTypes[1])
                        }
                        Button(action: {
                            selected = WrapperType.ebook.rawValue
                            callme()
                        }) {
                            Text(mediaTypes[2])
                        }
                        Button(action: {
                            selected = WrapperType.podcast.rawValue
                            callme()
                        }) {
                            Text(mediaTypes[3])
                        }
                    }
                    Spacer().frame(width:18)
                }
                
                
                HStack() {
                    List(modelView.results ?? [], id: \.trackId) { item in
                        NavigationLink(
                            destination: DetailView(object: item)) {
                                VStack(alignment: .leading) {
                                    AsyncImage(url: URL(string: "\(item.artworkUrl100)"))
                                    Text(item.trackName)
                                        .font(.headline)
                                    Text(item.collectionName)
                                }
                            }
                        
                    }.listStyle(PlainListStyle())
                        .refreshable {
                             callme()
                        }
                }
            }
            .navigationBarHidden(true)
        }
    }
    func callme() {
        modelView.updateAll()
        if searchText.count > 1 {
            Task {
                await modelView.getPageData(searchText: searchText, selected: selected)
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

