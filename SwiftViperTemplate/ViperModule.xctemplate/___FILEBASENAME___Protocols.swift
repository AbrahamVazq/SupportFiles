//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//  ViperTemplate v.0.0.1 - (2023, NS-Bionick Development Team)

import Foundation

// MARK: VIEW -> PRESENTER
protocol ___VARIABLE_ModuleName____ViewToPresenterProtocol: AnyObject {
	var view: ___VARIABLE_ModuleName____PresenterToViewProtocol? { get set }
	var interactor: ___VARIABLE_ModuleName____PresenterToInteractorProtocol? { get set }
	var router: ___VARIABLE_ModuleName____PresenterToRouterProtocol? { get set }
}

// MARK: PRESENTER -> INTERACTOR
protocol ___VARIABLE_ModuleName____PresenterToInteractorProtocol: AnyObject {
    var presenter: ___VARIABLE_ModuleName____InteractorToPresenterProtocol? { get set }
}

// MARK: INTERACTOR -> PRESENTER
protocol ___VARIABLE_ModuleName____InteractorToPresenterProtocol: AnyObject {
}

// MARK: PRESENTER -> VIEW
protocol ___VARIABLE_ModuleName____PresenterToViewProtocol: AnyObject {
    var presenter: ___VARIABLE_ModuleName____ViewToPresenterProtocol? { get set }
}

// MARK: PRESENTER -> ROUTER
protocol ___VARIABLE_ModuleName____PresenterToRouterProtocol: AnyObject {
}
