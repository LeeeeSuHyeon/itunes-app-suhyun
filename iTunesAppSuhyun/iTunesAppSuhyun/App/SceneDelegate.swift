//
//  SceneDelegate.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/7/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .white

        let container = DIContainer()
        window?.rootViewController = UINavigationController(rootViewController: container.makeHomeViewController()) 
        window?.makeKeyAndVisible()
    }
}
