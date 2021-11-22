//
//  ViewController.swift
//  DoorsTest
//
//  Created by Macbook Pro 13 on 20.11.2021.
//

import UIKit
import Foundation
import SnapKit

class DoorsViewController: UIViewController {

    var doorsArray: [DoorModelItem] = []{
        didSet {
            tableView.reloadData()
        }
    }

    private let model = DoorModel()

    let tableView: UITableView = {
        let table = UITableView()
        table.contentInsetAdjustmentBehavior = .never
        table.separatorStyle = .none
        table.register(WelcomeCell.self, forCellReuseIdentifier: "welcomeCell")
        table.register(DoorCell.self, forCellReuseIdentifier: "doorCell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        model.delegate = self
        view.addSubview(tableView)
        navigationController?.isNavigationBarHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        model.requestDoorList()
        // TODO: add progress Hud
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: 30, width: view.bounds.width, height: view.bounds.height)
    }
}

extension DoorsViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doorsArray.count+1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
            case 0:
                let cellID = "welcomeCell"
                let cell = tableView.dequeueReusableCell(withIdentifier:
                                                            cellID, for: indexPath) as? WelcomeCell
                return cell!

            default:
                let cellID = "doorCell"
                let cell = tableView.dequeueReusableCell(withIdentifier:
                                                            cellID, for: indexPath) as? DoorCell
                cell!.configureWithItem(item: doorsArray[indexPath.item-1])

                cell?.lockDoorTapped = { [weak self] nothing in
                    self?.unlockDoor(indexPath: indexPath)
                }
                return cell!
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        switch indexPath.row {
            case 0:
                return 300
            default:
                return 150
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let indexPath = tableView.indexPathForSelectedRow {
            unlockDoor(indexPath: indexPath)
        }

    }
    func unlockDoor (indexPath: IndexPath) {

        if  let currentCell = tableView.cellForRow(at: indexPath)! as? DoorCell {

            guard currentCell.doorLockStatus == .locked else{
                return
            }
            model.unlockDoor(id: doorsArray[indexPath.row-1].doorId!, indexPath: indexPath)

            currentCell.doorLockStatus = .unlocking

            model.onLockStatusChanged = {[weak self] (status, indexPath) in
                let cell = self?.tableView.cellForRow(at: indexPath) as? DoorCell

                switch status {
                    case true:
                        cell?.doorLockStatus = .locked
                    default:
                        cell?.doorLockStatus = .unlocked
                }
            }
        }
    }

}

extension DoorsViewController: DoorDelegate {

    func didFailDataUpdateWithError(error: Error) {
    }

    func didRecieveDoors(list: [DoorModelItem]) {
        doorsArray = list
    }

}


