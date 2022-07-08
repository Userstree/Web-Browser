//
// Created by Dossymkhan Zhulamanov on 08.07.2022.
//

import Foundation
import CoreData


class CoreDataProvider {
    private(set) var managedObjectContext: NSManagedObjectContext
    private weak var fetchedResultsControllerDelegate: NSFetchedResultsControllerDelegate?

    init(with managedObjectContext: NSManagedObjectContext,
         fetchedResultsControllerDelegate: NSFetchedResultsControllerDelegate?)
    {
        self.managedObjectContext = managedObjectContext
        self.fetchedResultsControllerDelegate = fetchedResultsControllerDelegate
    }

    lazy var fetchedResultsController: NSFetchedResultsController<> = {
        let fetchRequest: NSFetchRequest<> = .fetchRequest()

        let controller = NSFetchedResultsController(
                fetchRequest: fetchRequest, managedObjectContext: managedObjectContext,
                sectionNameKeyPath: nil,
                cacheName: nil)
        controller.delegate = fetchedResultsControllerDelegate

        do {
            try controller.performFetch()
        } catch {
            print("Fetch failed")
        }

        return controller
    }()
}