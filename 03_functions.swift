// functions.swift
// Example demonstrating Swift functions

// Print title
print("Swift Functions")
print("==============\n")

// --------------
// Basic Function
// --------------

// Function with no parameters and no return value
func displayWelcomeMessage() {
    print("Welcome to Swift Functions!")
}

// Call the function
displayWelcomeMessage()

// --------------
// Function with Parameters
// --------------

// Function with two parameters
func greet(name: String, time: String) {
    print("\nGood \(time), \(name)!")
}

// Call the function with arguments
greet(name: "Student", time: "morning")

// --------------
// Function with Return Value
// --------------

// Function that returns a value
func calculateAverage(numbers: [Int]) -> Double {
    let sum = numbers.reduce(0, +)
    return Double(sum) / Double(numbers.count)
}

// Use the function
let scores = [85, 92, 78, 90, 88]
let average = calculateAverage(numbers: scores)
print("\nTest scores: \(scores)")
print("Average score: \(average)")

// --------------
// Default Parameter Values
// --------------

// Function with default parameter value
func generateGreeting(name: String, message: String = "Welcome to the course") -> String {
    return "\(message), \(name)!"
}

// Call with and without the default parameter
let greeting1 = generateGreeting(name: "Alice")
let greeting2 = generateGreeting(name: "Bob", message: "Glad to see you")

print("\nDefault parameters:")
print(greeting1)
print(greeting2)

// --------------
// Argument Labels
// --------------

// Function with different external and internal parameter names
func calculateDistance(from startPoint: Int, to endPoint: Int) -> Int {
    return abs(endPoint - startPoint)
}

// Using the external names in function call
let distance = calculateDistance(from: 10, to: 25)
print("\nDistance: \(distance)")

// Function with omitted argument label (using _)
func multiply(_ a: Int, by b: Int) -> Int {
    return a * b
}

// Call with omitted first argument label
let product = multiply(5, by: 6)
print("Product: \(product)")

// --------------
// Variadic Parameters
// --------------

// Function that takes variable number of parameters
func calculateSum(_ numbers: Int...) -> Int {
    return numbers.reduce(0, +)
}

// Call with different number of arguments
let sum1 = calculateSum(1, 2, 3)
let sum2 = calculateSum(10, 20, 30, 40, 50)
print("\nVariadic parameters:")
print("Sum of 1, 2, 3: \(sum1)")
print("Sum of 10, 20, 30, 40, 50: \(sum2)")

// --------------
// Inout Parameters
// --------------

// Function with inout parameter (allows modifying the original variable)
func doubleInPlace(number: inout Int) {
    number *= 2
}

// Use inout parameter
var myNumber = 25
print("\nBefore doubleInPlace: \(myNumber)")
doubleInPlace(number: &myNumber)  // Note the & symbol
print("After doubleInPlace: \(myNumber)")

// --------------
// Function Types
// --------------

// Functions are first-class types and can be assigned to variables
func add(a: Int, b: Int) -> Int {
    return a + b
}

func subtract(a: Int, b: Int) -> Int {
    return a - b
}

// Variables holding functions
var mathOperation: (Int, Int) -> Int = add
print("\nFunction types:")
print("Result of mathOperation(10, 5): \(mathOperation(10, 5))")

// Change the function
mathOperation = subtract
print("Result after changing mathOperation: \(mathOperation(10, 5))")

// --------------
// Function as Parameter
// --------------

// Function that takes another function as parameter
func applyOperation(_ a: Int, _ b: Int, operation: (Int, Int) -> Int) -> Int {
    return operation(a, b)
}

// Use a function as argument
let sum = applyOperation(15, 7, operation: add)
let difference = applyOperation(15, 7, operation: subtract)
print("\nUsing functions as parameters:")
print("Sum: \(sum)")
print("Difference: \(difference)")

// --------------
// Nested Functions
// --------------

// Function containing another function
func processNumbers(numbers: [Int], operation: String) -> Int {
    // Nested function
    func computeSum() -> Int {
        return numbers.reduce(0, +)
    }

    // Another nested function
    func computeMax() -> Int {
        return numbers.max() ?? 0
    }

    // Use the nested functions
    if operation == "sum" {
        return computeSum()
    } else {
        return computeMax()
    }
}

// Try the function with nested functions
let values = [4, 8, 15, 16, 23, 42]
let totalSum = processNumbers(numbers: values, operation: "sum")
let maximum = processNumbers(numbers: values, operation: "max")
print("\nNested functions:")
print("Values: \(values)")
print("Sum: \(totalSum)")
print("Maximum: \(maximum)")

// --------------
// Closures (Anonymous Functions)
// --------------

// Using a closure (anonymous function)
let square = { (number: Int) -> Int in
    return number * number
}

// Call the closure
print("\nClosures:")
print("Square of 8: \(square(8))")

// Closure as function parameter (more concise syntax)
let numbers = [4, 2, 6, 1, 3, 5]
let sortedNumbers = numbers.sorted { $0 < $1 }
print("Original numbers: \(numbers)")
print("Sorted numbers: \(sortedNumbers)")

// --------------
// Summary
// --------------

print("\nSummary of Swift Functions:")
print("- Functions are defined with the 'func' keyword")
print("- They can take parameters with or without external labels")
print("- Functions can return values using the -> syntax")
print("- Parameters can have default values")
print("- Functions can be assigned to variables and passed as parameters")
print("- Swift supports nested functions and closures")
