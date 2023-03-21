//
//  ContentView.swift
//  ComposableArchitectureIssueCancellableID
//
//  Created by mazurkk3 on 21/03/2023.
//

import SwiftUI
import ComposableArchitecture
import Combine

struct ContentView: View {
    let firstLongTimePublisher: CurrentValueSubject<Bool, Never>
    let secondLongTimePublisher: CurrentValueSubject<Bool, Never>
    
    let store: StoreOf<ExampleComponent>
    let store2: StoreOf<ExampleComponent>
    
    var body: some View {
        VStack {
            Button {
                ViewStore(store).send(.cancelLongTimeEffect)
            } label: {
                Text("Press to cancel subscription")
            }

            WithViewStore(store) { viewStore in
                Button {
                    firstLongTimePublisher.send(!viewStore.state.state)
                } label: {
                    Text("First state \(viewStore.state.state.description) change")
                }
            }
            
            
            WithViewStore(store2) { viewStore in
                Button {
                    secondLongTimePublisher.send(!viewStore.state.state)
                } label: {
                    Text("Second state \(viewStore.state.state.description) change")
                }
            }
        }
        .padding()
    }
}
