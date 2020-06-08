//
//  Injection.swift
//  Covid Pilot
//
//  Created by alopezh on 08/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation

import Swinject

class Injection {
    
    private let container: Container;
    
    init() {
        
        container = Container();
        
         // Data
        container.register(AppRouter.self) { _ in
            AppRouter()
        }.inObjectScope(.container)
    }
    
    func resolve<Service>(_ serviceType: Service.Type) -> Service? {
        return container.resolve(serviceType)
    }
}
