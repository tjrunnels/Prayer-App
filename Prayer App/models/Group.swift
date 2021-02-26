// swiftlint:disable all
import Amplify
import Foundation

public struct Group: Model {
  public let id: String
  public var name: String?
  public var GroupUsers: List<UserGroup>?
  public var Prayers: List<Prayer>?
  
  public init(id: String = UUID().uuidString,
      name: String? = nil,
      GroupUsers: List<UserGroup>? = [],
      Prayers: List<Prayer>? = []) {
      self.id = id
      self.name = name
      self.GroupUsers = GroupUsers
      self.Prayers = Prayers
  }
}