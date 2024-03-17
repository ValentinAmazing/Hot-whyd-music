
import Foundation

struct trackList: Decodable {
    let hasMore: HasMore
    let tracks: [Track]
}

struct HasMore: Decodable {
    let skip: Int
}

struct Track: Decodable {
    let _id: String
    let eId: String
    let name: String
    let img: String
    let uId: String
    let uNm: String
    let pl: PlayList
    let pId: String
    let nbR, nbL: Int
    let score: Int
    let trackUrl: String
}

struct PlayList: Decodable {
    let id: Int
    let name: String
}

