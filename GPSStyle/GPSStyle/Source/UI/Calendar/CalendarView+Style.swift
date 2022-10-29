// swiftlint:disable all
//
//  CalendarView+Style.swift
//  CalendarView
//
//  Created by Vitor Mesquita on 17/01/2018.
//  Copyright © 2018 Karmadust. All rights reserved.
//

import UIKit

extension CalendarView {
    
    public class Style {
        
        public static var Default: Style = Style()
        
        public enum CellShapeOptions {
            case round
            case square
            case bevel(CGFloat)
            var isRound: Bool {
                switch self {
                    case .round:
                        return true
                    default:
                        return false
                }
            }
        }
        
        public enum FirstWeekdayOptions{
            case sunday
            case monday
        }
        
        public enum CellOutOfRangeDisplayOptions {
            case normal
            case hidden
            case grayed
        }
        
        public enum WeekDaysTransform {
            case capitalized, uppercase
        }
        
        public init()
        {
        }
        
        //Event
        public var cellEventColor            = UIColor(red: 254.0/255.0, green: 73.0/255.0, blue: 64.0/255.0, alpha: 0.8)
        
        //Header
        public var headerHeight: CGFloat     = 80.0
        public var headerTopMargin: CGFloat  = 5.0
        public var headerTextColor           = UIColor.gray
        public var headerBackgroundColor     = UIColor.white
        public var headerFont: UIFont                = FontFamily.Inter.regular.font(size: 18)
        
        public var weekdaysTopMargin: CGFloat     = 5.0
        public var weekdaysBottomMargin: CGFloat  = 5.0
        public var weekdaysHeight: CGFloat        = 35.0
        public var weekdaysTextColor: UIColor              = ColorName.black.color
        public var weekdaysBackgroundColor        = UIColor.white
        public var weekdaysFont: UIFont           = FontFamily.Inter.regular.font(size: 14)
        
        //Common
        public var cellShape                 = CellShapeOptions.round
        
        public var firstWeekday              = FirstWeekdayOptions.monday
        public var showAdjacentDays          = false
        
        //Default Style
        public var cellColorDefault          = UIColor.clear
        public var cellTextColorDefault: UIColor      = ColorName.black.color
        public var cellBorderColor           = UIColor.clear
        public var cellBorderWidth           = CGFloat(0.0)
        public var cellFont: UIFont                  = FontFamily.Inter.regular.font(size: 14)
        
        //Today Style
        public var cellTextColorToday: UIColor        = ColorName.black.color
        public var cellColorToday            = UIColor.clear
        public var cellColorOutOfRange       = UIColor(white: 0.0, alpha: 0.5)
        public var cellColorAdjacent         = UIColor.clear
        
        //Selected Style
        public var cellSelectedBorderColor   = UIColor(red: 254.0/255.0, green: 73.0/255.0, blue: 64.0/255.0, alpha: 0.8)
        public var cellSelectedBorderWidth   = CGFloat(0.0)
        public var cellSelectedColor: UIColor         = ColorName.mainPurple.color
        public var cellSelectedTextColor: UIColor     = ColorName.white.color
        
        //Weekend Style
        public var cellTextColorWeekend: UIColor      = ColorName.black.color
        
        //Locale Style
        public var locale                    = Locale.current
        
        //Calendar Identifier Style
        public lazy var calendar: Calendar   = {
            var calendar = Calendar(identifier: .gregorian)
            calendar.timeZone = TimeZone(abbreviation: "UTC")!
            return calendar
        }()
        
        public var weekDayTransform = WeekDaysTransform.capitalized
        
        
    }
}
