//
//  UseCase.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 15/09/26.
//

import Combine

public protocol UseCase {
    associatedtype Input
    associatedtype Output

    func execute(_ input: Input) -> AnyPublisher<Output, Error>
}
