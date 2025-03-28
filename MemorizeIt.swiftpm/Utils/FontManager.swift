import SwiftUI

// Font Manager Singleton
class FontManager: ObservableObject {
    @Published var isRegistered = false
    
    init() {
        registerFont()
    } 
    
    func registerFont() {
        guard !isRegistered else { 
            debugPrint("ERROR: Font is already registered...")
            return 
        }
        
        guard let urlFontBold = Bundle.main.url(forResource: "PixeloidBold", withExtension: "ttf") else {
            print("Error: Font file PixeloidBold not found")
            return
        }
        
        guard let urlFontMono = Bundle.main.url(forResource: "PixeloidMono", withExtension: "ttf") else {
            print("Error: Font file PixeloidMono not found")
            return
            
        }
        
        guard let urlFontSans = Bundle.main.url(forResource: "PixeloidSans", withExtension: "ttf") else {
            print("Error: Font file PixeloidSans not found")
            return
        }
        
        CTFontManagerRegisterFontsForURL(urlFontBold as CFURL, .process, nil)
        CTFontManagerRegisterFontsForURL(urlFontMono as CFURL, .process, nil)
        CTFontManagerRegisterFontsForURL(urlFontSans as CFURL, .process, nil)
        isRegistered = true
    }
    
    func getFont(size: CGFloat, fontWeight: PixelFontType = .sans) -> Font {
        let fontName: String
        switch fontWeight {
        case .mono: fontName = "PixeloidMono"
        case .sans: fontName = "PixeloidSans"
        case .bold: fontName = "PixeloidSans-Bold"
        }
        
        return Font.custom(fontName, size: size)
    }
    
    func getFont(_ size: PixelFontSize = .body, _ fontWeight: PixelFontType = .sans) -> Font {
        let fontName: String
        switch fontWeight {
        case .mono: fontName = "PixeloidMono"
        case .sans: fontName = "PixeloidSans"
        case .bold: fontName = "PixeloidSans-Bold"
        }
        
        return Font.custom(fontName, size: size.value)
    }
}

enum PixelFontType {
    case mono
    case sans
    case bold
}

enum PixelFontSize {
    case title
    case title2
    case title3
    case title4
    case title5
    case headline
    case body
    case callout
    case caption
    case caption2
    
    var value: CGFloat {
        switch self {
        case .title:
            return 32
        case .title2:
            return 28
        case .title3:
            return 24
        case .title4:
            return 22
        case .title5:
            return 20
        case .headline:
            return 18
        case .body:
            return 16
        case .callout:
            return 14
        case .caption:
            return 11
        case .caption2:
            return 10
        }
    }
}
