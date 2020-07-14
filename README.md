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
