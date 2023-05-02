import Foundation
import CoreData

@objc(TestCloudKitUniqueIDMigrationPolicy)
public final class UniqueIDMigrationPolicy: NSEntityMigrationPolicy {
    
    public override func createDestinationInstances(forSource sInstance: NSManagedObject, in mapping: NSEntityMapping, manager: NSMigrationManager) throws {
        guard sInstance.entity.name == "Item" else { return }
        
        let oldTimestamp = sInstance.primitiveValue(forKey: "timestamp") as? Date
        
        let newInstance = NSEntityDescription.insertNewObject(forEntityName: "Item", into: manager.destinationContext)
        newInstance.setValue(oldTimestamp, forKey: "timestamp")
        newInstance.setValue(UUID(), forKey: "uniqueID")
        
        manager.associate(sourceInstance: sInstance, withDestinationInstance: newInstance, for: mapping)
        print(">>> \(#function)")
    }
}
