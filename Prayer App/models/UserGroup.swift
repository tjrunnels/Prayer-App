// swiftlint:disable all
import Amplify
import Foundation

public struct UserGroup: Model {
  public let id: String
  public var group: Group
  public var user: User
  
  public init(id: String = UUID().uuidString,
      group: Group,
      user: User) {
      self.id = id
      self.group = group
      self.user = user
  }
}