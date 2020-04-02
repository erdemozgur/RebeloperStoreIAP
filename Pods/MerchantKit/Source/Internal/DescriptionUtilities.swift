extension CustomStringConvertible {
    internal func defaultDescription(typeName: String = "", withProperties properties: (String, Any)...) -> String {
        let formattedProperties: [String] = properties.map { property in
            let (name, value) = property
            
            guard !name.isEmpty else {
                return "\(value)"
            }
            
            return "\(name): \(value)"
        }
        
        let typeName = typeName.isEmpty ? "\(type(of: self))" : typeName
        let description = "[\(typeName) \(formattedProperties.joined(separator: ", "))]"
        
        return description
    }
}
