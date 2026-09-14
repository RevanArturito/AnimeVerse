//
//  AnimeLocalDataSource.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 14/09/26.
//

import Combine
import CoreData

protocol AnimeLocalDataSource {
    func getFavorites() -> AnyPublisher<[FavoriteAnimeEntity], Error>
    func addFavorite(_ detail: AnimeDetail) -> AnyPublisher<Void, Error>
    func removeFavorite(id: Int) -> AnyPublisher<Void, Error>
    func isFavorite(id: Int) -> AnyPublisher<Bool, Error>
}

final class AnimeLocalDataSourceImpl: AnimeLocalDataSource {
    private let stack: CoreDataStack

    init(stack: CoreDataStack = .shared) {
        self.stack = stack
    }

    func getFavorites() -> AnyPublisher<[FavoriteAnimeEntity], Error> {
        Deferred {
            Future { [weak self] promise in
                guard let self = self else { return }
                let request = FavoriteAnimeEntity.fetchRequest()
                do {
                    let results = try self.stack.context.fetch(request)
                    promise(.success(results))
                } catch {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }

    func addFavorite(_ detail: AnimeDetail) -> AnyPublisher<Void, Error> {
        Deferred {
            Future { [weak self] promise in
                guard let self = self else { return }
                let entity = FavoriteAnimeEntity(context: self.stack.context)
                FavoriteEntityMapper.fill(entity, from: detail)
                self.stack.saveContext()
                promise(.success(()))
            }
        }.eraseToAnyPublisher()
    }

    func removeFavorite(id: Int) -> AnyPublisher<Void, Error> {
        Deferred {
            Future { [weak self] promise in
                guard let self = self else { return }
                let request = FavoriteAnimeEntity.fetchRequest()
                request.predicate = NSPredicate(format: "malId == %d", id)
                do {
                    let results = try self.stack.context.fetch(request)
                    results.forEach { self.stack.context.delete($0 as! NSManagedObject) }
                    self.stack.saveContext()
                    promise(.success(()))
                } catch {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }

    func isFavorite(id: Int) -> AnyPublisher<Bool, Error> {
        Deferred {
            Future { [weak self] promise in
                guard let self = self else { return }
                let request = FavoriteAnimeEntity.fetchRequest()
                request.predicate = NSPredicate(format: "malId == %d", id)
                do {
                    let count = try self.stack.context.count(for: request)
                    promise(.success(count > 0))
                } catch {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
