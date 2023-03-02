//
//  ContentView.swift
//  HighRollers
//
//  Created by Edwin Przeźwiecki Jr. on 01/03/2023.
//

import SwiftUI

struct ContentView: View {
    
    let dice = Dice(amount: 1, type: 6)
    
    @State private var amount = 6
    @State private var type = 4
    @State private var rolled = 0
    
    var types: [Int] {
        return stride(from: 4, to: 101, by: 2).map { $0 }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Settings:") {
                    Picker("Amount of dice:", selection: $amount) {
                        ForEach(0..<7) { num in
                            Text("\(num)")
                        }
                    }
                    .pickerStyle(.menu)
                    
                    Picker("Type of dice:", selection: $type) {
                        ForEach(types, id: \.self) { num in
                            Text("\(num)-sided")
                        }
                    }
                }
                
                Section("Dice:") {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 50) {
                            ForEach(1...amount, id: \.self) { amount in
                                GeometryReader { geo in
                                    Text("\(amount)")
                                        .font(.largeTitle)
                                    //                                    .rotation3DEffect(.degrees(geo.frame(in: .local).minX), axis: (x: 0, y: 1, z: 0))
                                        .frame(width: 50, height: 50)
                                        .background(.gray)
                                }
                                .frame(width: .infinity, height: 50)
                            }
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
                
                Section("Rolled:") {
                    Text(String(rolled))
                        .font(.largeTitle)
                }
            }
            .navigationTitle("HighRollers")
        }
    }
    
    func rollDice() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
