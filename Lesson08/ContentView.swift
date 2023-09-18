//
//  ContentView.swift
//  Lesson08
//
//  Created by Sasutski on 29/8/23.
//

import SwiftUI

class CandidateManager: ObservableObject {
    @Published var candidatesForVoting: [Candidates] = []
    @Published var candidateVotes: [Candidates: Int] = [:]

    init() {
        for candidate in candidatesForVoting {
            candidateVotes[candidate] = 0
        }
    }
}


struct ContentView: View {
    @StateObject private var candidateManager = CandidateManager()

    var body: some View {
        TabView {
            CandidateView(candidateManager: candidateManager, candidatesForVoting: [Candidates(name: "Ezekel", age: 14, specialities: "Samuel", scandals: 0)])
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Candidates")
                }
            
            Vote(candidateManager: candidateManager, candidatesForVoting: [Candidates(name: "Ezekel", age: 14, specialities: "Samuel", scandals: 0)])
                .tabItem {
                    Image(systemName: "folder.fill")
                    Text("Vote")
                }
            Results(candidateManager: candidateManager)
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Results")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
