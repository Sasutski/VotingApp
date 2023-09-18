//
//  Vote.swift
//  Lesson08
//
//  Created by Sasutski on 29/8/23.
//

import SwiftUI

struct Vote: View {
    @ObservedObject var candidateManager: CandidateManager
    @State var candidatesForVoting: [Candidates]
    @State private var selectedCandidateIndex = 0
    @State private var voteSliderValue = 0.0
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            Picker("Select Candidate", selection: $selectedCandidateIndex) {
                ForEach(candidateManager.candidatesForVoting.indices, id: \.self) { index in
                    Text(candidateManager.candidatesForVoting[index].name)
                }
            }
            .pickerStyle(MenuPickerStyle())
            
            Slider(value: $voteSliderValue, in: 0...10, step: 1) // Adjusted range and step
                            .padding()
            Text("Votes: \(Int(voteSliderValue))")
                            .font(.headline)
                            .foregroundColor(.blue)
            
            Button("Submit Vote") {
                if let candidate = candidateManager.candidatesForVoting[safe: selectedCandidateIndex] {
                    candidateManager.candidateVotes[candidate, default: 0] += Int(voteSliderValue)
                    showAlert = true
                }
            }
            .padding()
            .alert(isPresented: $showAlert) {
                if candidateManager.candidatesForVoting.indices.contains(selectedCandidateIndex) {
                    return Alert(
                        title: Text("Vote Submitted"),
                        message: Text("You have voted \(Int(voteSliderValue)) Votes for \(candidateManager.candidatesForVoting[selectedCandidateIndex].name)."),
                        dismissButton: .default(Text("OK"))
                    )
                } else {
                    return Alert(
                        title: Text("Vote Error"),
                        message: Text("An error occurred while processing your vote."),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
            
            Spacer()
        }
        .padding()
        .onChange(of: candidatesForVoting) { newValue in
            if !newValue.contains(candidatesForVoting[selectedCandidateIndex]) {
                selectedCandidateIndex = 0
            }
        }

    }
}



struct Vote_Previews: PreviewProvider {
    static var previews: some View {
        let candidateManager = CandidateManager()
        Vote(candidateManager: candidateManager, candidatesForVoting: [Candidates(name: "Ezekel", age: 14, specialities: "Samuel", scandals: 0)])
    }
}
