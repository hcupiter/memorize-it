import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject private var coordinator: AppCoordinator = .init()
    @StateObject private var fontManager = FontManager()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            VStack {
                VStack {
                    Text("Memo's Shop")
                        .font(fontManager.getFont(size: 40, fontWeight: .bold))
                        .padding(.top, 32)
                    Text("Train your cognitive brain with fun matching items game")
                        .font(fontManager.getFont(size: 32, fontWeight: .sans))
                        .multilineTextAlignment(.center)
                }
                .frame(width: 600)
                
                Spacer()
                
                Image("app-mascot")
                    .resizable()
                    .frame(width: 300, height: 300)
                
                Spacer()
                
                VStack(spacing: 16) {
                    Button {
                        SoundFXManager.playSound(soundFX: .uiclick)
                        coordinator.push(.game)
                    } label: {
                        Text("Play")
                            .font(fontManager.getFont(.title3, .sans))
                            .padding(.vertical, 16)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(BorderedProminentButtonStyle())
                    .tint(Color(uiColor: .lightGray).gradient)
                    .frame(maxWidth: .infinity)
                    
                    Button {
                        SoundFXManager.playSound(soundFX: .uiclick)
                        coordinator.push(.highScore)
                    } label: {
                        Text("High Score")
                            .font(fontManager.getFont(.title3, .sans))
                            .padding(.vertical, 16)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(BorderedProminentButtonStyle())
                    .tint(Color(uiColor: .lightGray).gradient)
                    .frame(maxWidth: .infinity)
                    
                    Button {
                        SoundFXManager.playSound(soundFX: .uiclick)
                        coordinator.push(.tutorial)
                    } label: {
                        Text("Tutorial")
                            .font(fontManager.getFont(.title3, .sans))
                            .padding(.vertical, 16)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(BorderedProminentButtonStyle())
                    .tint(Color(uiColor: .lightGray).gradient)
                    .frame(maxWidth: .infinity)
                    
                    Button {
                        SoundFXManager.playSound(soundFX: .uiclick)
                        coordinator.push(.credit)
                    } label: {
                        Text("Credits")
                            .font(fontManager.getFont(.title3, .sans))
                            .padding(.vertical, 16)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(BorderedProminentButtonStyle())
                    .tint(Color(uiColor: .lightGray).gradient)
                    .frame(maxWidth: .infinity)
                }
                .padding(.bottom, 64)
                .frame(maxWidth: 500)
                
                Text("Created by: Hans Arthur Cupiterson")
                    .font(fontManager.getFont(.body, .sans))
            }
            .preferredColorScheme(.light)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .sheet(item: $coordinator.sheet) { sheet in
                NavigationStack {
                    coordinator.build(sheet)
                        .environmentObject(fontManager)
                        .environmentObject(coordinator)
                }
            }
            .navigationDestination(for: Screen.self) { screen in
                coordinator.build(screen)
                    .environmentObject(fontManager)
                    .environmentObject(coordinator)
                    .navigationBarBackButtonHidden()
            }
            .fullScreenCover(item: $coordinator.fullScreenCover) { cover in
                coordinator.build(cover)
                    .environmentObject(fontManager)
                    .environmentObject(coordinator)
            }
        }
        .overlay {
            if let notification = coordinator.notification {
                ZStack {
                    coordinator.build(notification)
                }
                .transition(.move(edge: .top)) // Slide-in and slide-out effect
                .environmentObject(fontManager)
                .environmentObject(coordinator)
            }
        }
        .animation(.linear(duration: 0.5), value: coordinator.notification != nil)
    }
}
