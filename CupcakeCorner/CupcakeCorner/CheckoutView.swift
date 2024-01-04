//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Bruce Wang on 2024/1/3.
//

import SwiftUI

struct Test: Codable {
    var name: String
    var type: String
}

struct CheckoutView: View {
    var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height:233)
                
                Text("Your total lcost is \(order.cost, format: .currency(code: "RMB"))")
                    .font(.headline)
                    .padding()
                
                Button("Place Order", action: {
                    Task {
                        await placeOrder()
                    }
                })
            }
        }
        .scrollBounceBehavior(.basedOnSize)
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
        .alert("Sorry!", isPresented: $showingError) {
            Button("OK") { }
        } message: {
            Text(errorMessage)
        }
        .onAppear {
            let test =  Test(name: "abc", type: "Best")
            if let encoded = try? JSONEncoder().encode(test) {
                print(String(decoding: encoded, as: UTF8.self))
            }
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        request.httpMethod = "POST"
        request.timeoutInterval = 5
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity) x \(Order.types[decodedOrder.type]) is on its way!"
            showingConfirmation = true
        } catch {
            errorMessage = error.localizedDescription
            showingError = true
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
