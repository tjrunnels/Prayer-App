// swiftlint:disable all
import Amplify
import Foundation

public struct Answer: Model {
  public let id: String
  public var content: String?
  public var prayerID: String
  
  public init(id: String = UUID().uuidString,
      content: String? = nil,
      prayerID: String) {
      self.id = id
      self.content = content
      self.prayerID = prayerID
  }
}