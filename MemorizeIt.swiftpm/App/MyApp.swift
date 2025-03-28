import SwiftUI
import SwiftData

@main
struct MyApp: App {
    var modelContainer = ModelContainerHelper.create()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(modelContainer)
    }
}
