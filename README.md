# Lecture 1

[https://www.youtube.com/watch?v=NJxb7EKXF3U&list=PL0dzCUj1L5JHDWIO3x4wePhD8G4d1Fa6N&index=1](https://www.youtube.com/watch?v=NJxb7EKXF3U&list=PL0dzCUj1L5JHDWIO3x4wePhD8G4d1Fa6N&index=1)

# Project Setup

1. `Main.Storyboard` 를 삭제 
2. info.plist에서 `Main.Storyboard` 에 관한 내용을 제거해준다. 
3. Simulator를 실행했을 때, black screen이 나오면 제대로 setup이 된 것이다.

# Initialize

- Initialize

```swift
func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    //initialize window when you don't use storyboard
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(frame: windowScene.coordinateSpace.bounds)
    window?.windowScene = windowScene
      window?.rootViewController = ViewController()
    window?.makeKeyAndVisible() //Storyboard 없이 순수 코딩으로 UI를 작성하려면 이 함수를 반드시 호출해줘야함
    guard let _ = (scene as? UIWindowScene) else { return }
}
```

- UINavigationController + UICollectionViewController

```swift
func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    //initialize window when you don't use storyboard
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(frame: windowScene.coordinateSpace.bounds)
    window?.windowScene = windowScene
    //navigation controller에 conllectionViewController를 넣어서 initialize
    let feedController = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
    let navigationController = UINavigationController(rootViewController: feedController)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible() //Storyboard 없이 순수 코딩으로 UI를 작성하려면 이 함수를 반드시 호출해줘야함
    guard let _ = (scene as? UIWindowScene) else { return }
}
```

# Change Status Bar Style globally

```swift
func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        //deprecated됬다지만 사실상 ios 9.0부터 이럼. 그니까 그냥 적용해도 됨
        UIApplication.shared.statusBarStyle = .lightContent
        
        guard let _ = (scene as? UIWindowScene) else { return }
  }
```

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/cd746267-2b9b-416e-9355-bd55a6a3c8f6/Screen_Shot_2020-07-14_at_14.18.39.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/cd746267-2b9b-416e-9355-bd55a6a3c8f6/Screen_Shot_2020-07-14_at_14.18.39.png)

⇒ View Controller-based status bar, set `NO`

# NSAttributedString - attachement

```swift
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
```

- Pattern

`NSAttributedString.Key.`

ℹ️  Swift format language `|` 's meaning

- extend

# Complete Code

- SceneDelegate.swift

```swift
//
//  SceneDelegate.swift
//  FacebookFeed
//
//  Created by shin seunghyun on 2020/07/14.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        //initialize window when you don't use storyboard
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        //navigation controller에 conllectionViewController를 넣어서 initialize
        let feedController = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        let navigationController = UINavigationController(rootViewController: feedController)
        window?.rootViewController = navigationController
        
        //Navigation Bar Design Control
        UINavigationBar.appearance().barTintColor = UIColor(red: 51/255, green: 90/255, blue: 149/255, alpha: 1)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        //deprecated됬다지만 사실상 ios 9.0부터 이럼. 그니까 그냥 적용해도 됨
        UIApplication.shared.statusBarStyle = .lightContent
        
        window?.makeKeyAndVisible() //Storyboard 없이 순수 코딩으로 UI를 작성하려면 이 함수를 반드시 호출해줘야함, 맨 마지막에 나와야한다.
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

}
```

- FeedController.swift

```swift
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
```
# Lecture 2

