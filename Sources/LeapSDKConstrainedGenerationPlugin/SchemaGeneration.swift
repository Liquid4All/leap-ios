import Foundation
import SwiftSyntax
import SwiftSyntaxMacros

func generateJSONSchema(
  for declaration: some DeclGroupSyntax,
  typeName: String,
  description: String,
  in context: some MacroExpansionContext
) throws -> String {

  var properties: [String: [String: Any]] = [:]
  var required: [String] = []

  // Analyze stored properties
  let memberList = declaration.memberBlock.members

  for member in memberList {
    guard let varDecl = member.decl.as(VariableDeclSyntax.self),
      let binding = varDecl.bindings.first,
      let identifier = binding.pattern.as(IdentifierPatternSyntax.self)?.identifier,
      let type = binding.typeAnnotation?.type
    else {
      continue
    }

    // Skip computed properties (those with accessors)
    if binding.accessorBlock != nil {
      continue
    }

    // Skip static properties
    if varDecl.modifiers.contains(where: { $0.name.text == "static" }) {
      continue
    }

    let propertyName = identifier.text
    let (jsonType, isOptional) = mapSwiftTypeToJSONType(type)

    var propertySchema: [String: Any] = ["type": jsonType]

    // Handle array types - add items schema
    if jsonType == "array" {
      if let arrayType = extractArrayElementType(from: type) {
        let (elementType, _) = mapSwiftTypeToJSONType(arrayType)
        propertySchema["items"] = ["type": elementType]
      }
    }

    // Extract @Guide description if present
    if let guideDescription = extractGuideDescription(from: varDecl) {
      propertySchema["description"] = guideDescription
    }

    properties[propertyName] = propertySchema

    if !isOptional {
      required.append(propertyName)
    }
  }

  let schemaDict: [String: Any] = [
    "type": "object",
    "title": typeName,
    "description": description,
    "properties": properties,
    "required": required,
  ]

  // Convert to JSON string with pretty printing
  let jsonData = try JSONSerialization.data(
    withJSONObject: schemaDict, options: [.prettyPrinted, .sortedKeys])
  return String(data: jsonData, encoding: .utf8) ?? "{}"
}

// Helper to extract array element type
func extractArrayElementType(from type: TypeSyntax) -> TypeSyntax? {
  let typeDescription = type.description.trimmingCharacters(in: .whitespaces)

  // Handle [Type] syntax
  if typeDescription.hasPrefix("[") && typeDescription.hasSuffix("]") {
    let innerType = String(typeDescription.dropFirst().dropLast())
    return TypeSyntax(stringLiteral: innerType)
  }

  // Handle Array<Type> syntax
  if typeDescription.hasPrefix("Array<") && typeDescription.hasSuffix(">") {
    let innerType = String(typeDescription.dropFirst(6).dropLast())
    return TypeSyntax(stringLiteral: innerType)
  }

  return nil
}
