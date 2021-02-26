// swiftlint:disable all
import Amplify
import Foundation

extension Answer {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case content
    case prayerID
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let answer = Answer.keys
    
    model.authRules = [
      rule(allow: .owner, ownerField: "owner", identityClaim: "cognito:username", operations: [.read, .create, .update, .delete])
    ]
    
    model.pluralName = "Answers"
    
    model.fields(
      .id(),
      .field(answer.content, is: .optional, ofType: .string),
      .field(answer.prayerID, is: .required, ofType: .string)
    )
    }
}