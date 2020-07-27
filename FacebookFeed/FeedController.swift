//
//  ViewController.swift
//  FacebookFeed
//
//  Created by shin seunghyun on 2020/07/14.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit

let cellId = "cellId"

/* Image Cache Array */
//var imageCache = NSCache<NSString, UIImage>()

class Post {
    var name: String?
    var profileImageName: String?
    var statusText: String?
    var statusImageURL: String?
    var numLikes: Int?
    var numComments: Int?
}

class FeedController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var posts = [Post]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //cache initialzation, 자동으로 알아서 해줌
        let memoryCapacity = 500 * 1024 * 1024
        let diskCapacity = 500 * 1024 * 1024
        let urlCache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "myDiskPath")
        URLCache.shared = urlCache
        
        let postGhandi = Post()
        postGhandi.name = "Ghandi"
        postGhandi.statusText = "Meanwhile, Best turned to the dark side."
        postGhandi.profileImageName = "ghandi"
        postGhandi.numLikes = 150
        postGhandi.numComments = 175
        postGhandi.statusImageURL = "ghandi_content"
        
        let postSteve = Post()
        postSteve.name = "Steve Jobs"
        postSteve.statusText = "Design is not just what it looks like and feels like. Design is how it works.\n\n" +
            "Being the richest man in the cemetery doesn't matter to me. Going to bed at night saying we've done something wonderful, that's what matters to me.\n\n" +
            "Sometimes when you innovate, you make mistakes. It is best to admit them quickly, and get on with improving your other innovations."
        postSteve.profileImageName = "steve"
        postSteve.numLikes = 186
        postSteve.numComments = 132
        postSteve.statusImageURL = "steve_content"
        
        posts.append(postGhandi)
        posts.append(postSteve)
        
        navigationItem.title = "Facebook Feed"
        
        /** Enable CollectionView Bounce **/
        collectionView.alwaysBounceVertical = true
        
        collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let feedCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCell
        feedCell.post = posts[indexPath.row]
        return feedCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //calculate height
        if let statusText = posts[indexPath.row].statusText {
            let rect = NSString(string: statusText)
                .boundingRect(
                    with: CGSize(width: view.frame.width, height: 1000),
                    options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin),
                    attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)],
                    context: nil
                )
            
            //전체 constraint height값을 더해준다.
            let knownHeight: CGFloat = 8 + 44 + 4 + 4 + 200 + 8 + 24 + 8 + 44
            return CGSize(width: view.frame.width, height: rect.height + knownHeight + 16)
        }
        return CGSize(width: view.frame.width, height: 500)
    }
    
    /*** Handle Orientation ***/
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
        
    }

}

class FeedCell: UICollectionViewCell {
    
