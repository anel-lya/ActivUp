/*
локально будут картинка, почта, список, ник (почта без домена), можно изменить
файер будет почта, пароль(та же почта)
 */

import Foundation




class Video : Hashable {
    var chanel : String
    var img : String
    var youtubeurl : String
    var videoUrl : String

    init(chanel: String, img: String, youtubeurl: String, videoUrl: String) {
        self.chanel = chanel
        self.img = img
        self.youtubeurl = youtubeurl
        self.videoUrl = videoUrl
    }
    func hash(into hasher: inout Hasher) {
            hasher.combine(chanel)
            hasher.combine(img)
            hasher.combine(youtubeurl)
        }

        static func == (lhs: Video, rhs: Video) -> Bool {
            return lhs.chanel == rhs.chanel && lhs.img == rhs.img && lhs.youtubeurl == rhs.youtubeurl
        }
}
let i = Video(chanel: "Букич", img: "Букич.png", youtubeurl: "https://www.youtube.com/@bukich69", videoUrl: "")
let b = Video(chanel: "INSTARDING", img: "INSTARDING.png", youtubeurl: "https://www.youtube.com/@INSTARDING", videoUrl: "")
//var videoList : [Video : [Data]] = [ i : [],  b: []]



//var mainList : [Any] = [[i, b]]

var mainList : [Int : [String]] = [:]

let cityList = ["Kazakhstan", "Russia", "Uzbekistan", "Turkmenistan", "Kyrgyzstan", "Ukraine", "Other"]


var quoteList : [String] = []

var videoList : [String] = []


