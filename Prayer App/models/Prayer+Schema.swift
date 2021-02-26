// swiftlint:disable all
import Amplify
import Foundation

extension Prayer {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case title
    case description
    case image
    case badges
    case Answers
    case groupID
    case userID
    case update
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let prayer = Prayer.keys
    
    model.authRules = [
      rule(allow: .owner, ownerField: "owner", identityClaim: "cognito:username", operations: [.read, .create, .delete, .update])
    ]
    
    model.pluralName = "Prayers"
    
    model.fields(
      .id(),
      .field(prayer.title, is: .required, ofType: .string),
      .field(prayer.description, is: .optional, ofType: .string),
      .field(prayer.image, is: .optional, ofType: .string),
      .field(prayer.badges, is: .optional, ofType: .embeddedCollection(of: String.self)),
      .hasMany(prayer.Answers, is: .optional, ofType: Answer.self, associatedWith: Answer.keys.prayerID),
      .field(prayer.groupID, is: .required, ofType: .string),
      .field(prayer.userID, is: .required, ofType: .string),
      .field(prayer.update, is: .optional, ofType: .embeddedCollection(of: String.self))
    )
    }
}