    var post: Post? {
        didSet {
            if let name = post?.name {
                let attributedText = NSMutableAttributedString(string: name, attributes:
                    [
                        NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)
                    ]
                )
                attributedText.append(NSAttributedString(string: "\nDecember 18 • San Francisco • ", attributes:
                        [
                            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
                            NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 155, green: 161, blue: 161)
//                            NSAttributedString.Key.foregroundColor: UIColor.black
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
                
                nameLabel.attributedText = attributedText
                
            }
            
            if let statusText = post?.statusText {
                statusTextView.text = statusText
            }
            
            if let profileImageName = post?.profileImageName {
                profileImageView.image = UIImage(named: profileImageName)
            }
            
//            statusImageView.image = nil
            
            //getting image from server and use NSCache for cache
//            if let statusImageURL = post?.statusImageURL {
//                /* Image Cache */
//                if let image = imageCache.object(forKey: NSString(string: statusImageURL)) {
//                    statusImageView.image = image
//                } else {
//                    if let url: URL = URL(string: statusImageURL) {
//                        URLSession.shared.dataTask(with: url) { (data, response, error) in
//                            if error != nil {
//                                print(error!)
//                                return
//                            }
//                            if let data = data {
//                                if let image = UIImage(data: data) {
//                                    imageCache.setObject(image, forKey: NSString(string: statusImageURL))
//                                    DispatchQueue.main.async {
//                                         self.statusImageView.image = image
//                                    }
//                                }
//                            }
//                        }.resume()
//                    }
//                }
//            }
            
            //getting image from server: NSURL Default Session
            if let statusImageURL = post?.statusImageURL {
                    if let url: URL = URL(string: statusImageURL) {
                        URLSession.shared.dataTask(with: url) { (data, response, error) in
                            if error != nil {
                                print(error!)
                                return
                            }
                            if let data = data {
                                if let image = UIImage(data: data) {

                                    DispatchQueue.main.async {
                                         self.statusImageView.image = image
                                    }
                                }
                            }
                        }.resume()
                    }
            }
            
            if let numlikes = post?.numLikes, let numComments = post?.numComments {
                likesCommentsLabel.text = "\(numlikes) Likes   \(numComments) Comments"
            }
            
        }
    }
    
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
        return label
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "zuckerberg")
        imageView.layer.masksToBounds = true 
        return imageView
    }()
    
    let statusTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Meanewhile, Beast turned to the dark side."
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isScrollEnabled = false
        return textView
    }()
    
    let statusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "zuckerberg")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true //clip pixels we dont want
        return imageView
    }()
    
    let likesCommentsLabel: UILabel = {
        let label = UILabel()
        label.text = "488 Likes   10.7K Comments"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.rgb(red: 155, green: 161, blue: 171)
        return label
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 226, green: 228, blue: 232)
        return view
    }()
    
    //static 함수는 field variable에서 사용 가능하다
    let likeButton: UIButton = FeedCell.buttonForTitle(title: "Like", imageName: "heart")
    let commentButton: UIButton = FeedCell.buttonForTitle(title: "Comment", imageName: "pencil.and.ellipsis.rectangle")
    let shareButton: UIButton = FeedCell.buttonForTitle(title: "Share", imageName: "square.and.arrow.up")
    
    //static 함수는 variable에서 사용 가능하다.
    //reusability
    static func buttonForTitle(title: String, imageName: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.rgb(red: 143, green: 150, blue: 163), for: .normal)
        button.setImage(UIImage(systemName: imageName), for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }
    
    func setupViews() {
        self.backgroundColor = UIColor.white
        self.addSubview(nameLabel)
        self.addSubview(profileImageView)
        self.addSubview(statusTextView)
        self.addSubview(statusImageView)
        self.addSubview(likesCommentsLabel)
        self.addSubview(dividerLineView)
        self.addSubview(likeButton)
        self.addSubview(commentButton)
        self.addSubview(shareButton)
        
        //extension method
        self.addConstraintsWithFormat(format: "H:|-8-[v0(44)]-8-[v1]|", views: profileImageView, nameLabel)
        
        
        self.addConstraintsWithFormat(format: "H:|-4-[v0]-4-|", views: statusTextView)
        
        self.addConstraintsWithFormat(format: "H:|[v0]|", views: statusImageView)
        
        self.addConstraintsWithFormat(format: "H:|-12-[v0]|", views: likesCommentsLabel)
        
        self.addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: dividerLineView)
        
        //button constraints
        //[v0(v1)][v1] => share the space equally
        self.addConstraintsWithFormat(format: "H:|[v0(v2)][v1(v2)][v2]|", views: likeButton, commentButton, shareButton)
        
        self.addConstraintsWithFormat(format: "V:|-12-[v0]", views: nameLabel)
        
        
        
        self.addConstraintsWithFormat(format: "V:|-8-[v0(44)]-4-[v1]-4-[v2(200)]-8-[v3(24)]-8-[v4(0.4)][v5(44)]|",
                                      views: profileImageView, statusTextView, statusImageView, likesCommentsLabel, dividerLineView, likeButton)

        self.addConstraintsWithFormat(format: "V:[v0(44)]|", views: commentButton)
        
        self.addConstraintsWithFormat(format: "V:[v0(44)]|", views: shareButton)
        
    }
    
}

extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
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
