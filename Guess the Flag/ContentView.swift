//
//  ContentView.swift
//  Guess the Flag
//
//  Created by Rob McBryde on 23/01/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "USA"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var showingGameOver = false
    @State private var scoreTitle = ""
    
    @State private var score = 0
    @State private var turnCount = 0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [.init(color: Color(red: 29/255, green: 59/255, blue: 90/255), location: 0.3),
                                   .init(color: Color(red: 255/255, green: 58/255, blue: 58/255), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                        
                    }
                    
                    ForEach(0..<3) { number in
                        Button{
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.buttonBorder)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(20)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert("Final Score", isPresented: $showingGameOver) {
            Button("Play again?", action: resetGame)
        } message: {
            Text("You're final score is: \(score)")
        }
    }
    
    private func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
            score -= 1
        }
        showingScore = true
        
    }
    
    private func askQuestion() {
        turnCount += 1
        if turnCount >= 6 {
            showingGameOver = true
        } else {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
    }
    
    private func resetGame() {
        turnCount = 0
        showingGameOver = false
        score = 0
        scoreTitle = ""
        askQuestion()
    }
}


#Preview {
    ContentView()
}
