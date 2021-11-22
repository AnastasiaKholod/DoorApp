//
//  DoorLockStatusModel.swift
//  DoorsTest
//
//  Created by Macbook Pro 13 on 20.11.2021.
//

import Foundation
protocol DoorDelegate: NSObjectProtocol {

    func didRecieveDoors(list: [DoorModelItem])
    func didFailDataUpdateWithError(error: Error)
}

class DoorModel {

    weak var delegate: DoorDelegate?
    var doorItems = [DoorModelItem]()
    var onLockStatusChanged:((_ isLocked:Bool, _ indexPath: IndexPath)->())?

    func requestDoorList() {

        var error: Error?
        var response: [DoorModelItem] = []

        for index in 0...3 {
            let  modelItem = DoorModelItem(doorLocked: true, doorType: .frontDoor, roomType: .home, id: index)
            response.append(modelItem)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)){ [weak self] in

            self?.doorItems = response
            self?.delegate?.didRecieveDoors(list: self?.doorItems ?? [])

            if let error = error {
                self?.delegate?.didFailDataUpdateWithError(error: error)
            }
        }
    }

    func unlockDoor(id:Int, indexPath: IndexPath){

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)){ [weak self] in

            self?.onLockStatusChanged?(false, indexPath)

            self?.lockDoor(id: id, indexPath: indexPath)
        }
    }

    func lockDoor(id:Int, indexPath: IndexPath){

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)){ [weak self] in
            self?.onLockStatusChanged?(true, indexPath)
            print("id \(id)")
        }
    }
}


