//
//  CustomCardView.swift
//  AppMusic
//
//  Created by Douglas Biagi Grana on 20/03/22.
//

import UIKit

enum ViewMode {
    case full
    case card
}

class CustomCardView: UIView {

    //MARK: - PROPRIEDADES
    var vMode: ViewMode?
    var containerLeadingConstraints: NSLayoutConstraint?
    var containerTopConstraints: NSLayoutConstraint?
    var containerTrailingConstraints: NSLayoutConstraint?
    var containerBottomConstraints: NSLayoutConstraint?
    var dataModel: CardViewModel?
    
    //MARK: - ELEMENTOS
    //view do card
    lazy var cardContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 30
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: -2)
        view.layer.shadowRadius = 20
        return view
    }()
    
    //imagem sobre o card
    lazy var cardImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .black
        return image
    }()
    
    //view que escurece a imagemd o card
    lazy var overlayView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        return view
    }()
    
    //bordas na imagem de perfil
    lazy var profileBorderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = 25
        return view
    }()
    
    //imagem de perfil
    lazy var cardProfileImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .black
        image.clipsToBounds = true
        image.layer.cornerRadius = 20
        return image
    }()
    
    //botao de adicionar imagem do usuario(plus)
    lazy var addProfileImageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setBackgroundImage(UIImage(named: "plus"), for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    //categoria da musica
    lazy var cardCategoryTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    //data da musica
    lazy var cardCategoryDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    //titulo
    lazy var cardTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 31, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    //gostei e tempo
    lazy var cardLikeAndTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //descricao
    lazy var cardDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    init() {
        //como esse init e um init sem override precisamos criar o frame pois ele ira utilizar mesmo assim
        let frame = CGRect.zero
        super.init(frame: frame)
        self.addSubViews()
        self.setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubViews() {
        //Adicionando todo mundo dentro da minha cardContainerView
        self.addSubview(self.cardContainerView)
        self.cardContainerView.addSubview(self.cardImage)
        self.cardContainerView.addSubview(self.overlayView)
        
        self.cardContainerView.addSubview(self.profileBorderView)
        self.cardContainerView.addSubview(self.cardProfileImage)
        self.cardContainerView.addSubview(self.addProfileImageButton)
        
        self.cardContainerView.addSubview(self.cardCategoryTitleLabel)
        self.cardContainerView.addSubview(self.cardCategoryDateLabel)
        self.cardContainerView.addSubview(self.cardTitleLabel)
        self.cardContainerView.addSubview(self.cardLikeAndTimeLabel)
        self.cardContainerView.addSubview(self.cardDescriptionLabel)
        self.updateLayout(for: self.vMode ?? .card)
    }
    
    private func setUpConstraints() {
        self.containerLeadingConstraints = cardContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30)
        //e necessario colocar quando nao estamos trabalhando dentro da lista NSLayoutConstraint.activate
        self.containerLeadingConstraints?.isActive = true
        
        self.containerTopConstraints = cardContainerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15)
        self.containerTopConstraints?.isActive = true
        
        self.containerTrailingConstraints = cardContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30)
        self.containerTrailingConstraints?.isActive = true
        
        self.containerBottomConstraints = cardContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15)
        self.containerBottomConstraints?.isActive = true
        
        //setando toda overlayView e Image para ficar tudo 0 do tamanho da minha cardContainerView
        self.overlayView.pin(to: self.cardContainerView)
        self.cardImage.pin(to: self.cardContainerView)
        
        NSLayoutConstraint.activate([
            self.profileBorderView.topAnchor.constraint(equalTo: self.cardContainerView.topAnchor, constant: 60),
            self.profileBorderView.centerXAnchor.constraint(equalTo: cardContainerView.centerXAnchor),
            self.profileBorderView.widthAnchor.constraint(equalToConstant: 50),
            self.profileBorderView.heightAnchor.constraint(equalToConstant: 50),
            
            self.addProfileImageButton.trailingAnchor.constraint(equalTo: self.profileBorderView.trailingAnchor, constant: 4),
            self.addProfileImageButton.bottomAnchor.constraint(equalTo: self.profileBorderView.bottomAnchor, constant: 4),
            self.addProfileImageButton.widthAnchor.constraint(equalToConstant: 20),
            self.addProfileImageButton.heightAnchor.constraint(equalToConstant: 20),
            
            self.cardProfileImage.centerXAnchor.constraint(equalTo: self.profileBorderView.centerXAnchor),
            self.cardProfileImage.centerYAnchor.constraint(equalTo: self.profileBorderView.centerYAnchor),
            self.cardProfileImage.widthAnchor.constraint(equalToConstant: 40),
            self.cardProfileImage.heightAnchor.constraint(equalToConstant: 40),
            
            self.cardCategoryTitleLabel.topAnchor.constraint(equalTo: self.profileBorderView.bottomAnchor, constant: 10),
            self.cardCategoryTitleLabel.centerXAnchor.constraint(equalTo: self.cardContainerView.centerXAnchor),
            
            self.cardCategoryDateLabel.topAnchor.constraint(equalTo: self.cardCategoryTitleLabel.bottomAnchor, constant: 2),
            self.cardCategoryDateLabel.centerXAnchor.constraint(equalTo: self.cardContainerView.centerXAnchor),
            
            self.cardTitleLabel.topAnchor.constraint(equalTo: self.cardCategoryDateLabel.bottomAnchor, constant: 20),
            self.cardTitleLabel.leadingAnchor.constraint(equalTo: self.cardContainerView.leadingAnchor, constant: 20),
            self.cardTitleLabel.trailingAnchor.constraint(equalTo: self.cardContainerView.trailingAnchor, constant: -20),
            
            self.cardLikeAndTimeLabel.topAnchor.constraint(equalTo: self.cardTitleLabel.bottomAnchor, constant: 10),
            self.cardLikeAndTimeLabel.centerXAnchor.constraint(equalTo: self.cardContainerView.centerXAnchor),
            
            self.cardDescriptionLabel.topAnchor.constraint(equalTo: self.cardLikeAndTimeLabel.bottomAnchor, constant: 30),
            self.cardDescriptionLabel.leadingAnchor.constraint(equalTo: self.cardContainerView.leadingAnchor, constant: 40),
            self.cardDescriptionLabel.trailingAnchor.constraint(equalTo: self.cardContainerView.trailingAnchor, constant: -40),

        ])
    }
    
    private func updateLayout(for mode: ViewMode) {
        if mode == .full {
            self.containerLeadingConstraints?.constant = 0
            self.containerTopConstraints?.constant = 0
            self.containerTrailingConstraints?.constant = 0
            self.containerBottomConstraints?.constant = 0
            self.cardDescriptionLabel.isHidden = false
        } else {
            self.containerLeadingConstraints?.constant = 30
            self.containerTopConstraints?.constant = 15
            self.containerTrailingConstraints?.constant = -30
            self.containerBottomConstraints?.constant = -15
            self.cardDescriptionLabel.isHidden = true
        }
    }
    
    //passando os atributos do model para nossos componentes
    public func setUpView(data: CardViewModel) {
        self.cardCategoryTitleLabel.text = data.categoryName
        self.cardCategoryDateLabel.text = data.categoryDate
        self.cardTitleLabel.text = data.cardTitle
        self.cardLikeAndTimeLabel.attributedText = NSAttributedString.featureText(data.likeCount ?? "", data.duration ?? "")
        self.cardDescriptionLabel.text = data.cardDescription
        self.cardImage.image = UIImage(named: data.cardImage ?? "")
        self.cardProfileImage.image = UIImage(named: data.categoryImage ?? "")
    }
}
