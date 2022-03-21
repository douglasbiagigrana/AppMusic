//
//  CardViewTableViewCell.swift
//  AppMusic
//
//  Created by Douglas Biagi Grana on 20/03/22.
//

import UIKit

class CardViewTableViewCell: UITableViewCell {
    
    static let identifier: String = "CardViewTableViewCell"
    
    lazy var cardView: CustomCardView = {
        let view = CustomCardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
        self.setUpConstraints()
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setUpCell(data: CardViewModel) {
        self.cardView.setUpView(data: data)
    }
    
    fileprivate func setUpView() {
        self.contentView.addSubview(self.cardView)
    }
    
    fileprivate func setUpConstraints() {
        self.cardView.pin(to: self)
    }
}
