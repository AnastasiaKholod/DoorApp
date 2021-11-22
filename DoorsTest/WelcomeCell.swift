//
//  WelcomeCell.swift
//  DoorsTest
//
//  Created by Macbook Pro 13 on 20.11.2021.
//

import Foundation
import SnapKit
import UIKit

class WelcomeCell: UITableViewCell {

    private let interQRBtn = UIButton()
    private let settingsBtn = UIButton()
    private let welcomeLbl = UILabel()
    private let doorImage = UIImageView(image: UIImage(named: "doorImage"))
    private let screenshot = UIImageView(image: UIImage(named: "welcomeScreenshot"))
    static let height: CGFloat = 100
    var indexPath : IndexPath?

    var didTapSetting:((IndexPath?)->())?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .white
        self.contentView.addSubview(screenshot)

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        screenshot.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.contentView)
            screenshot.backgroundColor = .green
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
