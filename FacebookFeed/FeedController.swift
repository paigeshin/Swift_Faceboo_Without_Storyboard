//
//  ViewController.swift
//  FacebookFeed
//
//  Created by shin seunghyun on 2020/07/14.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit

let cellId = "cellId"

class FeedController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Facebook Feed"
        
        /** Enable CollectionView Bounce **/
        collectionView.alwaysBounceVertical = true
        
        collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }

}

class FeedCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        let attributedText = NSMutableAttributedString(string: "Mark Zuckerberg", attributes:
            [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)
            ]
        )
        attributedText.append(NSAttributedString(string: "\nDecember 18 • San Francisco • ", attributes:
                [
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
                    NSAttributedString.Key.foregroundColor: UIColor(red: 155/255, green: 161/255, blue: 171/255, alpha: 1)
                ]
            )
        )
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.count))
        
        //텍스트 옆에다 붙여줌.
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "globe")
        attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
        attributedText.append(NSAttributedString(attachment: attachment))
        
        label.attributedText = attributedText
        
        return label
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "zuckerberg")
        return imageView
    }()
    
    let statusTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Meanewhile, Beast turned to the dark side."
        textView.font = UIFont.systemFont(ofSize: 14)
        return textView
    }()
    
    let statusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "zuckerberg")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true //clip pixels we dont want
        return imageView
    }()
    
    func setupViews() {
        self.backgroundColor = UIColor.white
        self.addSubview(nameLabel)
        self.addSubview(profileImageView)
        self.addSubview(statusTextView)
        self.addSubview(statusImageView)
        
        //extension method
        self.addConstraintsWithFormat(format: "H:|-8-[v0(44)]-8-[v1]|", views: profileImageView, nameLabel)
        self.addConstraintsWithFormat(format: "H:|-4-[v0]-4-|", views: statusTextView)
        self.addConstraintsWithFormat(format: "H:|[v0]|", views: statusImageView)
        self.addConstraintsWithFormat(format: "V:|-12-[v0]", views: nameLabel)
        self.addConstraintsWithFormat(format: "V:|-8-[v0(44)]-4-[v1(30)]-4-[v2]|", views: profileImageView, statusTextView, statusImageView)

    }
    
}

extension UIView {
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        self.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: format,
                options: NSLayoutConstraint.FormatOptions(),
                metrics: nil,
                views: viewsDictionary)
        )
    }
    
}
