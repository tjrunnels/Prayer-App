// swiftlint:disable all
import Amplify
import Foundation

extension Group {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case name
    case GroupUsers
    case Prayers
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let group = Group.keys
    
    model.pluralName = "Groups"
    
    model.fields(
      .id(),
      .field(group.name, is: .optional, ofType: .string),
      .hasMany(group.GroupUsers, is: .optional, ofType: UserGroup.self, associatedWith: UserGroup.keys.group),
      .hasMany(group.Prayers, is: .optional, ofType: Prayer.self, associatedWith: Prayer.keys.groupID)
    )
    }
}