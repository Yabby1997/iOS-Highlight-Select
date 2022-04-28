//
//  ViewController.swift
//  Highlight&Select
//
//  Created by Seunghun Yang on 2022/04/28.
//

import UIKit

class CircularCell: UICollectionViewCell {
    
    static let identifier = "CircularCell"
    
    private let outerRing: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.isHidden = true
        view.clipsToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.systemBlue.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let circularView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var color: UIColor? {
        didSet { circularView.backgroundColor = color }
    }
    
    override var isSelected: Bool {
        didSet {
            outerRing.isHidden = !isSelected
            outerRing.layer.borderColor = UIColor.systemBlue.cgColor
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            outerRing.isHidden = !isHighlighted
            outerRing.layer.borderColor = UIColor.systemGray.cgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = frame.width
        outerRing.layer.cornerRadius = width / 2
        circularView.layer.cornerRadius = (width - 8) / 2
    }
    
    private func setupViews() {
        contentView.addSubview(outerRing)
        contentView.addSubview(circularView)
        
        NSLayoutConstraint.activate([
            outerRing.topAnchor.constraint(equalTo: contentView.topAnchor),
            outerRing.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            outerRing.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            outerRing.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            circularView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            circularView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            circularView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            circularView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
        ])
        
    }
}

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    let colors: [UIColor] = [
        .red,
        .orange,
        .yellow,
        .green,
        .blue,
        .systemIndigo,
        .purple,
        .cyan,
        .systemPink,
        .black,
        .white,
        .gray,
        .systemGray,
        .darkGray,
        .lightGray,
        .systemGray2,
        .systemGray3,
        .systemGray4,
        .systemGray5,
        .systemBlue,
        .magenta,
        .link,
        .systemBackground,
    ]
    
    private(set) lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 6
        layout.minimumLineSpacing = 6
        layout.sectionInset = UIEdgeInsets(top: 2, left: 22, bottom: 0, right: 22)
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.register(CircularCell.self, forCellWithReuseIdentifier: CircularCell.identifier)
        view.delegate = self
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 80) / 7
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CircularCell.identifier, for: indexPath)
        guard let cell = cell as? CircularCell else { return cell }
        cell.color = colors[indexPath.item]
        return cell
    }
}
