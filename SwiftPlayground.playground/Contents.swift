import UIKit

// Variable
var name: String = "Fabhotels"
name = "Swift"

// Constant
let rotations: Double = 3.125

// Types, Type-Safety and Type inference
// Types = String, Int, Double, Float, Bool
let isFinished = false // Type is Bool
let average = Int(rotations)  //Swift is type-safe (no auto conversion)


// Tuples
let point = (3, -5, 2.5)
let (x,y,z) = point // Yes, a struct or class can be better
print ("Value of x is \(x)")

// Optionals -> where the value may be absent, which will be nil in that case
var message: String? = nil // Improves type-safety, decreases runtime npe
message = "some message"
print(message?.count ?? 0) // optional unwrapping
print(message!.count) // forced unwrapping


/**
 Operators
 */
// arithmetic -> +,-,/, %
// comparision -> <, >, <=, ==, !=, === (same reference)
// ternary conditional -> a = isFinished ? "Bye" : "Hello"
// logical -> &&, ||, !
// nil coalescing operator ->  some_optional ?? default_value
// ranges -> check in control flow section

/* Collection Types */
// Array
let planets: [String] = ["Mercury", "Mars", "Jupiter"] // not String[], this is immutable
//planets.insert("Earth", at: 1)
var mutablePlanets = planets
mutablePlanets.insert("Earth", at: 1)
mutablePlanets[1] = "Prithvi"

// Dictionary
var teamScores: [String:Int] = ["India" : 2, "New Zealand" : 3, "England" : 1] // not {}
teamScores["Australia"] = 2


/**
 Control Flows
 */

// if statements
if (teamScores["South Africa"] == nil){
    print("South Africa is not playing in the tournament")
}else {
    print("South Africa is in!")
}
// optional binding

if let indiaScore = teamScores["India"] {
    // Executes only if "India", is present in teamScores map, also the value is set to indiaScore variable
    print("Score of India is \(indiaScore)")
}


// switch statements - must be exhaustive, no fall-through (that is multiple case statements, use comma or explicitly mention fallthrough keyword)
let age = 21
switch age {
    case 1...17:
        print("Beer is illegal for you")
    case 18...40, 50...99:
        print("Here is some beer for you")
    default:
        print("Beer is not healthy for you")
}

// where, to check extra condition in switch case
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
    case let (x, y) where x == y:
        print("(\(x), \(y)) is on the line x == y")
    case let (x, y) where x == -y:
        print("(\(x), \(y)) is on the line x == -y")
    case let (x, y):
        print("(\(x), \(y)) is just some arbitrary point")
}


// for loops
for planet in planets {
    print(planet)
}

planets.forEach { (planet) in
    // do something with planet
}

// Iterating dictionary
for (team,score) in teamScores {
    print("Score of \(team) is \(score)")
}


// Using ranges
for i in 1...10 { // inclusive of 1 and 10, closed range
    if (i==6){
        break
    }
}

// half-open range
let count = 5
for i in 0...(count-1) {
    i
}

// different increments and initialization
for i in stride(from: 10, to: 0, by: -3){
    print(i)
}

// while loops
var i = 10
while i>0 {
    print(i)
    i-=3
}

// do while loops
repeat {
    print(i)
    i+=1
} while(i<10)



/**
 Functions,
 
 In swift functions are first-class, meaning they can be treated as variables, passed around etc.. These are called closures (You can call them lambdas)
 */

func simpleAddFunction(x:Int, y:Int) -> Int {  // x,y are the paramter names
    return x+y
}

simpleAddFunction(x: 3, y: 4)

// Function with argument labels, can be omitted by using _
func powerFunction(base x:Double, exponent y:Double) -> Double {
    return pow(x,y)
}

powerFunction(base: 2, exponent: 10)

// Default values
func defaultValueFunc(_ name: String = "World"){
    print("Hello \(name)")
}

defaultValueFunc()

// Variadic parameters
func calculateAverage(_ nums: Double...) -> Double{
    // here nums will be an array of double values
    var total: Double = 0
    for number in nums {
       total += number
    }
    return total / Double(nums.count)
}

