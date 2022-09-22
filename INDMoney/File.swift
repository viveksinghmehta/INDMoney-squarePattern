//
//  GameCollectionViewCell.swift
//  INDMoney Game
//
//  Created by Vivek Singh Mehta on 21/09/22.
//

import UIKit

final class GameCollectionViewCell: UICollectionViewCell {
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.backgroundColor = .systemBackground
        label.textAlignment = .center
        label.layer.cornerRadius = 15
        label.clipsToBounds = true
        return label
    }()
    
    private lazy var crossImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "x")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var contentBackgroundView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue
        return view
    }()
    
    private lazy var smilyImageView: UIImageView = {
        let imageView = UIImageView()
         imageView.translatesAutoresizingMaskIntoConstraints = false
         imageView.image = UIImage(named: "grinning")
         imageView.contentMode = .scaleAspectFit
         return imageView
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpContentView()
    }
    
    func colorTheview() {
        contentView.addSubview(numberLabel)
        NSLayoutConstraint.activate([
            numberLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            numberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            numberLabel.heightAnchor.constraint(equalToConstant: 30),
            numberLabel.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    fileprivate func setUpContentView() {
        
        contentView.addSubview(contentBackgroundView)
        NSLayoutConstraint.activate([
            contentBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
    
     func decolor() {
        contentBackgroundView.removeFromSuperview()
    }
    
    func setNumberlabel(number: Int) {
        numberLabel.text = "\(number)"
    }
    
    func addCross() {
//        view.addSubview(crossImageView)
        NSLayoutConstraint.activate([
            crossImageView.topAnchor.constraint(equalTo: contentBackgroundView.topAnchor),
            crossImageView.leadingAnchor.constraint(equalTo: contentBackgroundView.leadingAnchor),
            crossImageView.heightAnchor.constraint(equalTo: contentBackgroundView.heightAnchor),
            crossImageView.widthAnchor.constraint(equalTo: crossImageView.heightAnchor)
        ])
    }
    
    func removeCross() {
        crossImageView.removeFromSuperview()
    }
    
    func removeSmily() {
        smilyImageView.removeFromSuperview()
    }
    
    func addSmily() {
        contentBackgroundView.addSubview(smilyImageView)
        NSLayoutConstraint.activate([
            smilyImageView.bottomAnchor.constraint(equalTo: contentBackgroundView.bottomAnchor),
            smilyImageView.trailingAnchor.constraint(equalTo: contentBackgroundView.trailingAnchor),
            smilyImageView.heightAnchor.constraint(equalTo: contentBackgroundView.heightAnchor),
            smilyImageView.widthAnchor.constraint(equalTo: smilyImageView.heightAnchor)
        ])
    }
    
}

protocol ReuseIdentifying {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifying {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UICollectionViewCell: ReuseIdentifying {}
extension UITableViewCell : ReuseIdentifying {}
extension UITableViewHeaderFooterView : ReuseIdentifying {}

