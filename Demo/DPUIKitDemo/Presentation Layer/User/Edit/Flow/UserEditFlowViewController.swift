//
//  UserEditFlowViewController.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 22.02.2022.
//

import Foundation
import DPUIKit
import UIKit

class UserEditFlowViewController: DPFlowViewController {
    
    // MARK: - Init
    init(model: UserEditFlowViewModel, useParentNavigation navigation: UINavigationController?) {
        super.init()
        
        self.parentNavigation = navigation
        self.model = model
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Props
    private lazy var flowNavigationController: DPNavigationController = .init()
    private weak var parentNavigation: UINavigationController?
    
    private var model: UserEditFlowViewModel? {
        get { self._model as? UserEditFlowViewModel }
        set { self._model = newValue }
    }
    
    var didUserEdited: DataClosure<UserModel>?
    
    // MARK: - Methods
    override func setupComponents() {
        super.setupComponents()
        
        if self.navigationController == nil {
            self.rootViewController = self.flowNavigationController
        }
        
        self.beginFlow()
    }
    
    override func beginFlow() {
        let vc = UserEditInfoViewController(model: .init(user: self.model?.user))
        vc.didTapDone = { [weak self] user in
            print("!!! didTapDone", self)
            self?.model?.user = user
            self?.showEditAbout()
        }
        
        let navigation = self.getFlowNavigationController()
        navigation.pushViewController(vc, animated: navigation.viewControllers.count > 0)
    }
    
    func showEditAbout() {
        let vc = UserEditAboutViewController(model: .init(user: self.model?.user))
        vc.didTapDone = { [weak self] user in
            self?.model?.user = user
            self?.finishFlow()
        }
        
        self.getFlowNavigationController().pushViewController(vc, animated: true)
    }
    
    override func finishFlow() {
        if let user = self.model?.user {
            self.didUserEdited?(user)
        }
        
        super.finishFlow()
    }
    
    private func getFlowNavigationController() -> UINavigationController {
        self.parentNavigation ?? self.flowNavigationController
    }
    
}
