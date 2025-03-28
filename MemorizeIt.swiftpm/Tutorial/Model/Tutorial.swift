//
//  Tutorial.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 20/02/25.
//

import Foundation

struct Tutorial {
    var id = UUID()
    var title: String
    var imageName: String
    var content: [String]
}

extension Tutorial {
    static var data: [Tutorial] {
        return [
            .init(
                title: "Introduction",
                imageName: "tutorial-introduction",
                content: [
                    "Welcome to Memo's shop game tutorial.",
                    "In this tutorial, you will learn how to play the game."
                ]
            ),
            .init(
                title: "Main menu",
                imageName: "tutorial-mainmenu",
                content: [
                    "When you first open the game, you will see the main menu.",
                    "1.  Press Play to start the game.",
                    "2.  Press High Score to see all your game attempts and scores.",
                    "3.  Press Tutorial to view the game tutorial.",
                    "4.  Press Credits to view all credits."
                ]
            ),
            .init(
                title: "Order View and How to sell items",
                imageName: "tutorial-order",
                content: [
                    "The objective of the game is to complete as many orders as you can!",
                    "1.  You can view your balance in the top left corner.",
                    "2.  Below the balance, you can see the remaining time.",
                    "3.  On the top side you can see all the orders you have to complete. Press the  'right arrow' to view the order details.",
                    "4.  If you don't want to take the order, simply remove it.",
                    "5.  Every second, there's a set probability for an order to appear.",
                    "6.  Below the order list, you can view your packed items. Press each packed item to  view the contents and sell it to a customer.",
                    "7.  You can switch between storage and supplier by pressing the navigation bar at the bottom.",
                    "Beware that every time you switch the view, the time will be deducted by 2 seconds. So be sure to remember what you have to do each time you switch views to avoid wasting time."
                ]
            ),
            .init(
                title: "Supplier View and how to buy items",
                imageName: "tutorial-supplier",
                content: [
                    "Welcome to the supplier view. Here you can purchase any items you need, which will be automatically delivered to your inventory.",
                    "1.  On the top side, there's a cart. Every time you select an item from the store item list, the item will appear in the cart.",
                    "2.  After you put the items you need in the cart, simply press checkout, and the items will be delivered to your inventory.",
                    "3.  On the bottom side, there's the store item list. You can view all the available items and their prices. Simply press any item to add it to the cart.",
                    "Remember, you only have a limited amount of money to buy for your storage, so be sure to manage your balance well."
                ]
            ),
            .init(
                title: "Storage View and How to pack items",
                imageName: "tutorial-storage",
                content: [
                    "In the storage view, you can pack your items here.",
                    "1.  The top view shows a list of all your packed items. If you want to unpack an item, simply tap one of the packages, and all the items will be put back into your inventory.",
                    "2.  The middle view is for the table where you can temporarily place items that you can later pack into a package. If there are any items, simply press them to put them back into the inventory.",
                    "3.  The bottom view is your inventory. You can view your item stock here. Simply press any item to place it on the table."
                ]
            ),
            .init(
                title: "Tips",
                imageName: "tutorial-tips",
                content: [
                    "Still feeling confused? It's okay! You will learn while playing this game",
                    "To play the game effectively, follow these steps: ",
                    "1.  See the order from the customer",
                    "2.  Buy the required item from the supplier",
                    "3.  Pack the item",
                    "Beware that switching views too often will deduct time from your remaining time. Try to minimize view switches to maximize your score by remembering the items.",
                    "Have fun playing this game! We look forward to hearing about your experiences!"
                ]
            )
        ]
    }
}
