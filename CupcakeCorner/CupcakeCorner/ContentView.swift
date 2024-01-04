//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Bruce Wang on 2023/12/31.
//

import SwiftUI
import CoreHaptics

struct ContentView: View {
    @State private var order = Order()
    @State private var counter = 0
    @State private var counter1 = 0
    @State private var counter2 = 0
    
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        
                NavigationStack {

                    Form {
                        Section {
                            Picker("Select your cake type", selection: $order.type) {
                                ForEach(Order.types.indices, id: \.self) {
                                    Text(Order.types[$0])
                                }
                            }
                            Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                        }
        
                        Section {
                            Toggle("Any special requests?", isOn: $order.specialRequestEnabled)
        
                            if order.specialRequestEnabled {
                                Toggle("Add extra frosting", isOn: $order.extraFrosting)
                                Toggle("Add extra", isOn: $order.addSprinkles)
                            }
                        }
        
                        Section {
                            NavigationLink("Cupcake corner") {
                                AddressView(order: order)
                            }
                        }
                    }
                }
                .onAppear {
//                    if let tmpname = UserDefaults.standard.string(forKey: "name") {
//                        name = tmpname
//                    }
                }
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func complexSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()
        
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }
        
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
            events.append(event)
        }
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("failed to play pattern: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}
