import Foundation
import Plot
import Publish

struct Banner: Component {
    @EnvironmentValue(.language) var language

    var body: Component {
        Div {
            Div {
                Image("/AppIcon.png")
            }
            .class("md:w-[400px] md:h-[400px] w-[240px] h-[240px]")

            Div {
                H1("MarkInside")
                    .class("leading-[1em] h-[1em] mb-0 mt-0 font-bold")
            }
            .class("text-center")

            Div {
                Paragraph(language.appDescription)
                    .class("mb-0")
                language.supportedFeatures
                    .class("mb-0")
            }
            .class("text-center text-[#d9e6ff]")

            Div {
                DownloadFromMacAppStoreBadge()
                DownloadFromWindowsStoreBadge()
            }
            .class("flex flex-row space-x-1")

            Div {
                Image("/HomePageScreenshot.png")
            }.class("pt-8")
        }
        .class("flex flex-col items-center justify-center space-y-3 max-w-[min(580px, 100%)]")
    }
}

private struct DownloadFromMacAppStoreBadge: Component {
    @EnvironmentValue(.language) var language
    @EnvironmentValue(.links) var links

    var body: Component {
        Link(
            url: links.appStoreURL,
            label: { Image(t(.imagePath)).class("h-[54px]") }
        )
        .linkTarget(.blank)
        .class("shadow-none hover:shadow-none")
    }
}

extension DownloadFromMacAppStoreBadge: LocalizedComponent {
    enum I18nKey: Hashable, CaseIterable {
        case imagePath
    }

    var i18nDict: [Language: [I18nKey: String]] { [
        .chinese: I18nKey.allCases.reduce(into: [:]) { partialResult, key in
            partialResult[key] = {
                switch key {
                case .imagePath: return "/DownloadFromMAS_CN.svg"
                }
            }()
        },
        .xDefault: I18nKey.allCases.reduce(into: [:]) { partialResult, key in
            partialResult[key] = {
                switch key {
                case .imagePath: return "/DownloadFromMAS_US.svg"
                }
            }()
        },
    ] }
}

private struct DownloadFromWindowsStoreBadge: Component {
    @EnvironmentValue(.language) var language
    @EnvironmentValue(.links) var links
    
    var body: Component {
        Link(
            url: links.windowsStoreURL,
            label: { Image(t(.imagePath)).class("h-[54px]") }
        )
        .linkTarget(.blank)
        .class("shadow-none hover:shadow-none")
    }
}

extension DownloadFromWindowsStoreBadge: LocalizedComponent {
    enum I18nKey: Hashable, CaseIterable {
        case imagePath
    }

    var i18nDict: [Language: [I18nKey: String]] { [
        .chinese: I18nKey.allCases.reduce(into: [:]) { partialResult, key in
            partialResult[key] = {
                switch key {
                case .imagePath: return "/DownloadFromMicrosoft_CN.svg"
                }
            }()
        },
        .xDefault: I18nKey.allCases.reduce(into: [:]) { partialResult, key in
            partialResult[key] = {
                switch key {
                case .imagePath: return "/DownloadFromMicrosoft_US.svg"
                }
            }()
        },
    ] }
}
