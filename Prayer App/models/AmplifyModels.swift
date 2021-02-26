// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "9a23a03aeea7ce49d2c2d32a842d4c44"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: Answer.self)
    ModelRegistry.register(modelType: Group.self)
    ModelRegistry.register(modelType: UserGroup.self)
    ModelRegistry.register(modelType: User.self)
    ModelRegistry.register(modelType: Prayer.self)
  }
}