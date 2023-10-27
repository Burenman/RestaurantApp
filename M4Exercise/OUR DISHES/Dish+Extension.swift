import Foundation
import CoreData

extension Dish {
    
    static func createDishesFrom(menuItems:[MenuItem],
                                    _ context:NSManagedObjectContext) {
           for menuItem in menuItems {
               guard let _ = exists(name: menuItem.title, context) else {
                   continue
               }
               let oneDish = Dish(context: context)
               oneDish.name = menuItem.title
               if let price = Float(menuItem.price) {
                   oneDish.price = price
               }
           }
       }
}
