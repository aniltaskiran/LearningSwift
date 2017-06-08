

## Initializers

```swift
class Person {
  let firstName: String
  let lastName: String
```

```swift
  init(firstName: String, lastName: String) {
    self.firstName = firstName
    self.lastName = lastName
  }
```
##### or

```swift
  init(firstName: String ="John", lastName: String = "Doe") {
    self.firstName = firstName
    self.lastName = lastName
  }
```

##### or

```swift
  conveince init() {
  self.init(firstName: "John", lastName: "Doe")
  }
}
```

```swift
let p = Person(firstName: "Alex", lastName: Vollmer") // p -> Alex Vollmer
let p2 = Person() // p2 -> John Doe
let p3 = Person(firstName: "Jane") p3 -> Jane Doe
let p4 = Person(lastName: "Smith") p4 -> John Smith
```

## Subclassing & Initializers

- *Designated initializers delegate up*
- *Convenience initializers delegate across*

##### Initialization Phases

- **Phase 1:** Each property gets an initial value
      The class that introduces it is responsible

- **Phase 2:** Each class can customize properties
      This also includes any inherited properties

```swift
class Person {
  let firstName: String
  let lastName: String

  init(firstName: String, lastName: String) {
    self.firstName = firstName
    self.lastName = lastName
  }

  init() {
    self.firstName = "John"
    self.lastName = "Doe"
  }
}

let p1 = Person(firstName: "Bob", lastName: "Smith")
let p2 = Person()

class Student: Person {
  let age: Int

  init(firstName: String, lastName: String, age: Int) {
    self.age = age
    super.init(firstName: firstName, lastName: lastName)
  }

  init(age: Int) {
    self.age = age
    super.init()
  }

}

let chuck = Student(firstName: "Charlie", lastName: "Brown", age: 12)
let john = Student(age: 13)
```

- **1: *Designated* initializers are inherited if the subclass doesn't define any of its own**
- **2: *Convenience* initializers are inherited if the subclass has all of the superclass' designated intializers**

![logo]

[logo]: https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/initializersExample03_2x.png

## Properties

class Distance {
  let FEET_PER_METERS = 3.28084

  var meters: Double = 0
  var feet: Double {
      get {
        return self.meters * FEET_PER_METERS
      }
      set {
        self.meters = newValue / FEET_PER_METERS
      }
  }
  init(meters: Double) {
    self.meters = meters
  }
}

let dist = Distance(meters: 10)
dist.meters
dist.feet
dist.feet = 12
dist.meters

##### Property Observers

```swift
class Person {
  var firstName: String {
    willSet {
        print("Change firstName from \(firstName) to \(newValue)")
    }
    didSet {
      print("firstName updated from \(oldValue) to \(firstName)")
    }
  }
  var lastName: String {
    willSet(newLast) {
        print("Changing lastName from \(lastName) to \(newLast)")
    }
    didSet(oldLast) {
      print("Changed lastName from \(oldLast) to \(lastName)")
    }
  }
  init(firstName: String, lastName: String) {
      self.firstName = firstName
      self.lastName = lastName
  }
}

let p = Person(firstName: "William", lastName: "Shakespeare")
p.firstName = "Bill"
p.lastName = "Cody"

/* output is
Change firstName from William to Bill
firstName updated from William to Bill
Changing lastName from Shakespeare to Cody
Changed lastName from Shakespeare to Cody
*/
```

##### Lazy Properties

```swift
class DatabaseConnection {
  init() {
    print("New Database is up and running!")
  }

  func execute(statement: String) {
    print("EXECUTE: \(statement)")
  }
}

class DataStore {
  lazy var connection = DatabaseConnection()
}
let ds = DataStore()
// we create object but init func. did not work yet.
// When we write this code it will start
ds.connection.execute("SELECT * FROM users")
```

##### Complex Properties

```swift
class Calendar {
  var frenchMonths: [String] = {
    print("Calculating French months...") //should only see once
    let df = NSDateFormatter()
    df.locale = NSLocale(localeIdentifier: "fr_FR")
    return df.monthSymbols.map() { $0 as String}
  }()

  var japaneseMonths: [String]

  init() {
    print("Calculating Japanese months...")
    let df = NSDateFormatter()
    df.locale = NSLocale(localeIdentifier: "ja_JP")
    self.japaneseMonths = df.monthSymbols.map() { $0 as String }
  }
}

let cal = Calendar()
cal.frenchMonths
cal.japaneseMonths
```
## Overrides

```swift
class Person {
  let firstName: String
  let lastName: String
  var fullName: String {
      get {
        return "\(firstName) \(lastName)"
      }
  }

  init(firstName: String, lastName: String) {
    self.firstName = firstName
    self.lastName = lastName
  }
}

class Student: Person {
  override var fullName: String {
      get {
        return super.fullName.uppercaseString
      }
  }
}

var p = Person(firstName: "Alex", lastName: "Vollmer")
var s = Student(firstName: "Ferris", lastName: "Bueller")
p.fullName
s.fullName
```

## Polymorphism

```swift
@objc protocol MediaType {
  var contentType: String { get }
}

class Movie {
  enum Resolution: String {
      case TenEightyProgressive = "1080p"
      case SevenTwentyProgressive = "720p"
      case TenEightyInterlaced = "1080i"
  }

  var resolution: Resolution

  init(resolution: Resolution) {
    self.resolution = resolution  
  }
}

class MPEG4Movie: Movie, MediaType {
  var contentType: String { return "video/mp4" }
}

class QuicktimeMovie: Movie, MediaType {
  var contentType: String { return "video/quicktime" }
}

class Audio {
  var bitRate: Int
  init(bitRate: Int) {
    self.bitRate = bitRate
  }
}

class MP3: Audio, MediaType {
  var contentType: String { return "audio/mpeg" }
}

class Ogg: Audio, MediaType {
  var contentType: String { return "audio/ogg" }
}

let m1 = MPEG4Movie(resolution: .TenEightyInterlaced)
let m2 = QuicktimeMovie(resolution: .SevenTwentyProgressive)
let m3 = QuicktimeMovie(resolution: TenEightyInterlaced)

let a1 = MP3(bitRate: 128)
let a1 = Ogg(bitRate: 128)
let a1 = MP3(bitRate: 256)

let stuff = [m1, a3, m2, a2, m3, a1, "Foobar", 123, false] as [Any]


for thing in stuff {
    if thing is MediaType {
        let media = thing as! MediaType
        print("Media found: \(media.contentType)")
        if let movie = thing as? Movie {
        print(" Movie resolution is \(movie.resolution.rawValue)")
        }
        else if let sound = thing as? Audio {
            print(" Audio bit rate is \(sound.bitRate) kbps")
        }
        print("")
    }
    else {
        print("Unknown media: \(thing)")
    }
}
```

##### Value Type Polymorphism
