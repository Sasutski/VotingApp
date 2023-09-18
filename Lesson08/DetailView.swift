//
//  DetailView.swift
//  Lesson08
//
//  Created by Sasutski on 29/8/23.
//

import SwiftUI

struct DetailView: View {
    @Binding var candidate: Candidates
    
    var body: some View {
        VStack {
            TextField("Candidate Name", text: $candidate.name)
            Stepper {
                Text("Candidate Age: \(candidate.age)")
            } onIncrement: {
                candidate.age += 1
            } onDecrement: {
                if candidate.age > 0 {
                    candidate.age -= 1
                }
            }
            TextField("Candidate Specialities", text: $candidate.specialities)
            Stepper {
                Text("Candidate Scandals: \(candidate.scandals)")
            } onIncrement: {
                candidate.scandals += 1
            } onDecrement: {
                if candidate.scandals > 0 {
                    candidate.scandals -= 1
                }
            }
        }
        .padding()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleCandidate = Candidates(name: "James", age: 14, specialities: "YOOOO SAMUEL", scandals: 0)
        DetailView(candidate: .constant(sampleCandidate))
    }
}
