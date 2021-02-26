// swiftlint:disable all
import Amplify
import Foundation

public struct User: Model {
  public let id: String
  public var username: String?
  public var location: String?
  public var fullName: String?
  public var UserGroups: List<UserGroup>?
  public var Prayers: List<Prayer>?
  
  public init(id: String = UUID().uuidString,
      username: String? = nil,
      location: String? = nil,
      fullName: String? = nil,
      UserGroups: List<UserGroup>? = [],
      Prayers: List<Prayer>? = []) {
      self.id = id
      self.username = username
      self.location = location
      self.fullName = fullName
      self.UserGroups = UserGroups
      self.Prayers = Prayers
  }
}