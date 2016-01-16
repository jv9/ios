import UIKit

enum ClassmereIcon {
    case BlankFace
    case Building
    case Calendar
    case Clock
    
    static func nameForIcon(icon: ClassmereIcon) -> String {
        switch(icon) {
        case BlankFace:
            return "blank_face"
        case Building:
            return "building"
        case Calendar:
            return "calendar"
        case Clock:
            return "clock"
        }
    }
    
    static func imageForIcon(icon: ClassmereIcon) -> UIImage {
        return UIImage(named: ClassmereIcon.nameForIcon(icon))!
    }
}