calculateAverage(1,2,3,4,5,100)
calculateAverage(1,3,4,100)

// In swift, parameters are passed by value so
// in-out parameters can be usesd to pass by reference
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var (a,b) = (3,5)
swapTwoInts(&a, &b)
print(a,b)

// Functions can also be parameters to functions and return types as well
// Closures (basically closed lambdas)
let compare: (Int,Int)->Bool = { (x,y) in x%y==0 }

var ints = [4,2,1,5,6,19,3]
ints.sorted(by: compare)
ints.sorted { (x, y) -> Bool in
    x>=y
}

// Classes and Structs
/**
 Structs basically are value types.
 
 Main differences between classes and structs

 * No Inhertance for structs, can implement protocols only
 * No Deinitializers
 * Structs are value types, where as classes are reference types (See example below)
 
 
 */
struct StructVehicle {
    private let topSpeed: Int
    private let model: String
    var currentSpeed = 0

    init(model:String, topSpeed: Int = 135) {
        self.topSpeed = topSpeed
        self.model = model
    }

    mutating func accelerate(by:Int = 5){

        self.currentSpeed += by

        if(self.currentSpeed+by>=topSpeed){
            self.currentSpeed = topSpeed
        }
    }

    func status(){
        print("Current speed of \(model) is \(currentSpeed)")
    }
}

class Vehicle {

    private let topSpeed: Int
    private let model: String
    final var currentSpeed: Int = 0

    init(model:String, topSpeed: Int = 135) {
        self.topSpeed = topSpeed
        self.model = model
    }
    
    func accelerate(by:Int = 5){
        
        self.currentSpeed += by
        
        if(self.currentSpeed+by>=topSpeed){
            self.currentSpeed = topSpeed
        }
    }
    
    func status(){
        print("Current speed of \(model) is \(currentSpeed)")
    }
    
    deinit {
        print("Performing deinit")
    }
}

var ferrari:Vehicle? = Vehicle(model: "Ferrari F50", topSpeed: 350)
ferrari?.accelerate()

ferrari = nil


// Inheritance
class Plane : Vehicle {
    
    private var elevation = 0
    
    // Overriding
    override func accelerate(by: Int = 5) {
        super.accelerate(by: by)
        
        if(by>0){
            elevation += 1
        }else{
            elevation -= 1
        }
    }
    
    override func status() {
        print("\(super.status()) and the elevation is \(elevation)")
    }
}

let airbus = Plane(model: "Airbus")
airbus.accelerate()
airbus.status()

// Inheritance and Initalization process - Go through this doc, which explains it more clearly
// https://docs.swift.org/swift-book/LanguageGuide/Initialization.html#ID216


// Other types of initalizers
/* Faliable initializers - Swift classes can have initializers which can return nil if object can be constructed.
// Ex- below */

class Student {
    
    private var firstName: String
    private var lastName: String
    private var age: Int
    
    init?(firstName:String, lastName:String, age: Int) {  // question mark at the end denotes failiable initalizer
        if (age < 1 ){
            return nil
        }
        self.age = age
        self.firstName = firstName
        self.lastName = lastName
    }
    
}

var student = Student(firstName: "John", lastName: "Doe", age: 0) // student will be nil

// Protocols - Essentially interfaces in swift
protocol ClickListener {
    
    var clickTime: Int { get set } // protocols can have computed property and no stored properties allowed
    
    func onClick() -> Int
}

/* Extensions
     * add computed properties or methods
     * add new methods
     * add new initialisers
     * Can also implement protocols
 */

extension Student {
    
    var isTeen: Bool { return age<=18 } // computed property
    
    convenience init?(fullName:String, age: Int) {
        let splits = fullName.split(separator: " ")
        self.init(firstName: String(splits[0]), lastName: String(splits[1]), age: age)
    }
    
    func getFullName() -> String {
        return firstName + lastName
    }
}


// Cheat Sheet (Complete summary)- https://koenig-media.raywenderlich.com/uploads/2019/11/RW-Swift-5.1-Cheatsheet-1.0.1.pdf
// Official guide - https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html









