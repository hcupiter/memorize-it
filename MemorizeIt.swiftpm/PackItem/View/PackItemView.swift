import SwiftUI

struct PackItemView: View {
    @EnvironmentObject var gameState: GameState
    @EnvironmentObject var stockList: StockListViewModel
    @EnvironmentObject var statistics: AnyGameStatistics
    @EnvironmentObject var fontManager: FontManager
    
    var body: some View {
        GeometryReader { geometry in
            VStack {                
                // Middle Top Pane
                PackItemFinishedItemView()
                .frame(height: 200)
                
                // Middle Pane
                PackItemTableView()
                .frame(maxWidth: .infinity)
                
                // Bottom Pane
                PackItemStockListView()
                
                Button {
                    SoundFXManager.playSound(soundFX: .walking)
                    gameState.switchView(to: .counter, statistics: statistics)
                } label: {
                    Text("Back to the counter")
                        .frame(maxWidth: .infinity)
                        .padding(16)
                        .font(fontManager.getFont(.title3, .bold))
                }
                .buttonStyle(BorderedProminentButtonStyle())
                .tint(.blue)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
    }
}
