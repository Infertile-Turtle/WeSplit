//
//  ContentView.swift
//  WeSplit
//
//  Created by Andrew Fairchild on 2/11/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let currFormatter: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier  ?? "USD")
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage) / 100
        
        let grandTotal = checkAmount * (1 + tipSelection)
        
        return grandTotal / peopleCount
    }
    
    var grandTotal: Double {
        let tipSelection = Double(tipPercentage) / 100
        
        return checkAmount * (1 + tipSelection)
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: currFormatter)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) { number in
                            Text("\(number) of people")
                        }
                    }
                }
                Section {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0..<101) { number in
                            Text(number, format: .percent)
                        }
                    }
                } header: {
                    Text("How much tip do you want to leave?")
                }
                Section {
                    Text(totalPerPerson, format: currFormatter)
                } header: {
                    Text("Total Cost per Person")
                }
                Section {
                    Text(grandTotal, format: currFormatter)
                } header: {
                    Text("Total Bill Cost with Tip")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()

                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
