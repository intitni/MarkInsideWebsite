import Plot
import Publish

struct Header: Component {
    @EnvironmentValue(.language) var language
    @EnvironmentValue(.links) var links

    var showReturnToHomeButton = false

    var body: Component {
        Plot.Header {
            Div {
                if showReturnToHomeButton {
                    HomeButton()
                } else {
                    Div()
                }
                Div {
                    Paragraph {
                        Link(t(.changelogTitle), url: t(.changelogURL))
                    }
                    Paragraph {
                        Link(t(.privacyPolicyTitle), url: t(.privacyPolicyURL))
                    }
                    Paragraph {
                        Link(t(.templateTitle), url: t(.templatePath))
                    }
                    Paragraph {
                        Link(t(.languageTitle), url: t(.languagePath))
                    }
                }.class("flex flex-row justify-center [&>p]:text-[0.8rem] [&>p]:md:text-[1em] md:justify-end space-x-4 flex-wrap")
            }.class("flex flex-col md:flex-row items-stretch md:items-start justify-between text-xs mt-8")
        }
    }
}

extension Header: LocalizedComponent {
    enum I18nKey: Hashable, CaseIterable {
        case changelogTitle
        case changelogURL
        case privacyPolicyTitle
        case privacyPolicyURL
        case templateTitle
        case templatePath
        case languageTitle
        case languagePath
    }

    var i18nDict: [Language: [I18nKey: String]] { [
        .chinese: I18nKey.allCases.reduce(into: [:]) { partialResult, key in
            partialResult[key] = {
                switch key {
                case .changelogTitle: return "版本记录"
                case .changelogURL: return links.changeLogChineseURL.absoluteString
                case .privacyPolicyTitle: return "隐私协议"
                case .privacyPolicyURL: return links.privacyPolicyChineseURL.absoluteString
                case .templateTitle: return "模板"
                case .templatePath: return "/zh-cn/templates"
                case .languageTitle: return "English"
                case .languagePath: return "/"
                }
            }()
        },
        .xDefault: I18nKey.allCases.reduce(into: [:]) { partialResult, key in
            partialResult[key] = {
                switch key {
                case .changelogTitle: return "Changelog"
                case .changelogURL: return links.changeLogURL.absoluteString
                case .privacyPolicyTitle: return "Pivacy Policy"
                case .privacyPolicyURL: return links.privacyPolicyURL.absoluteString
                case .templateTitle: return "Templates"
                case .templatePath: return "/templates"
                case .languageTitle: return "中文"
                case .languagePath: return "/zh-cn"
                }
            }()
        },
    ] }
}

struct HomeButton: Component {
    @EnvironmentValue(.language) var language

    let leftArrowIcon = ComponentGroup(html: """
    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-3 h-3">
      <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 19.5L8.25 12l7.5-7.5" />
    </svg>
    """)

    var body: Component {
        Link(url: t(.homePath)) {
            leftArrowIcon
            Image("/AppIconCompact.png")
                .class("max-h-10 drop-shadow-sm pl-1 pr-2 py-1")
            Div {
                Paragraph(t(.title))
                    .class("leading-[1em] h-[1em] mb-0 mt-0 font-bold shadow-sm")
            }
            .class("text-left flex flex-col justify-start items.center")
        }
        .class("no-underline shadow-none hover:shadow-none flex justify-center items-center bg-slate-50 rounded-lg text-white bg-opacity-10 hover:bg-opacity-20 py-0.5 pl-1 pr-3 transition duration-200 -translate-y-[25%]")
    }
}

extension HomeButton: LocalizedComponent {
    enum I18nKey: Hashable, CaseIterable {
        case homePath
        case title
    }

    var i18nDict: [Language: [I18nKey: String]] { [
        .chinese: I18nKey.allCases.reduce(into: [:]) { partialResult, key in
            partialResult[key] = {
                switch key {
                case .homePath: return "/zh-cn"
                case .title: return "获取 MarkInside"
                }
            }()
        },
        .xDefault: I18nKey.allCases.reduce(into: [:]) { partialResult, key in
            partialResult[key] = {
                switch key {
                case .homePath: return "/"
                case .title: return "Get MarkInside"
                }
            }()
        },
    ] }
}
