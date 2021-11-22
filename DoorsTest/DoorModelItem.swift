//
//  DoorLockStatusModelItem.swift
//  DoorsTest
//
//  Created by Macbook Pro 13 on 20.11.2021.
//

import Foundation


public struct DoorModelItem: Codable {

    public enum RoomType: String, Codable, CaseIterable {
        case office = "Office"
        case home = "Home"

        var text: String {
            localized
        }
        var identifier: String {
            rawValue
        }
    }
    
    public enum DoorType: String, Codable, CaseIterable {
        case frontDoor = "Front Door"
        case backDoor = "Back Door"

        var text: String {
            localized
        }
        var identifier: String {
            rawValue
        }
    }

    public var doorId: Int?
    public var roomType: RoomType?
    public var doorType: DoorType?
    public var doorLocked: Bool?


    public init(doorLocked: Bool?, doorType: DoorType?, roomType: RoomType?, id: Int?) {
        self.doorLocked = doorLocked
        self.doorType = doorType
        self.roomType = roomType
        self.doorId = id
    }
    public init() {}

}

extension DoorModelItem.RoomType {
    var localized: String {
       return "room_type\(rawValue.lowercased())".localized
    }
}
extension DoorModelItem.DoorType {
    var localized: String {
        return "door_type\(rawValue.lowercased())".localized
    }
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
