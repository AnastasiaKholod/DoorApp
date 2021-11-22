//
//  DoorCell.swift
//  DoorsTest
//
//  Created by Macbook Pro 13 on 20.11.2021.
//

import Foundation
import SnapKit
import UIKit

class DoorCell: UITableViewCell {

    private let leftIcon = UIImageView()
    private let rightIcon = UIImageView()
    private let doorTitleLbl = UILabel()
    private let roomTypeLbl = UILabel()
    private let lockStatusLbl = UILabel()

    var indexPath : IndexPath?

    func configureWithItem(item: DoorModelItem) {

        doorTitleLbl.text = item.doorType?.rawValue
        roomTypeLbl.text = item.roomType?.rawValue
        doorLockStatus = item.doorLocked == true ? .locked : .unlocked

    }

    private let doorImage = UIImageView(image: UIImage(named: "doorImage"))

    public enum LockStatus: String {
        case locked
        case unlocked
        case unlocking
    }

    var doorLockStatus: LockStatus = .locked {
        didSet{
            switch doorLockStatus {
                case .locked:
                    leftIcon.image = UIImage(named: "left_locked_icon")
                    rightIcon.image = UIImage(named: "right_locked_icon")
                    lockStatusLbl.text = "Locked"

                case .unlocked:
                    leftIcon.image = UIImage(named: "left_unlocked_icon")
                    rightIcon.image = UIImage(named: "right_unlocked_icon")
                    lockStatusLbl.text = "Unlocked"

                case .unlocking:
                    leftIcon.image = UIImage(named: "left_unlocking_icon")
                    rightIcon.image = UIImage(named: "right_unlocking")
                    lockStatusLbl.text = "Unlocking"
            }
        }
    }

    var lockDoorTapped:((IndexPath?)->())?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .white
        contentView.addSubview(leftIcon)
        contentView.addSubview(rightIcon)
        contentView.addSubview(doorTitleLbl)
        contentView.addSubview(roomTypeLbl)
        contentView.addSubview(lockStatusLbl)

        let tap = UITapGestureRecognizer(target:self,action:#selector(self.lockTapped))

        lockStatusLbl.isUserInteractionEnabled = true
        lockStatusLbl.addGestureRecognizer(tap)
    }


    @objc func lockTapped(){
        self.lockDoorTapped?(indexPath)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        leftIcon.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(40)
            make.top.equalTo(contentView.snp.top).offset(10)
            make.leading.equalTo(contentView.snp.leading).offset(30)
        }

        rightIcon.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(40)

            make.top.equalTo(contentView.snp.top).offset(10)
            make.trailing.equalTo(contentView.snp.trailing).offset(-50)
        }

        doorTitleLbl.snp.makeConstraints { make in
            make.top.equalTo(leftIcon.snp.top)
            make.leading.equalTo(leftIcon.snp.trailing).offset(15)
        }
        roomTypeLbl.snp.makeConstraints { make in
            make.top.equalTo(doorTitleLbl.snp.bottom).offset(5)
            make.leading.equalTo(leftIcon.snp.trailing).offset(15)
        }

        lockStatusLbl.snp.makeConstraints { make in
            make.top.equalTo(rightIcon.snp.bottom).offset(6)
            make.centerX.equalTo(contentView.snp.centerX)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
