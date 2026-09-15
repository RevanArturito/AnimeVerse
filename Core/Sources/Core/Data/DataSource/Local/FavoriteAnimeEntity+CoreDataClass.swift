//
//  FavoriteAnimeEntity+CoreDataClass.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 14/09/26.
//

import Foundation
import CoreData

@objc(FavoriteAnimeEntity)
public class FavoriteAnimeEntity: NSManagedObject {
    @NSManaged public var malId: Int64
    @NSManaged public var title: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var synopsis: String?
    @NSManaged public var score: Double
    @NSManaged public var episodes: Int32
    @NSManaged public var status: String?
    @NSManaged public var genres: String?
}

extension FavoriteAnimeEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteAnimeEntity> {
        NSFetchRequest<FavoriteAnimeEntity>(entityName: "FavoriteAnimeEntity")
    }
}
