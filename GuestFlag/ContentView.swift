//
//  ContentView.swift
//  GuestFlag
//
//  Created by Kaiyrzhan Kural on 07.07.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["argentina", "bangladesh", "brazil", "canada", "germany", "greece", "russia", "sweden", "uk", "usa"]
    @State private var chosenFlag = Int.random(in: 0...2)
    @State private var score = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.black, .white]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing: 30) {
                VStack {
                    Text("Choose correct flag:")
                        .foregroundColor(.white)
                    Text(countries[chosenFlag])
                        .foregroundColor(.white)
                        .fontWeight(.black)
                }
                ForEach(0..<3) { number in
                    Button(action: {
                        self.flagTapped(number: number)
                        self.showingScore = true
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .frame(width: 250, height: 125)
                            .clipShape(Capsule())
                            .overlay(Capsule()
                                .stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    }
                    
                }
                Text("Score: \(score)")
                    .fontWeight(.black)
                    .font(.largeTitle)
                
                Spacer()
            }
        }.alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Total score: \(score)"), dismissButton: .default(Text("Next")) {
                self.askQuestion()
            })
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        chosenFlag = Int.random(in: 0...2)
    }
    
    func flagTapped(number: Int) {
        if number == chosenFlag {
            scoreTitle = "Correct!"
            score += 1
        } else {
            scoreTitle = "Is not correct. Flag of \(countries[number])"
            score -= 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
