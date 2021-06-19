//
//  ViewController.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 24.03.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tabBarPromoButton: UIButton!
    @IBOutlet weak var componentsButton: UIButton!
    @IBOutlet weak var tilesCollectionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func goToTabBarPromo(_ sender: UIButton) {
        let customTabBarController = TabBarController(items: [CustomTabBarItem(viewModel: TabBarItemModel.menu), CustomTabBarItem(viewModel: TabBarItemModel.profile), CustomTabBarItem(viewModel: TabBarItemModel.extra), CustomTabBarItem(viewModel: TabBarItemModel.cart), CustomTabBarItem(viewModel: TabBarItemModel.about)])
        
        self.navigationController?.pushViewController(customTabBarController, animated: true)
    }
    
    @IBAction func goToComponents(_ sender: UIButton) {
        let generalComponentsVC = GeneralComponentsViewController()
        
        self.navigationController?.pushViewController(generalComponentsVC, animated: true)
    }
    
    @IBAction func goToTilesCollection(_ sender: Any) {
        let tilesCollection = TilesViewControllerImpl()
        
        self.navigationController?.pushViewController(tilesCollection, animated: true)
    }

    @IBAction func goToMemoryCardGame(_ sender: UIButton) {
        let memoryGame = MemoryCardGameViewController()
        
        self.navigationController?.pushViewController(memoryGame, animated: true)
    }
}

