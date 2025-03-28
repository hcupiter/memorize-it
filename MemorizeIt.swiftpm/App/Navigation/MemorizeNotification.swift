//
//  Notification.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 22/02/25.
//

enum MemorizeNotification {
    case notification(
        imageName: String? = nil,
        title: String? = nil,
        description: String
    )
}

extension MemorizeNotification: Identifiable {
    var id: Self { return self }
}

extension MemorizeNotification: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
}

extension MemorizeNotification: Equatable {
    static func == (lhs: MemorizeNotification, rhs: MemorizeNotification) -> Bool {
        switch (lhs, rhs){
        case (.notification, .notification):
            return true
        }
    }
}
