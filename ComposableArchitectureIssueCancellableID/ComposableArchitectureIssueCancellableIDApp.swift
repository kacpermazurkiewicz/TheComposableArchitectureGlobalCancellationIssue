//
//  ComposableArchitectureIssueCancellableIDApp.swift
//  ComposableArchitectureIssueCancellableID
//
//  Created by mazurkk3 on 21/03/2023.
//

import SwiftUI
import ComposableArchitecture
import Combine

@main
struct ComposableArchitectureIssueCancellableIDApp: App {
    let store1: StoreOf<ExampleComponent>
    let store2: StoreOf<ExampleComponent>
    
    init() {
        self.store1 = .init(
            initialState: .init(state: false),
            reducer: ExampleComponent.init(longtimeEffect: firstLongTimePublisher)
        )
        self.store2 = .init(
            initialState: .init(state: false),
            reducer: ExampleComponent.init(longtimeEffect: secondLongTimePublisher)
        )
    }
    
    let firstLongTimePublisher: CurrentValueSubject<Bool, Never> = .init(false)
    let secondLongTimePublisher: CurrentValueSubject<Bool, Never> = .init(false)

    var body: some Scene {
        WindowGroup {
            ContentView(
                firstLongTimePublisher: firstLongTimePublisher, secondLongTimePublisher: secondLongTimePublisher,
                store: store1,
                store2: store2
            )
            .onAppear {
                ViewStore(store1).send(.subscribeToLongTimeEffect)
                ViewStore(store2).send(.subscribeToLongTimeEffect)
            }
        }
    }
}
