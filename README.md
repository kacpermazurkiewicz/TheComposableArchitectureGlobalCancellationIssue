# TheComposableArchitectureGlobalCancellationIssue

# Repository details

An example code with the found issue in The Composable Architecture regarding the long-living effects cancellation.

For the long-running effects where we set the cancellable id to eg. `CancelID.self` where: `enum CancelID: Hashable {}` and then call a canceling effect like `.cancel(id: CancelID.self)`  the cancellation is global, not local for the store from within it was called.

# Short code introduction
In the example code we instantiate two stores - `store1: StoreOf<ExampleComponent>` and `store2: StoreOf<ExampleComponent>` with the environment publisher which allows publishing a boolean value. The `subscribeToLongTimeEffect` action in the `StoreOf<ExampleComponent>` reducer allows for listening to those changes by initializing the long-running effect with the cancellable id - `.cancellable(id: CancelId.self)`.

The `.cancelLongTimeEffect` runs the cancel Effect with the same id.

# The issue
The first button implemented in the ContentView - as an action sends the `.cancelLongTimeEffect` to the `store1`. However, as you may notice both `store1` and `store2` will cancel respectively their long-living effects, even though they are initialized as completely separate components (you may notice that the print statement in the `subscribeToLongTimeEffect` is being called twice). 

So after the first button is tapped - the remaining two buttons which allowed previously for switching the states of `store1` and `store2` stops receiving the data in the long-living effect returned in the  `subscribeToLongTimeEffect` reducer's action.
