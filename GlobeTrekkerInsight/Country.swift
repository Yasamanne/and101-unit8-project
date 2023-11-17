//
//  Info.swift
//  GlobeTrekkerInsight
//
//  Created by Yasaman Emami on 11/12/23.
//


struct Country: Decodable {
    struct Name: Decodable {
        let common: String
        let official: String
        let nativeName: [String: NameTranslation]
    }

    struct NameTranslation: Decodable {
        let official: String
        let common: String
    }

    struct Currency: Decodable {
        let name: String
        let symbol: String
    }

    struct Language: Decodable {
        let deu: String
    }

    struct Translation: Decodable {
        let ara: NameTranslation
        let bre: NameTranslation
        let ces: NameTranslation
        let cym: NameTranslation
        let deu: NameTranslation
        // Add other translations as needed
    }

    struct Demonyms: Decodable {
        struct Gender: Decodable {
            let f: String
            let m: String
        }

        let eng: Gender
        let fra: Gender
        // Add other demonyms as needed
    }

    struct Maps: Decodable {
        let googleMaps: String
        let openStreetMaps: String
    }

    struct FlagInfo: Decodable {
        let png: String
        let svg: String
        let alt: String
    }

    struct CoatOfArms: Decodable {
        let png: String
        let svg: String
    }

    struct IDDDynamicKeys: Decodable {
        let root: String
        let suffixes: [String]

        private enum CodingKeys: CodingKey {
            case root
            case suffixes
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.root = try container.decode(String.self, forKey: .root)

            // Decode suffixes dynamically
            var suffixesContainer = try container.nestedUnkeyedContainer(forKey: .suffixes)
            var suffixes: [String] = []
            while !suffixesContainer.isAtEnd {
                if let suffix = try? suffixesContainer.decode(String.self) {
                    suffixes.append(suffix)
                }
            }
            self.suffixes = suffixes
        }
    }

    struct CarInfo: Decodable {
        let signs: [String]
        let side: String
    }

    let name: Name
    let tld: [String]
    let cca2: String
    let ccn3: String
    let cca3: String
    let cioc: String
    let independent: Bool
    let status: String
    let unMember: Bool
    let currencies: [String: Currency]
    let idd: IDDDynamicKeys
    let capital: [String]
    let altSpellings: [String]
    let region: String
    let subregion: String
    let languages: [String: String]
    let translations: Translation
    let latlng: [Double]
    let landlocked: Bool
    let borders: [String]
    let area: Double
    let demonyms: Demonyms
    let flag: String
    let maps: Maps
    let population: Int
    let gini: [String: Double]
    let fifa: String
    let car: CarInfo
    let timezones: [String]
    let continents: [String]
    let flags: FlagInfo
    let coatOfArms: CoatOfArms
    let startOfWeek: String
    let capitalInfo: [String: [Double]]
    let postalCode: [String: String]
    
    func getCurrencyInfo(for currencyCode: String) -> (name: String, symbol: String)? {
            if let currency = currencies[currencyCode] {
                return (currency.name, currency.symbol)
            } else {
                return nil
            }
    }
}

//import Foundation
//
//struct Country: Decodable {
//    struct Name: Decodable {
//        let common: String
//        let official: String
//        let nativeName: [String: NameTranslation]
//    }
//
//    struct NameTranslation: Decodable {
//        let official: String
//        let common: String
//    }
//
//    struct Currency: Decodable {
//        let name: String
//        let symbol: String
//    }
//
//    struct IDD: Decodable {
//        let root: String
//        let suffixes: [String]
//    }
//
//    struct Language: Decodable {
//        let deu: String
//    }
//
//    struct Translation: Decodable {
//        let ara, bre, ces, cym, deu, est, fin, fra, hrv, hun, ita, jpn, kor, nld, per, pol, por, rus, slk, spa, srp, swe, tur, urd, zho: NameTranslation
//    }
//
//    struct Demonym: Decodable {
//        let eng, fra: GenderedName
//    }
//
//    struct GenderedName: Decodable {
//        let f, m: String
//    }
//
//    struct Maps: Decodable {
//        let googleMaps: String
//        let openStreetMaps: String
//    }
//
//    struct Gini: Decodable {
//        let gini: Double
//    }
//
//    struct Car: Decodable {
//        let signs: [String]
//        let side: String
//    }
//
//    struct PostalCode: Decodable {
//        let format: String
//        let regex: String
//    }
//
//    let name: Name
//    let tld: [String]
//    let cca2, ccn3, cca3, cioc: String
//    let independent: Bool
//    let status: String
//    let unMember: Bool
//    let currencies: [String: Currency]
//    let idd: IDD
//    let capital: [String]
//    let altSpellings: [String]
//    let region, subregion: String
//    let languages: [String: String]
//    let translations: Translation
//    let latlng: [Double]
//    let landlocked: Bool
//    let borders: [String]
//    let area: Double
//    let demonyms: Demonym
//    let flag: String
//    let maps: Maps
//    let population: Int
//    let gini: Gini
//    let fifa: String
//    let car: Car
//    let timezones: [String]
//    let continents: [String]
//    let flags: Flag
//    let coatOfArms: CoatOfArms
//    let startOfWeek: String
//    let capitalInfo: CapitalInfo
//    let postalCode: PostalCode
//
//    func getCurrencyInfo(for currencyCode: String) -> (name: String, symbol: String)? {
//            if let currency = currencies[currencyCode] {
//                return (currency.name, currency.symbol)
//            } else {
//                return nil
//            }
//    }
//}
//
//struct Flag: Decodable {
//    let png, svg, alt: String
//}
//
//struct CoatOfArms: Decodable {
//    let png, svg: String
//}
//
//struct CapitalInfo: Decodable {
//    let latlng: [Double]
//}
//
//
