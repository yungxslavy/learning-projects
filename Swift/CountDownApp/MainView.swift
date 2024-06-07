//
//  ContentView.swift
//  Countdown
//
//  Created by Tomislav Vuckovic on 6/4/24.
//

import SwiftUI

struct MainView: View {
    @State private var counterAmount = 0
    @State private var selectedMinute = 0
    @State private var selectedSecond = 0
    @State private var timer: Timer? = nil
    
    @State private var buttonColor = Color.green
    @State private var buttonText = "Start"
        
    var body: some View {
        VStack (spacing: 30) {
            HStack(spacing: 0) {
                getClockText()
                    .fontWeight(.light)
                    .font(.system(size: 52, weight: .none))
                    .padding(10)
            }
            
            DurationSelectView(selectedMinute: $selectedMinute, selectedSecond: $selectedSecond,
                title: "Select Duration:")
            
            Button(action: { 
                if timer == nil  {
                    startDecrementing()
                }
                else {
                    stopDecrementing()
                }
            }) {
                Text("\(buttonText)")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(buttonColor)
                    .cornerRadius(10)
                    .shadow(radius: 10)
            }
        }
        .padding()
        .onChange(of: selectedMinute) {
            updateCounterAmount()
        }
        .onChange(of: selectedSecond) {
            updateCounterAmount()
        }
    }
    
    private func updateCounterAmount() {
        counterAmount = (selectedMinute * 60) + selectedSecond
    }
    
    func startDecrementing() {
        // Give user response
        if self.counterAmount > 0 {
            self.buttonColor = Color.red
            self.buttonText = "Stop"
        }
        
        // Begin decrement logic
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.counterAmount > 0 {
                self.counterAmount -= 1
            } else {
                stopDecrementing()
            }
        }
    }
    
    func stopDecrementing() {
        // Invalidate timer to reset
        timer?.invalidate()
        timer = nil
        
        // Give response to user
        self.buttonColor = Color.green
        self.buttonText = "Start"
    }
    
    func getClockText() -> Text{
        let min = self.counterAmount / 60
        let sec = self.counterAmount % 60
        
        return Text(String(format: "%02d:%02d", min, sec))    }
}

#Preview {
    MainView()
}
