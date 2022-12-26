//
//  CryptoCurrencyTableViewCell.swift
//  CryptoCurrencyApp
//
//  Created by Abdullah Waseer on 20/12/2022.
//

import UIKit

class CryptoCurrencyTableViewCell: UITableViewCell {
    
    private let cryptoCurrencyNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let cryptoCurrencySymbolLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light)
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let USDTLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.priceColor
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        return lbl
    }()
    
    private let cryptoCurrencyUSDrateLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.priceColor
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        return lbl
    }()
    
    private let changePerHourLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .darkGray
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        return lbl
    }()
    
    private let cryptoCurrencyChangePerHourLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .darkGray
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        return lbl
    }()
    
    private let cryptoCurrencyImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 28.0
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor.white
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        contentView.addSubview(cryptoCurrencyImage)
        
        cryptoCurrencyImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 12, paddingRight: 0, width: 56, height: 56)
        
        let cryptoCurrencyNameStackView = UIStackView(arrangedSubviews: [cryptoCurrencyNameLabel,cryptoCurrencySymbolLabel])
        cryptoCurrencyNameStackView.distribution = .fill
        cryptoCurrencyNameStackView.axis = .horizontal
        cryptoCurrencyNameStackView.spacing = 8
        contentView.addSubview(cryptoCurrencyNameStackView)
        cryptoCurrencyNameStackView.anchor(top: topAnchor, left: cryptoCurrencyImage.rightAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 20)
        
        let cryptoCurrencyUSDstackView = UIStackView(arrangedSubviews: [USDTLabel,cryptoCurrencyUSDrateLabel])
        cryptoCurrencyUSDstackView.distribution = .fill
        cryptoCurrencyUSDstackView.axis = .horizontal
        cryptoCurrencyUSDstackView.spacing = 5
        contentView.addSubview(cryptoCurrencyUSDstackView)
        cryptoCurrencyUSDstackView.anchor(top: cryptoCurrencyNameStackView.bottomAnchor, left: cryptoCurrencyImage.rightAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 20)
        
        let cryptoCurrencyChangePerHourstackView = UIStackView(arrangedSubviews: [changePerHourLabel,cryptoCurrencyChangePerHourLabel])
        cryptoCurrencyChangePerHourstackView.distribution = .fill
        cryptoCurrencyChangePerHourstackView.axis = .horizontal
        cryptoCurrencyChangePerHourstackView.spacing = 5
        contentView.addSubview(cryptoCurrencyChangePerHourstackView)
        cryptoCurrencyChangePerHourstackView.anchor(top: cryptoCurrencyUSDstackView.bottomAnchor, left: cryptoCurrencyImage.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 20)
    }
    
    func prepare(with viewModel: CryptoCurrencyTableViewCellViewModel) {
        self.cryptoCurrencyNameLabel.text =  viewModel.currencyName
        self.cryptoCurrencySymbolLabel.text = viewModel.currencySymbol
        self.USDTLabel.text = "Price:"
        self.cryptoCurrencyUSDrateLabel.text = viewModel.currencyUSDrate
        self.changePerHourLabel.text = "1h:"
        self.cryptoCurrencyChangePerHourLabel.text = viewModel.currencyExchangePerHour
        self.cryptoCurrencyImage.setImage(from: URL(string: viewModel.currencyImageUrl), placeholderImage: UIImage.init(named: "placeholder"))
        
        self.cryptoCurrencyChangePerHourLabel.textColor = viewModel.model.currencyExchangePerHour < 0 ? UIColor.negativeValueColor : UIColor.positiveValueColor
        self.changePerHourLabel.textColor = viewModel.model.currencyExchangePerHour < 0 ? UIColor.negativeValueColor : UIColor.positiveValueColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
