//
//  MapRouter.swift
//  Hikr
//
//  Created by Jan Bjelicic on 15/02/2021.
//

import UIKit
import HikrNetworking

class MapRouter: BaseRouter {
    
    // MARK: - Views
    
    // MARK: - Alert
    func presentNoLocationPermissionAlert() {
        let alert = UIAlertController(title: R.string.localizable.alertInfoTitle(),
                                      message: R.string.localizable.mapNoLocationPermissionAlertText(),
                                      preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: R.string.localizable.alertCancel(), style: .cancel)
        alert.addAction(cancelAction)
        
        let settingsAction = UIAlertAction(title: R.string.localizable.alertSettings(), style: .default) { _ in
            if let settingsUrl = URL(string: UIApplication.openSettingsURLString),
               UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
            } else {
                Logger.storage.log("Settings url invalid.", osLogType: .error)
            }
        }
        alert.addAction(settingsAction)
        viewController.present(alert, animated: true)
    }
    
}
