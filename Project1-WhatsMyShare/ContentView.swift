//
//  ContentView.swift
//  Project1-WhatsMyShare
//
//  Created by suhail on 06/02/24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 15
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [0,10,15,20,25]
    var grandTotal: Double{
        let tipAmount = Double(tipPercentage)/100 * checkAmount
        return checkAmount + tipAmount
    }
    
    var totalPerPerson: Double{
        let peopleCount = Double(numberOfPeople+2)
        return grandTotal / peopleCount
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    
                    TextField("Enter the amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "INR"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people :", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("How much do you want to tip?"){
                    Picker("Tip Percentages", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                    
//                    Picker("Tip Percentages", selection: $tipPercentage){
//                        ForEach(0..<100){
//                            Text($0, format: .percent)
//                        }
//                    }
//                    .pickerStyle(.navigationLink)
                }
                
                Section("Total Amount"){
                    
                    Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "INR"))
                        .background(tipPercentage == 0 ? .red : .white)
                    
                }
                
                
                Section("Total per person :"){
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "INR"))
                }
            }.navigationTitle("What's My Share")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                if amountIsFocused{
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
        }
        
    }
}
#Preview {
    ContentView()
}
