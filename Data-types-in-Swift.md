# Data types in Swift

[All notes taken from pluralsight's course.](https://app.pluralsight.com/library/courses/swift-first-look/table-of-contents)

 ..*[Constants & Variables](#Constants)
 
 ..*[Optionals](#Optionals)
 
 ..*[Classes & Objects](#Class)
 
  ..*[Functions & Closures](#Functions)
  
  ..*[Methods](#Methods)
  
  ..* [Structures](#Structures)
  
  ..* [Enumerations](#Enumerations)

..* [Tuples & Optionals](#Tuples)

 ..* [Protocols](#Protocols)

..* [Extensions](#Extensions)

 ..* [Constants & Variables](#Constants)

```swift
var s1 = "Hello, "
let s2 = "World!"
```
var for mutable, you can change s1
let for immutable, you can not change s2

var ile yaratılan değişkenleri değiştirilebilirsiniz fakat let ile yaratılan sabitler değiştirilemez.

```swift

s1 += s2
print(s1)
hello World!

s2 += s1
error: left side of mutating operator isn't mutable: 's2' is a 'let' constant
s2 += s1
~~ ^

repl.swift:2:1: note: change 'let' to 'var' to make it mutable
let s2 = " World!"
^~~
var
```

## <a name="Optionals"></a> Optionals

```swift

var s1: String
var s2: String?  
var s3: String!
```

["Metin kutusu gibi bir yerden değer geliyorsa mutlaka opsiyonel tanımı yapılır. Çünkü değer gelip gelmeyeceğini bilemeyiz. Opsiyonel tanımlamak için değişken ya da sabitin sahip olacağı veri türünün yanına bir soru işareti — ? — koyarız. Örneğin bir Int? tanımlayarak şunu demek istiyoruz: Bu değişken ya da sabit Int türünden bir değer içerebilir ama hiç bir şey içermeyedebilir."](https://medium.com/mobil-dev/swift-dili-ve-opsiyonel-kavramı-410586abe4ae)

## <a name="Classes"></a> Classes & Objects

```swift
class Person {
  var firstName: String
  var lastName: String

  init(firstName: String, lastName: String) {
    self.firstName = firstName
    self.lastName = lastName
  }
}
```

## <a name="Functions"></a> Functions & Closures

```swift
func printPerson(p: Person) -> Void {
  print("Person is \(p.firstName) \(p.lastName)")
}

let stooges = ["Larry", "Moe", "Curly"]
stooges.filter({(name: String) -> Bool in
    return name.hasPrefix("L")
})

```

## <a name="Methods"></a> Methods

*Methods can reference the associated type or instace via self*

*First argument to method gets a default local name*

*Subsequent arguments get local and external names*

```swift
class Person {
    var firstName: String = ""
    var lastName: String = ""

    init(firstName: String, lastName: String) {
      self.firstName = firstName
      self.lastName = lastName
    }

    func say(phrase: String) {
      print("\(self.firstName) \(self.lastName) says: '\(phrase)'")
    }

    func say(phrase: String, times: Int) {
      for i in 0..times {
        say(phrase)
      }
    }
}

let p = Person(firstName: "Alex", lastName: "Vollmer")
p.say("Hi")
p.say("Hello", times: 3)
```

## <a name="Structures"></a> Structures

*Relatively simple data*
..*No need for the "ceremony" of classes & objects*

*Data will be copied instead of referenced*
..*Sometimes copying is just what you want*

*Encapsulated data are all value types*
..*Why not make the container a vaule type too?*



```swift
class Person {
    var firstName: String = ""
    var lastName: String = ""

    init(firstName: String, lastName: String) {
      self.firstName = firstName
      self.lastName = lastName
    }

struct Dude {
  var firstName: String
  var lastName: String
}

let p1 = Person(firstName: "Alex", "Vollmer")
let p2 = p1
print("p1 is \(p1.firstName) \(p1.lastName), p2 is \(p2.firstName) \(p2.lastName)")
// output is p1 is Alex Vollmer, p2 is Alex Vollmer

p1.firstName = "William"
p1.lastName = "Shakespeare"
print("p1 is \(p1.firstName) \(p1.lastName), p2 is \(p2.firstName) \(p2.lastName)")
// output is p1 is William Shakespeare, p2 is William Shakespeare

let d1 = Person(firstName: "Alex", "Vollmer")
let d2 = d1
print("d1 is \(d1.firstName) \(d1.lastName), d2 is \(d2.firstName) \(d2.lastName)")
// output is d1 is Alex Vollmer, d2 is Alex Vollmer

d1.firstName = "William"
d1.lastName = "Shakespeare"
print("d1 is \(d1.firstName) \(d1.lastName), d2 is \(d2.firstName) \(d2.lastName)")
// output is d1 is William Shakespeare, d2 is Alex Vollmer
```

## <a name="Enumerations"></a> Enumerations

```swift

enum CardType: String {
    case None = "None"
    case Visa = "Visa"
    case AmericanExpress = "American Express"
    case MasterCard = "MasterCard"
    case Discover = "Discover"

    private func regularExpression() -> NSRegularExpression {
        switch self {
        case .Visa:
            return NSRegularExpression(pattern: "^4[0-9]{12}(?:[0-9]{3})?$", options: nil, error: nil)
        case .AmericanExpress:
            return NSRegularExpression(pattern: "^3[47][0-9]{13}$", options: nil, error: nil)
        case .MasterCard:
            return NSRegularExpression(pattern: "^5[1-5][0-9]{14}$", options: nil, error: nil)
        case .Discover:
            return NSRegularExpression(pattern: "^6(?:011|5[0-9]{2})[0-9]{12}$", options: nil, error: nil)
        default:
            return NSRegularExpression(pattern: ".*", options: nil, error: nil)
        }
    }

    func isValidFor(cardNumber: String) -> Bool {
        let re = self.regularExpression()
        let range = NSRange(0..<cardNumber.lengthOfBytes(using: NSUTF8StringEncoding))
        let matches = re.numberOfMatchesInString(cardNumber, options: nil, range: range)
        return matches > 0
    }
    static let allValues = [Visa, AmericanExpress, MasterCard, Discover]

    static func from(cardNumber: String) -> CardType {
        for type in self.allValues {
            if type.isValidFor(cardNumber: cardNumber){
                return type
            }
        }
        return None
    }

}

CardType.Visa.isValidFor("42424242424242") // output is true
CardType.from("42424242424242").toRaw() // output is Visa
```

## <a name="Tuples"></a> Tuples & Optionals

```swift

var s1 = (code:404, msg: "Not Found")

s1.code or s1.0 //returns 404
s1.msg  or s1.1 //returns "Not Found"

(Int, String)
//nothing is nil
(Int?, String?)
//int and string can be nil but tuples can't
(Int, String)?
//int and string can't be nil but tuples can
```

#### why Tuples?

```swift

let result = CoolService.doSomethingCool()
if result.error != nil {
  print("Uh-oh, error: \(resut.error)")
}
else {
  print("The result is \(result.value)")
}
```

*great for return values*

*unneed for arguments*

*Short-lived, Temporary*


## <a name="Protocols"></a> Protocols

```swift


protocol Tuneable {
  var pitch: Double {get}
  func tuneSharp()
  func tuneFlat()
  }

class Guitar: Tuneable {
  var pitch: Double = 440

  func tuneSharp() {
    print("increasing string tension...")
    self.pitch += 5
  }

  func tuneFlat() {
    print("decreasing string tension...")
    self.pitch -= 5
  }
}


class Saxophone: Tuneable {
  var pitch: Double = 440

  func tuneSharp() {
    print("pushing mouthpiece in...")
    self.pitch += 1
  }

  func tuneFlat() {
    print("pulling mouthpiece out...")
    self.pitch -= 1
  }
}

let guitar = Guitar()
let sax = Saxophone()
let instruments: [Tuneable] = [guitar, sax]

for i in instruments {
i.tuneSharp()
}

```

#### Second example about Protocols

```swift

@objc protocol Tuneable {
  var pitch: Double {get}
  func tuneSharp()
  func tuneFlat()
  optional func transpose(hertz: Double)
  //when using optional you must add @objc to protocol
}

class Guitar: Tuneable {
  var pitch: Double = 440

  func tuneSharp() {
    print("increasing string tension...")
    self.pitch += 5
  }

  func tuneFlat() {
    print("decreasing string tension...")
    self.pitch -= 5
  }

  func transpoze(hertz: Double) {
    pitch += hertz
  }
}


class Saxophone: Tuneable {
  var pitch: Double = 440

  func tuneSharp() {
    print("pushing mouthpiece in...")
    self.pitch += 1
  }

  func tuneFlat() {
    print("pulling mouthpiece out...")
    self.pitch -= 1
  }
}

let guitar = Guitar()
let sax = Saxophone()
let instruments: [Tuneable] = [guitar, sax]

for i in instruments {
i.tuneSharp()
i.transpoze?(20)
// '?'  as you see just Guitar has transpoze func
}
```

## <a name="Extensions"></a> Extensions

*Add computed properties*

*Define new methods*

*Define nested types*

*Protocol comformance*

*No overriding*

```swift
extension String {
  func reverse() -> String {
      let chars = Array(self).reverse()
      var reserved = ""
      for char in chars {
          reversed.append(char)
      }
      return reversed
  }
}

let name = "Alex Vollmer"
name.reverse()
```
