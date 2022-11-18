//
//  AppDelegate.swift
//  FetchRewards
//
//  Created by LanceMacBookPro on 11/16/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = setRootVC()
        
        window?.makeKeyAndVisible()
        
        return true
    }
}

extension AppDelegate {
    
    func setRootVC() -> UINavigationController {
        
        let endpoint = Endpoint(path: APIConstants.endpointFilterPath,
                                queryDict: [APIConstants.dessertQueryKey : APIConstants.dessertQueryValue])
        
        let homeViewModel = HomeViewModel(endpointURL: endpoint.url)
        
        let homeVC = HomeController(homeViewModel: homeViewModel)
        
        let navVC = UINavigationController(rootViewController: homeVC)
        
        return navVC
    }
    
}
