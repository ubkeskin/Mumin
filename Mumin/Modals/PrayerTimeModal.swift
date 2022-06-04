import Foundation

struct PrayerTimeModal: Codable {
    let code: Int
    let status: String
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let timings: Timings
    let date: DateClass
    let meta: Meta
}

// MARK: - DateClass
struct DateClass: Codable {
    let readable, timestamp: String
    let hijri: Hijri
    let gregorian: Gregorian
}

// MARK: - Gregorian
struct Gregorian: Codable {
    let date, format, day: String
    let weekday: GregorianWeekday
    let month: GregorianMonth
    let year: String
    let designation: Designation
}

// MARK: - Designation
struct Designation: Codable {
    let abbreviated, expanded: String
}

// MARK: - GregorianMonth
struct GregorianMonth: Codable {
    let number: Int
    let en: String
}

// MARK: - GregorianWeekday
struct GregorianWeekday: Codable {
    let en: String
}

// MARK: - Hijri
struct Hijri: Codable {
    let date, format, day: String
    let weekday: HijriWeekday
    let month: HijriMonth
    let year: String
    let designation: Designation
    let holidays: [String?]
}

// MARK: - HijriMonth
struct HijriMonth: Codable {
    let number: Int
    let en, ar: String
}

// MARK: - HijriWeekday
struct HijriWeekday: Codable {
    let en, ar: String
}

// MARK: - Meta
struct Meta: Codable {
    let latitude, longitude: Double
    let timezone: String
    let method: Method
    let latitudeAdjustmentMethod, midnightMode, school: String
    let offset: [String: Int]?
}

// MARK: - Method
struct Method: Codable {
    let id: Int
    let name: String
    let params: Params
    let location: Location
}

// MARK: - Location
struct Location: Codable {
    let latitude, longitude: Double
}

// MARK: - Params
struct Params: Codable {
    let Fajr, Isha: Int
}

// MARK: - Timings
struct Timings: Codable {
    let Fajr, Sunrise, Dhuhr, Asr: String
    let Sunset, Maghrib, Isha, Imsak: String
    let Midnight: String
}
