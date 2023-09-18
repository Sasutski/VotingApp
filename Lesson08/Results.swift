//
//  Results.swift
//  Lesson08
//
//  Created by Sasutski on 29/8/23.
//

import SwiftUI

struct Results: View {
    @ObservedObject var candidateManager: CandidateManager

    var body: some View {
        List {
            ForEach(candidateManager.candidatesForVoting, id: \.self) { candidate in
                HStack {
                    Text(candidate.name)
                    Spacer()
                    Text("Votes: \(candidateManager.candidateVotes[candidate, default: 0])")
                }
            }
        }
        .navigationBarTitle("Results")
    }
}

struct Results_Previews: PreviewProvider {
    static var previews: some View {
        let candidateManager = CandidateManager()
        Results(candidateManager: candidateManager)
    }
}
