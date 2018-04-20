//
// Copyright (C) 2017 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//
import Foundation

open class Book: ModelObject
{
    public struct Keys {
        public static let title = "title"
        public static let year = "year"
        public static let author = "author"
    }
    
    @objc open var title: String?
    @objc open var year: String?
    @objc open var author: Author?
    
    open override var description: String {
        return "title: \(title ?? "nil"), year: \(year ?? "nil"), author: \(author?.description ?? "nil")"
    }
    
    open override class var keys: [String] {
        return [Keys.title, Keys.year, Keys.author]
    }
    
    public required init(dictionary: [String : Any]) {
        var bookInfo = dictionary
        if let authorInfo = dictionary[Keys.author] as? [String: Any] {
            bookInfo[Keys.author] = Author(dictionary: authorInfo)
        }
        super.init(dictionary: bookInfo)
    }
    
    open override func dictionaryRepresentation() -> [String: Any] {
        var dict = super.dictionaryRepresentation()
        if let author = dict[Keys.author] as? Author {
            dict[Keys.author] = author.dictionaryRepresentation() as Any?
        }
        return dict
    }
}

