import SwiftSyntax

func mapSwiftTypeToJSONType(_ type: TypeSyntax) -> (String, Bool) {
  let typeDescription = type.description.trimmingCharacters(in: .whitespaces)

  // Handle optionals
  if typeDescription.hasSuffix("?") {
    let baseType = String(typeDescription.dropLast())
    let (jsonType, _) = mapSwiftTypeToJSONType(TypeSyntax(stringLiteral: baseType))
    return (jsonType, true)
  }

  // Handle Optional<T>
  if typeDescription.hasPrefix("Optional<") && typeDescription.hasSuffix(">") {
    let innerType = String(typeDescription.dropFirst(9).dropLast())
    let (jsonType, _) = mapSwiftTypeToJSONType(TypeSyntax(stringLiteral: innerType))
    return (jsonType, true)
  }

  // Handle arrays
  if typeDescription.hasPrefix("[") && typeDescription.hasSuffix("]") {
    return ("array", false)
  }

  // Handle Array<T>
  if typeDescription.hasPrefix("Array<") && typeDescription.hasSuffix(">") {
    return ("array", false)
  }

  // Handle dictionaries
  if typeDescription.hasPrefix("[") && typeDescription.contains(":")
    && typeDescription.hasSuffix("]")
  {
    return ("object", false)
  }

  // Handle Dictionary<K, V>
  if typeDescription.hasPrefix("Dictionary<") && typeDescription.hasSuffix(">") {
    return ("object", false)
  }

  // Basic types
  switch typeDescription {
  case "String":
    return ("string", false)
  case "Int", "Int8", "Int16", "Int32", "Int64", "UInt", "UInt8", "UInt16", "UInt32", "UInt64":
    return ("integer", false)
  case "Float", "Double", "CGFloat":
    return ("number", false)
  case "Bool":
    return ("boolean", false)
  case "Date":
    return ("string", false)  // JSON doesn't have a date type, typically serialized as string
  case "Data":
    return ("string", false)  // Base64 encoded string
  case "URL":
    return ("string", false)  // URL as string
  case "UUID":
    return ("string", false)  // UUID as string
  default:
    // For custom types, assume they're objects
    return ("object", false)
  }
}
