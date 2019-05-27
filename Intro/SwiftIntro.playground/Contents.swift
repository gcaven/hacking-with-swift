import UIKit

struct Person {
    var age: Int

    var ageInDogYears: Int {
        return age * 7
    }
}

var fan = Person(age: 15)
print(fan.ageInDogYears)
