//
//  ViewController.swift
//  AppMusic
//
//  Created by Douglas Biagi Grana on 19/03/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    var screen: HomeViewControllerScreen?
    
    override func loadView() {
        //gerando instancia da variavel screen
        self.screen = HomeViewControllerScreen()
        //passando a responsabilidade dos protocolos para minha viewcontroller
        self.screen?.configTableViewProtocols(delegate: self, dataSource: self)
        //falando que toda visualizacao da nossa viewcontroller agora é responsabilidade da nossa screen
        self.view = self.screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CardData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CardViewTableViewCell.identifier, for: indexPath) as? CardViewTableViewCell
        cell?.setUpCell(data: CardData[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("oi")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
}
