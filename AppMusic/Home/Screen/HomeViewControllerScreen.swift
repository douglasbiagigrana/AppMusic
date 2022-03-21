//
//  HomeViewControllerScreen.swift
//  AppMusic
//
//  Created by Douglas Biagi Grana on 20/03/22.
//

import UIKit

class HomeViewControllerScreen: UIView {
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.tableFooterView = UIView()
        tv.showsVerticalScrollIndicator = false
        tv.register(CardViewTableViewCell.self, forCellReuseIdentifier: CardViewTableViewCell.identifier)
        return tv
    }()
    
    //feito dessa maneira pois queremos que a screen so tenha nossos elementos. Quem deve assinar os protocolos é nossa viewcontroller.
    public func configTableViewProtocols(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        self.tableView.delegate = delegate //nao passando o self pois se fosse self, essa camada seria responsavel pelos protocolos, e queremos passar a responsabilidade para outra camada que chamar a funcao.
        self.tableView.dataSource = dataSource
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.tableView)
        self.setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        self.tableView.pin(to: self)
    }
    
}
