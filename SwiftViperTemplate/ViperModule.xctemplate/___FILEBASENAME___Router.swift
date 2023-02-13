//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//  ViperTemplate v.0.0.1 - (2023, NS-Bionick Development Team)

import UIKit

class ___VARIABLE_ModuleName___Router {
	
    static func createModule() -> UIViewController {
        
        let view = ___VARIABLE_ModuleName___ViewController()
        let presenter = ___VARIABLE_ModuleName___Presenter()
        let interactor = ___VARIABLE_ModuleName___Interactor()
        let router = ___VARIABLE_ModuleName___Router()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
}

extension ___VARIABLE_ModuleName___Router: ___VARIABLE_ModuleName____PresenterToRouterProtocol {
    
}
