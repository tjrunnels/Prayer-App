// swiftlint:disable all
import Amplify
import Foundation

public struct Prayer: Model {
  public let id: String
  public var title: String
  public var description: String?
  public var image: String?
  public var badges: [String]?
  public var Answers: List<Answer>?
  public var groupID: String
  public var userID: String
  public var update: [String]?
  
  public init(id: String = UUID().uuidString,
      title: String,
      description: String? = nil,
      image: String? = nil,
      badges: [String]? = [],
      Answers: List<Answer>? = [],
      groupID: String,
      userID: String,
      update: [String]? = []) {
      self.id = id
      self.title = title
      self.description = description
      self.image = image
      self.badges = badges
      self.Answers = Answers
      self.groupID = groupID
      self.userID = userID
      self.update = update
  }
}