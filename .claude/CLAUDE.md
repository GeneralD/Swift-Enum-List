# Swift-Enum-List

Educational Swift framework (2019): a functional, immutable cons list
implemented as `indirect enum List<Element>` with `Collection`, `Equatable`,
and `CustomStringConvertible` conformance plus recursive `map`/`flatMap`/
`reversed`/concatenation.

- Language/stack: Swift 5, macOS 10.15+, Xcode framework target, XCTest suite
- Status: legacy sample — reference for recursive enums and Collection
  conformance, not for production use
- API highlights: variadic/`Collection` initializers, `dropFirst`, `+`
  concatenation, subscripts `[i]` / `[safe:]` / `[from:]`
- Build/test: open the Xcode project and run the XCTest target
