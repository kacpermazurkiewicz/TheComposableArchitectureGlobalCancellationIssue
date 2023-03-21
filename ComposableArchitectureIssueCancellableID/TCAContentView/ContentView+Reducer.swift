//
//  ContentView+Reducer.swift
//  ComposableArchitectureIssueCancellableID
//
//  Created by mazurkk3 on 21/03/2023.
//

import Foundation
import ComposableArchitecture
import Combine

struct ExampleComponent: ReducerProtocol {
    let longtimeEffect: CurrentValueSubject<Bool, Never>
    
    struct State: Equatable {
        var state: Bool = false
    }
    
    enum Action: Equatable {
        case subscribeToLongTimeEffect
        case setState(Bool)
        case cancelLongTimeEffect
    }
    
    func reduce(into state: inout State, action: Action) -> ComposableArchitecture.EffectTask<Action> {
        enum CancelId: Hashable {}
        
        switch action {
        case .subscribeToLongTimeEffect:
            return longtimeEffect
                .handleEvents(receiveCancel: {
                    print("received cancel")
                })
                .eraseToEffect()
                .map(Action.setState)
                .cancellable(id: CancelId.self)
        case let .setState(newState):
            state.state = newState
            return .none
        case .cancelLongTimeEffect:
            return .cancel(id: CancelId.self)
        }
    }
}
