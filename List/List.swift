// MARK: List
enum List<Element> {
	case empty
	indirect case cons(Element, List<Element>)
}

// MARK: - Initializers
extension List {
	init(_ elements: Element...) {
		self = .init(from: elements)
	}

	init<T: Collection>(from collection: T) where Element == T.Element {
		self = collection.reversed().reduce(.empty) {
			.cons($1, $0)
		}
	}
}

// MARK: - Implement Collection
extension List: Collection {
	func index(after i: Int) -> Int { i + 1 }
	
	var startIndex: Int { 0 }
	
	var endIndex: Int { count }

	var count: Int {
		switch self {
			case .cons(_, let xs):
				return xs.count + 1
			case .empty:
				return 0
		}
	}
}

// MARK: - Implement subscript
extension List {
	subscript(index: Int) -> Element {
		let elem = self[safe: index]
		precondition(elem != nil, "Out of bounds")
		return elem!
	}
	
	subscript(safe index: Int) -> Element? {
		guard case let .cons(x, xs) = self else { return .none }
		return index > 0 ? xs[safe: index - 1] : x
	}
}

// MARK: - Implement Equatable
extension List: Equatable where Element: Equatable {
	static func == (lhs: List<Element>, rhs: List<Element>) -> Bool {
		lhs.count == rhs.count && zip(lhs, rhs).reduce(true) { $0 && $1.0 == $1.1 }
	}
}

// MARK: - Implement CustomStringConvertible
extension List: CustomStringConvertible {
	var description: String {
		return map { "\($0)" }.joined(separator: ", ")
	}
}
