//
//  Interactor.swift
//  AnimeVerse
//
//  Implementasi generic tunggal untuk protokol UseCase — dipakai ulang untuk
//  semua use case, gantiin 6 pasang protocol+class yang ditulis manual satu-satu.
//

import Combine

public protocol UseCase {
    associatedtype Input
    associatedtype Output

    func execute(_ input: Input) -> AnyPublisher<Output, Error>
}

public final class Interactor<Input, Output>: UseCase {
    private let handler: (Input) -> AnyPublisher<Output, Error>

    public init(handler: @escaping (Input) -> AnyPublisher<Output, Error>) {
        self.handler = handler
    }

    public func execute(_ input: Input) -> AnyPublisher<Output, Error> {
        handler(input)
    }
}
