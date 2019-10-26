// MARK: List
public enum List<Element> {
	case empty
	indirect case cons(Element, List<Element>)
}

// MARK: - Initializers
public extension List {
	init(_ elements: Element...) {
		self = .init(from: elements)
	}

	init<T: Collection>(from collection: T) where Element == T.Element {
		self = collection.reversed().reduce(.empty) { .cons($1, $0) }
	}
}

// MARK: - Implement Collection (Essential)
extension List: Collection {
	public func index(after i: Int) -> Int { i + 1 }
	
	public var startIndex: Int { 0 }
	
	public var endIndex: Int { count }

	public var count: Int {
		switch self {
			case .cons(_, let xs):
				return xs.count + 1
			case .empty:
				return 0
		}
	}
}

// MARK: - Implement Collection (Additional)
extension List {
	public __consuming func dropFirst(_ k: Int = 1) -> List<Element> {
		return self[from: k]
	}
	
	public __consuming func reversed() -> List<Element> {
		reduce(.empty) { .cons($1, $0) }
	}
	
	public func map<T>(_ transform: (Element) throws -> T) rethrows -> List<T> {
		guard case let .cons(x, xs) = self else { return .empty }
		do { return .cons(try transform(x), try xs.map(transform)) }
		catch { return .empty }
	}

	public func flatMap<T>(_ transform: (Element) throws -> List<T>) rethrows -> List<T> {
		guard case let .cons(x, xs) = self else { return .empty }
		do { return try transform(x) + xs.flatMap(transform) }
		catch { return .empty }
	}
}

// MARK: - Implement subscript
public extension List {
	subscript(index: Int) -> Element {
		let elem = self[safe: index]
		precondition(elem != nil, "Out of bounds")
		return elem!
	}
	
	subscript(safe index: Int) -> Element? {
		guard case let .cons(x, xs) = self else { return .none }
		return index > 0 ? xs[safe: index - 1] : x
	}
	
	
	subscript(from index: Int) -> List<Element> {
		guard index > 0 else { return self }
		guard case let .cons(_, xs) = self else { return .empty }
		return xs[from: index - 1]
	}
}

// MARK: - Implement Equatable
extension List: Equatable where Element: Equatable {
	public static func == (lhs: List<Element>, rhs: List<Element>) -> Bool {
		lhs.count == rhs.count && zip(lhs, rhs).reduce(true) { $0 && $1.0 == $1.1 }
	}
}

// MARK: - Implement CustomStringConvertible
extension List: CustomStringConvertible {
	public var description: String {
		return map { "\($0)" }.joined(separator: ", ")
	}
}

// MARK: - Operator Support
public func +<T>(lhs: List<T>, rhs: List<T>) -> List<T> {
	guard case let .cons(x, xs) = lhs else { return rhs }
	if case .empty = xs { return .cons(x, rhs) }
	return .cons(x, xs + rhs)
}
