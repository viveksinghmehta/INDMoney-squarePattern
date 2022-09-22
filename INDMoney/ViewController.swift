//
//  ViewController.swift
//  INDMoney
//
//  Created by Vivek Singh Mehta on 22/09/22.
//

import UIKit

class ViewController: UIViewController {

    private lazy var gameCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset =  UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(GameCollectionViewCell.self, forCellWithReuseIdentifier: GameCollectionViewCell.reuseIdentifier)
        return collectionView
    }()
    
    private lazy var generateButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Generate", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(generatePattern(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var numberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "enter the number"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .phonePad
        return textField
    }()
    
    var number = 0
    var rightToleftdiagonal = [Int]()
    var leftToRightDiagonal = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(gameCollectionView)
        
        view.addSubview(numberTextField)
        numberTextField.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        numberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        numberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        numberTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(generateButton)
        generateButton.topAnchor.constraint(equalTo: numberTextField.bottomAnchor, constant: 10).isActive = true
        generateButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        generateButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        generateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        generateButton.layer.cornerRadius = 25
        generateButton.clipsToBounds = true
        
        gameCollectionView.topAnchor.constraint(equalTo: generateButton.bottomAnchor, constant: 20).isActive = true
        gameCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        gameCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        gameCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        gameCollectionView.delegate = self
        gameCollectionView.dataSource = self
        gameCollectionView.reloadData()
    }

    fileprivate func getdiagonal() {
        for i in 1...number {
            if i != number {
                rightToleftdiagonal.append((number * i) - (i - 1))
            }
        }
    }
    
    
    fileprivate func leftToRight() {
        for i in 1...number {
            if i != number {
                leftToRightDiagonal.append((i * number) + (i + 1))
            }
        }
    }

    
    @objc func generatePattern(_ sender: UIButton) {
        view.endEditing(true)
        if let number = Int(numberTextField.text ?? "5") {
            self.number = number
            getdiagonal()
            leftToRight()
            gameCollectionView.reloadData()
        }
    }

}
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return number * number
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCollectionViewCell.reuseIdentifier, for: indexPath) as? GameCollectionViewCell else { return UICollectionViewCell() }
        cell.backgroundColor = .red
        if ((indexPath.row + 1) <= number) ||
            ((indexPath.row + 1) % number == 0) ||
            ((indexPath.row + 1) % number == 1) ||
            ((indexPath.row + 1) > ((number * (number - 1)))) ||
            (rightToleftdiagonal.contains(indexPath.row + 1)) ||
            (leftToRightDiagonal.contains(indexPath.row + 1)) {
            cell.colorTheview()
            cell.setNumberlabel(number: indexPath.row + 1)
        } else {
            cell.decolor()
            cell.setNumberlabel(number: indexPath.row + 1)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.bounds.width / CGFloat(number)
        return CGSize(width: width, height: width)
    }
    
    
}
