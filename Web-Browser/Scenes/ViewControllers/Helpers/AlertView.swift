//
// Created by Dossymkhan Zhulamanov on 07.07.2022.
//

import UIKit


protocol AlertViewPresentable {
    func presentAddWebSiteActivity(completion: @escaping (String, String) -> Void)
}

extension AlertViewPresentable where Self: UIViewController {
    func presentAddWebSiteActivity(completion: @escaping (String, String) -> Void) {
        let alertController = UIAlertController(title: "Add Website",message: nil, preferredStyle: .alert)

        alertController.addTextField { field in
            field.placeholder = "Type title for Website"
        }
        alertController.addTextField { field in
            field.placeholder = "Type the website URL"
        }

        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
            let titleTextField = alertController.textFields![0] as UITextField
            let detailsTextField = alertController.textFields![1] as UITextField
            if let title = titleTextField.text, let details = detailsTextField.text {
                completion(title, details)
            }
        })

        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)

        alertController.addAction(saveAction)
        alertController.addAction(cancel)
        alertController.view.addSubview(UIView())
        present(alertController, animated: false)
    }
}
