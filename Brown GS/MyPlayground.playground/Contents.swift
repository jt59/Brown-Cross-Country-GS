import UIKit

let time = 90.04
let minutes = Int(time / 60)
let seconds = Int(time - Double(minutes) * 60)
let tenths = Int(round((time - Double(minutes) * 60 - Double(seconds)) * 100))
String(format:"%02i:%02i.%02i", minutes, seconds, tenths)

