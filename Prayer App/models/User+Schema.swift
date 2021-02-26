// swiftlint:disable all
import Amplify
import Foundation

extension User {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case username
    case location
    case fullName
    case UserGroups
    case Prayers
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let user = User.keys
    
    model.pluralName = "Users"
    
    model.fields(
      .id(),
      .field(user.username, is: .optional, ofType: .string),
      .field(user.location, is: .optional, ofType: .string),
      .field(user.fullName, is: .optional, ofType: .string),
      .hasMany(user.UserGroups, is: .optional, ofType: UserGroup.self, associatedWith: UserGroup.keys.user),
      .hasMany(user.Prayers, is: .optional, ofType: Prayer.self, associatedWith: Prayer.keys.userID)
    )
    }
}