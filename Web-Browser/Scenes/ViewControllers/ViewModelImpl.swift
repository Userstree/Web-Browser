//
// Created by Dossymkhan Zhulamanov on 09.07.2022.
//

import Foundation
import CoreData

class ViewModelImpl: ViewModel {
    private let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
    private let persistentContainer = AppDelegate.sharedAppDelegate.coreDataStack
    var websitesList: [Website] = []
    var favoriteWebSitesList: [Website] = []
    var coreDataObjects = [NSManagedObject]()

    private func loadSavedData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Websites")
        request.returnsObjectsAsFaults = false
        do {
            let result = try managedContext.fetch(request)
            coreDataObjects = result as! [NSManagedObject]
            for website in result as! [NSManagedObject] {
                let isLiked = website.value(forKey: "isLiked") as! Bool
                let title = website.value(forKey: "title") as! String
                let urlString = website.value(forKey: "urlString") as! String
                websitesList.append(Website(title: title, urlString: urlString, isLiked: isLiked))
                if isLiked {
                    favoriteWebSitesList.append(Website(title: title, urlString: urlString, isLiked: isLiked))
                }
            }
        } catch {
            print("Error fetching data")
        }
    }

    func append(website: Website) {
        websitesList.append(website)
        let entity = NSEntityDescription.entity(forEntityName: "Websites", in: managedContext)
        let newWebsite = NSManagedObject(entity: entity!, insertInto: managedContext)
        newWebsite.setValue(website.title, forKey: "title")
        newWebsite.setValue(website.urlString, forKey: "urlString")
        newWebsite.setValue(website.isLiked, forKey: "isLiked")
        persistentContainer.saveContext()
    }

    func likeTapped(index: Int, isLiked: Bool) {
        let website = websitesList[index]
        if isLiked == true {
            favoriteWebSitesList.append(Website(title: website.title, urlString: website.urlString, isLiked: true))
        } else {
            favoriteWebSitesList.popLast()
            remove(website: website)
        }
//        append(website: Website(title: website.title, urlString: website.urlString, isLiked: isLiked))
    }

    func remove(website: Website) {
        websitesList = websitesList._filter {
            $0 !== website
        }
        var index: Int = 0
        for (objectIndex, object) in coreDataObjects.enumerated() {
            let title = object.value(forKey: "title") as! String
            if website.title == title {
                index = objectIndex
            }
        }
        managedContext.delete(coreDataObjects[index])
        persistentContainer.saveContext()
    }

    init() {
        loadSavedData()
    }
}
