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

