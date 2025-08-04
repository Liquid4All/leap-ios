import Foundation

/// Utility for accessing JSON schemas from GeneratableType conforming types
public enum JSONSchemaGenerator {
  /// Get JSON schema for a GeneratableType conforming type
  public static func getJSONSchema<T: GeneratableType>(for type: T.Type) throws -> String {
    return try type.jsonSchema()
  }
}
