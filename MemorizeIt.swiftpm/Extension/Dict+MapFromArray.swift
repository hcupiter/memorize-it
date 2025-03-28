//
//  Array+MapToDict.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 17/01/25.
//

import Foundation

extension Dictionary {
    /*
     T: The type of elements in the array.
     K: The type of the dictionary keys (must conform to Hashable).
     V: The type of the dictionary values.
     
     array: The input array to map.
     transform: A closure that takes an element of type T and returns a tuple (key: K, value: V).
     */
    static func mapFromArray<T, K, V>(
        array: [T],
        transform: (T) -> (key: K, value: V)
    ) -> [K: V] where K: Hashable {
        var dictionary: [K: V] = [:]
        for element in array {
            let (key, value) = transform(element)
            dictionary[key] = value
        }
        return dictionary
    }

}
