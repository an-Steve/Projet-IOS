// foundation.swift
// Example demonstrating Swift Foundation framework

// Import Foundation module
import Foundation

// Print title
print("Swift Foundation Framework")
print("========================\n")

// --------------
// Dates and Time
// --------------

// Get the current date and time
let currentDate = Date()
print("Current date: \(currentDate)")

// Format the date with DateFormatter
let dateFormatter = DateFormatter()
dateFormatter.dateStyle = .long
dateFormatter.timeStyle = .medium
let formattedDate = dateFormatter.string(from: currentDate)
print("Formatted date: \(formattedDate)")

// Create a specific date
var dateComponents = DateComponents()
dateComponents.year = 2025
dateComponents.month = 12
dateComponents.day = 31
dateComponents.hour = 23
dateComponents.minute = 59

let calendar = Calendar.current
if let futureDate = calendar.date(from: dateComponents) {
    print("Future date: \(dateFormatter.string(from: futureDate))")

    // Calculate time interval between dates
    let timeInterval = futureDate.timeIntervalSince(currentDate)
    let days = Int(timeInterval / (60 * 60 * 24))
    print("Days until future date: \(days)")
}

// --------------
// Number Formatting
// --------------

// Format numbers with NumberFormatter
let numberFormatter = NumberFormatter()
numberFormatter.numberStyle = .decimal
numberFormatter.maximumFractionDigits = 2

let price = 1234.56789
if let formattedPrice = numberFormatter.string(from: NSNumber(value: price)) {
    print("\nFormatted price: \(formattedPrice)")
}

// Currency formatting
let currencyFormatter = NumberFormatter()
currencyFormatter.numberStyle = .currency
currencyFormatter.locale = Locale(identifier: "en_US")

if let formattedCurrency = currencyFormatter.string(from: NSNumber(value: price)) {
    print("Formatted currency (USD): \(formattedCurrency)")
}

// Switch to a different locale
currencyFormatter.locale = Locale(identifier: "fr_FR")
if let formattedEuro = currencyFormatter.string(from: NSNumber(value: price)) {
    print("Formatted currency (EUR): \(formattedEuro)")
}

// --------------
// String Processing
// --------------

print("\nString processing:")

// Case conversion
let mixedCaseText = "Swift Programming LANGUAGE"
let lowercased = mixedCaseText.lowercased()
let uppercased = mixedCaseText.uppercased()

print("Original: \(mixedCaseText)")
print("Lowercased: \(lowercased)")
print("Uppercased: \(uppercased)")

// String searching
let sentence = "Swift is a powerful programming language for iOS development"
if sentence.contains("Swift") {
    print("\nThe sentence contains 'Swift'")
}

// Range of substring
if let range = sentence.range(of: "powerful") {
    print("'powerful' found at position: \(sentence.distance(from: sentence.startIndex, to: range.lowerBound))")
}

// Split string
let csvData = "Alice,25,Engineer,New York"
let components = csvData.split(separator: ",")
print("\nCSV components:")
for (index, component) in components.enumerated() {
    print("  \(index): \(component)")
}

// --------------
// URL Handling
// --------------

print("\nURL handling:")

// Create and manipulate URLs
if let url = URL(string: "https://www.example.com/api/data?format=json&limit=10") {
    print("URL: \(url)")
    print("Scheme: \(url.scheme ?? "none")")
    print("Host: \(url.host ?? "none")")
    print("Path: \(url.path)")
    print("Query: \(url.query ?? "none")")

    // Create a new URL by appending a path component
    let newURL = url.appendingPathComponent("users")
    print("New URL: \(newURL)")
}

// Local file URLs
let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
let fileURL = documentsURL.appendingPathComponent("data.txt")
print("\nDocuments directory: \(documentsURL)")
print("File URL: \(fileURL)")

// --------------
// JSON Handling
// --------------

print("\nJSON handling:")

// Create a Swift dictionary
let person = [
    "name": "John Smith",
    "age": 35,
    "email": "john@example.com",
    "isStudent": false,
    "courses": ["iOS Development", "Swift Basics"]
] as [String : Any]

// Convert to JSON data
do {
    let jsonData = try JSONSerialization.data(withJSONObject: person, options: .prettyPrinted)

    // Convert JSON data to string for display
    if let jsonString = String(data: jsonData, encoding: .utf8) {
        print("JSON data:\n\(jsonString)")
    }

    // Parse JSON data back to Swift objects
    if let parsedPerson = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any] {
        print("\nParsed from JSON:")
        if let name = parsedPerson["name"] as? String {
            print("Name: \(name)")
        }
        if let age = parsedPerson["age"] as? Int {
            print("Age: \(age)")
        }
        if let courses = parsedPerson["courses"] as? [String] {
            print("Courses: \(courses.joined(separator: ", "))")
        }
    }
} catch {
    print("Error processing JSON: \(error)")
}

// --------------
// File Operations
// --------------

print("\nFile operations:")

// Define file content and URL
let content = "This is some test content for our file."
let tempFileURL = documentsURL.appendingPathComponent("temp.txt")

// Write to file
do {
    try content.write(to: tempFileURL, atomically: true, encoding: .utf8)
    print("Successfully wrote to file: \(tempFileURL.path)")

    // Read from file
    let readContent = try String(contentsOf: tempFileURL, encoding: .utf8)
    print("Content read from file: \"\(readContent)\"")

    // File attributes
    let attributes = try FileManager.default.attributesOfItem(atPath: tempFileURL.path)
    if let size = attributes[.size] as? NSNumber {
        print("File size: \(size) bytes")
    }
    if let creationDate = attributes[.creationDate] as? Date {
        print("Creation date: \(dateFormatter.string(from: creationDate))")
    }

    // List directory contents
    let appSupportURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
    print("\nApplication support directory: \(appSupportURL.path)")

} catch {
    print("Error with file operations: \(error)")
}

// --------------
// Timer
// --------------

print("\nTimer example:")
print("This example would normally use a Timer, but for demonstration purposes we're just showing the code:")
print("""
let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
    print("Timer fired!")
    // Do something on each timer tick
}

// Later, to stop the timer:
// timer.invalidate()
""")

// --------------
// UUID Generation
// --------------

print("\nUUID generation:")
let uuid = UUID()
print("Generated UUID: \(uuid)")
print("UUID as string: \(uuid.uuidString)")

// --------------
// Summary
// --------------

print("\nSummary of Swift Foundation Features:")
print("- Date and Time handling with Date, Calendar, DateFormatter")
print("- Number formatting with NumberFormatter")
print("- String manipulation capabilities")
print("- URL creation and manipulation")
print("- JSON serialization and parsing")
print("- File system operations")
print("- Timers for delayed execution")
print("- UUID generation for unique identifiers")