[https://www.youtube.com/watch?v=ZwBYQpLQAvw&list=PL0dzCUj1L5JHDWIO3x4wePhD8G4d1Fa6N&index=2](https://www.youtube.com/watch?v=ZwBYQpLQAvw&list=PL0dzCUj1L5JHDWIO3x4wePhD8G4d1Fa6N&index=2)

ℹ️  swift, field에서 함수를 호출하려면...

```swift
//static 함수는 variable에서 사용 가능하다
let likeButton: UIButton = buttonForTitle(title: "Like", imageName: "heart")

let commentButton: UIButton = buttonForTitle(title: "Comment", imageName: "pencil.and.ellipsis.rectangle")

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
```

⇒ `static` 함수로 선언해야한다. 

ℹ️  Swift, format language equal space

```swift
//button constraints
//[v0(v1)][v1] => share the space equally
self.addConstraintsWithFormat(format: "H:|[v0(v1)][v1]|", views: likeButton, commentButton)
```

ℹ️  Swift, format language equal space, more than three elements

```swift
//[v0(v1)][v1] => share the space equally
self.addConstraintsWithFormat(format: "H:|[v0(v2)][v1(v2)][v2]|", views: likeButton, commentButton, shareButton)
```

### iOS, collectionView, handle orientation

```swift
/*** Handle Orientation ***/
override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
    collectionView.collectionViewLayout.invalidateLayout()
}
```

# FeedController, Entire Code

```swift
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
        return CGSize(width: view.frame.width, height: 400)
    }
    
    /*** Handle Orientation ***/
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
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
                    NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 155, green: 161, blue: 161)
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
        
        self.addConstraintsWithFormat(format: "V:|-8-[v0(44)]-4-[v1(30)]-4-[v2]-8-[v3(24)]-8-[v4(0.4)][v5(44)]|",
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
```
# Lecture 3

[https://www.youtube.com/watch?v=ZwBYQpLQAvw&list=PL0dzCUj1L5JHDWIO3x4wePhD8G4d1Fa6N&index=2](https://www.youtube.com/watch?v=ZwBYQpLQAvw&list=PL0dzCUj1L5JHDWIO3x4wePhD8G4d1Fa6N&index=2)

### Swift, handle orientation for collectionview

```swift
/*** Handle Orientation ***/
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }
```

### Swift NSTextAttachment (with NSAttributedString)

```swift
//텍스트 옆에다 붙여줌.
let attachment = NSTextAttachment()
attachment.image = UIImage(systemName: "globe")
attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
attributedText.append(NSAttributedString(attachment: attachment))
```

### Get the amount of text , and decide height dynamically

```swift
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
        return CGSize(width: view.frame.width, height: rect.height)
    }
    
    return CGSize(width: view.frame.width, height: 500)
}
```

### Entire code

```swift
//
//  ViewController.swift
//  FacebookFeed
//
//  Created by shin seunghyun on 2020/07/14.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit

let cellId = "cellId"

class Post {
    var name: String?
    var profileImageName: String?
    var statusText: String?
    var statusImageName: String?
    var numLikes: Int?
    var numComments: Int?
}

class FeedController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let postGhandi = Post()
        postGhandi.name = "Ghandi"
        postGhandi.statusText = "Meanwhile, Best turned to the dark side."
        postGhandi.profileImageName = "ghandi"
        postGhandi.numLikes = 150
        postGhandi.numComments = 175
        postGhandi.statusImageName = "ghandi_content"
        
        let postSteve = Post()
        postSteve.name = "Steve Jobs"
        postSteve.statusText = "Design is not just what it looks like and feels like. Design is how it works.\n\n" +
            "Being the richest man in the cemetery doesn't matter to me. Going to bed at night saying we've done something wonderful, that's what matters to me.\n\n" +
            "Sometimes when you innovate, you make mistakes. It is best to admit them quickly, and get on with improving your other innovations."
        postSteve.profileImageName = "steve"
        postSteve.numLikes = 186
        postSteve.numComments = 132
        postSteve.statusImageName = "steve_content"
        
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
            
            if let statusImageName = post?.statusImageName {
                statusImageView.image = UIImage(named: statusImageName)
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
```
# Lecture - 4

# Using Dictionary Array

### Facebook Image URL Caching

```swift
/* Image Cache Array, This is global variable */
var imageCache = [String: UIImage]()

//getting image from server
if let statusImageURL = post?.statusImageURL {
    
    /* Image Cache */
    if let image = imageCache[statusImageURL] {
        statusImageView.image = image
    } else {
        if let url: URL = URL(string: statusImageURL) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let data = data {
                    let image = UIImage(data: data)
                    
                    /* Image Cache, imageURL을 key값으로 잡고 이미지를 저장 */
                    imageCache[statusImageURL] = image
                    
                    DispatchQueue.main.async {
                        self.statusImageView.image = image
                    }
                }
            }.resume()
        }
    }
}
```

### One way to handle image cache

```swift
/* image cache */
override func didReceiveMemoryWarning() {
    imageCache = nil
}
```

# Using NSCache

### NSCache, UserDefaults처럼 사용하면 됨, key - value

```swift
/* Image Cache Array */
var imageCache = NSCache<NSString, UIImage>()

//getting image from server
if let statusImageURL = post?.statusImageURL {
    /* Image Cache */
    if let image = imageCache.object(forKey: NSString(string: statusImageURL)) {
        statusImageView.image = image
    } else {
        if let url: URL = URL(string: statusImageURL) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let data = data {
                    if let image = UIImage(data: data) {
                        imageCache.setObject(image, forKey: NSString(string: statusImageURL))
                        DispatchQueue.main.async {
                             self.statusImageView.image = image
                        }
                    }
                }
            }.resume()
        }
    }
}
```

# USING, URLCache

```swift
//cache initialzation, cahcing을 알아서 해줌
let memoryCapacity = 500 * 1024 * 1024
let diskCapacity = 500 * 1024 * 1024
let urlCache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "myDiskPath")
URLCache.shared = urlCache
```

⇒ URL 전체를 알아서 handling
