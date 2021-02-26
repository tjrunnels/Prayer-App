// swiftlint:disable all
import Amplify
import Foundation

extension UserGroup {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case group
    case user
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let userGroup = UserGroup.keys
    
    model.pluralName = "UserGroups"
    
    model.fields(
      .id(),
      .belongsTo(userGroup.group, is: .required, ofType: Group.self, targetName: "groupID"),
      .belongsTo(userGroup.user, is: .required, ofType: User.self, targetName: "userID")
    )
    }
}