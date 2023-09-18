//
//  CandidateView.swift
//  Lesson08
//
//  Created by Sasutski on 29/8/23.
//

import SwiftUI



struct CandidateView: View {
    @ObservedObject var candidateManager: CandidateManager
    @State var candidatesForVoting: [Candidates]
    @State private var isAddingCandidate = false
    @State private var newCandidateName = ""
    @State private var newCandidateAge = ""
    @State private var newCandidateSpecialities = ""
    @State private var newCandidateScandals = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(candidateManager.candidatesForVoting.indices, id: \.self) { index in
                    NavigationLink(destination: DetailView(candidate: $candidateManager.candidatesForVoting[index])) {
                        VStack {
                            HStack {
                                Text(candidateManager.candidatesForVoting[index].name)
                                Spacer()
                            }
                            Divider()
                            HStack {
                                VStack {
                                    Text("\(candidateManager.candidatesForVoting[index].age)")  // Corrected line
                                    Text(candidateManager.candidatesForVoting[index].specialities)  // Corrected line
                                    Text("\(candidateManager.candidatesForVoting[index].scandals)")  // Corrected line
                                }
                                .foregroundColor(.gray)
                                Spacer()
                            }
                        }
                    }
                }
                .onDelete(perform: removeCandidate)
                .onMove(perform: moveCandidates)
            }
            .navigationBarTitle("Voting App")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isAddingCandidate = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddingCandidate) {
                NavigationView {
                    VStack {
                        TextField("Candidate Name", text: $newCandidateName)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Candidate Age", text: $newCandidateAge)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Candidate Specialities", text: $newCandidateSpecialities)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Candidate Scandels", text: $newCandidateScandals)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button("Add") {
                            candidateManager.candidatesForVoting.append(Candidates(name: newCandidateName, age: Int(newCandidateAge) ?? 0, specialities: newCandidateSpecialities , scandals: Int(newCandidateScandals) ?? 0))
                            isAddingCandidate = false
                            newCandidateName = ""
                            newCandidateAge = ""
                            newCandidateSpecialities = ""
                            newCandidateScandals = ""
                            isAddingCandidate = false
                        }
                        .padding()
                        .disabled(newCandidateName.isEmpty)
                    }
                    .navigationBarTitle("Add Candidate")
                    .navigationBarItems(trailing: Button("Cancel") {
                        isAddingCandidate = false
                    })
                }
            }
        }
    }
    func removeCandidate(atOffsets offsets: IndexSet) {
        for offset in offsets {
            if let candidate = candidatesForVoting[safe: offset] {
                // Remove the candidate from the actual candidate list
                if let indexToRemove = candidateManager.candidatesForVoting.firstIndex(of: candidate) {
                    candidateManager.candidatesForVoting.remove(at: indexToRemove)
                }
            }
        }
    }
    func moveCandidates(from source: IndexSet, to destination: Int) {
        candidatesForVoting.move(fromOffsets: source, toOffset: destination)
    }
}

struct CandidateView_Previews: PreviewProvider {
    static var previews: some View {
        let candidateManager = CandidateManager()
        CandidateView(candidateManager: candidateManager, candidatesForVoting: [Candidates(name: "Ezekel", age: 14, specialities: "Samuel", scandals: 0)])
    }
}
