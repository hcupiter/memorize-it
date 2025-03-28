//
//  AppCoordinatorProtocol.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 31/01/25.
//

protocol AppCoordinatorProtocol {
    func push(_ screen: Screen)
    func presentSheet(_ sheet: Sheet)
    func presentFullScreenCover(_ cover: FullScreenCover)
    func presentNotification(_ notification: MemorizeNotification)
    func pop()
    func popAll()
    func dismissSheet(onDismiss: (() -> ())?)
    func dismissFullScreenCover()
    func dismissNotification()
}
