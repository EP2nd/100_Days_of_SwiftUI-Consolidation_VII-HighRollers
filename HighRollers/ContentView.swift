//
//  ContentView.swift
//  HighRollers
//
//  Created by Edwin Przeźwiecki Jr. on 01/03/2023.
//

import CoreHaptics
import SwiftUI

struct ContentView: View {
    
    @State private var scores = [Score]()
    
    @AppStorage("selectedDiceAmount") private var amountOfDice = 5
    @AppStorage("selectedDieType") private var dieType = 4
    
    var dieTypes: [Int] {
        stride(from: 4, to: 102, by: 2).map { $0 }
    }
    
    @State var dieValues: [Int]
    
    @State private var score = 0
    
    @State private var timer = Timer.publish(every: 0.1, tolerance: 0.1, on: .main, in: .common).autoconnect()
    @State private var isTimerActive = false
    @State private var counter = 0
    
    @State private var feedback = UIImpactFeedbackGenerator(style: .heavy)
    
    var body: some View {
        NavigationView {
            Form {
                Section("Settings:") {
                    Picker("Amount of dice:", selection: $amountOfDice) {
                        ForEach(0..<7) { num in
                            Text("\(num)")
                        }
                    }
                    
                    Picker("Die type:", selection: $dieType) {
                        ForEach(dieTypes, id: \.self) {
                            Text("\($0)-sided")
                        }
                    }
                }
                
                Section("Dice:") {
                    HStack(spacing: 50) {
                        ForEach(dieValues, id: \.self) { value in
                            GeometryReader { _ in
                                Text(String(value))
                                    .font(.callout)
                                    .frame(width: 50, height: 50)
                                    .background(.gray)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .shadow(radius: 3)
                            }
                            .frame(width: 10, height: 50)
                            .accessibilityLabel("Dice with value \(value).")
                        }
                    }
                }
                
                Button {
                    rollDice()
                } label: {
                    Spacer()
                    
                    Text("Roll!")
                    
                    Spacer()
                }
                .buttonStyle(.borderedProminent)
                .disabled(amountOfDice == 0)
                
                Section {
                    Text(String(score))
                        .font(.largeTitle)
                        .accessibilityLabel("You rolled \(score) in total.")
                } header: {
                    Text("\"The die is cast\":")
                        .accessibilityLabel("The total rolled on the dice:")
                }
                
                if scores.isEmpty == false {
                    Section("Highest scores:") {
                        ForEach(scores.sorted()) { score in
                            Text("\(score.record)")
                        }
                    }
                }
            }
            .navigationTitle("HighRollers")
        }
        .onAppear {
            scores = DataManager.load()
        }
        .onReceive(timer) { time in
            guard isTimerActive == true else { return }
            
            if counter == 30 {
                timer.upstream.connect().cancel()
                isTimerActive = false
                calculateScore()
                saveScore()
            } else {
                withAnimation(.easeInOut.speed(1.0)) {
                    generateDieValues()
                    feedback.impactOccurred()
                }
            }
            
            counter += 1
        }
    }
    
    func rollDice() {
        counter = 0
        isTimerActive = true
        timer = Timer.publish(every: 0.1, tolerance: 0.1, on: .main, in: .common).autoconnect()
    }
    
    func generateDieValues()  {
        dieValues.removeAll()
        
        Array(1...amountOfDice).forEach { _ in
            dieValues.append(Int.random(in: 1...dieType))
        }
    }
    
    func calculateScore() {
        score = dieValues.reduce(0, +)
    }
    
    func saveScore() {
        let score = Score(record: score)
        scores.append(score)
        DataManager.save(data: scores)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(dieValues: [])
    }
}
