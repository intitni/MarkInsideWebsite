import Plot
import Publish

extension EnvironmentKey where Value == Links {
    static var links: Self {
        Self(defaultValue: Links())
    }
}

extension EnvironmentKey where Value == Language {
    static var language: Self {
        Self(defaultValue: .english)
    }
}