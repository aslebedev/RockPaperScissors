//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by alexander on 20.10.2019.
//  Copyright © 2019 alexander. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var offeredThing = Int.random(in: 0...2)
    @State private var offeredGameEnding = Bool.random()
    @State private var showingScore = false
    @State private var scores = 0
    @State private var tapCount = 0
    @State private var isCorrect = true
    @State private var showingAlert = ""
    
    let things = ["doc", "scissors", "cube"]
    var computedWidth: CGFloat {
        switch offeredThing {
        case 0, 2:
            return 90.0
        default:
            return 120.0
        }
    }

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.green, .blue]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack (spacing: 30) {
                
                VStack {
                    Text("Game picks:")
                    Image(systemName: things[offeredThing])
                        .resizable()
                        .frame(width: computedWidth, height: 90.0, alignment: .center)
                    HStack {
                        Text("and you must")
                        Text(offeredGameEnding ? "win" : "loose")
                            .fontWeight(.bold)
                    }
                        
                }
                .font(.title)
                
                Text("What your choice?")
                    .font(.title)
                
                ForEach(0..<things.count) { number in
                    Button( action: {
                            self.userMadeChoice(number)
                        }) {
                            Image(systemName: self.things[number])
                                .resizable()
                                .frame(width: number == 1 ? 120.0 : 90.0, height: 90.0, alignment: .center)
                    }
                }
                .foregroundColor(.white)
                
                VStack (spacing: 10) {
                    Text("Your scores: \(scores)")
                    
                    Text("GAME OVER")
                        .fontWeight(.black)
                        .opacity(tapCount >= 10 ? 1 : 0)
                }.font(.title)
                
                Spacer()
            }
        }.alert(isPresented: $showingScore) {
            Alert(title: Text(showingAlert), message: Text("Your score is \(scores)"), dismissButton: .default(Text("Continue")) {
                self.restartGame()
                } )
        }
    }
    
    func restartGame() {
        if tapCount >= 10 {
            return
        }
        
        offeredThing = Int.random(in: 0...2)
        offeredGameEnding = Bool.random()
    }
    
    func userMadeChoice(_ number: Int) {
        if number == offeredThing { return }
        
        if tapCount >= 10 {
            return
        }
        
        if offeredGameEnding {
            if (number > offeredThing && (number - offeredThing == 1)) || (offeredThing - number == 2) {
                isCorrect = true
                showingAlert = "Correct"
                scores += 1
            } else {
                isCorrect = false
                showingAlert = "Wrong"
                scores -= 1
            }
        } else {
            if (number < offeredThing && (offeredThing - number == 1)) || (number - offeredThing == 2) {
                isCorrect = true
                showingAlert = "Correct"
                scores += 1
            } else {
                isCorrect = false
                showingAlert = "Wrong"
                scores -= 1
            }
        }
        
        tapCount += 1
        if tapCount >= 10 {
            showingAlert = "GAME OVER"
        }
        showingScore = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


