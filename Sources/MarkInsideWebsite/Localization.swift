import Foundation
import Plot
import Publish

protocol LocalizedComponent {
    associatedtype I18nKey: Hashable
    var language: Language { get }
    var i18nDict: [Language: [I18nKey: String]] { get }
}

extension LocalizedComponent {
    func t(_ key: I18nKey, file: StaticString = #file, line: UInt = #line) -> String {
        let raw = i18nDict[language]?[key] ?? i18nDict[.xDefault]?[key]
            ?? "\(file):\(line) - \(String(describing: key)) is not translated"
        return raw
    }

    func t(parsing key: I18nKey, file: StaticString = #file, line: UInt = #line) -> Component {
        let markdown = Markdown(t(key, file: file, line: line))
        return markdown.body
    }
}

extension Location {
    var language: Language {
        if let section = self as? Section<MarkInsideWebsite> {
            switch section.id {
            case MarkInsideWebsite.SectionID.zh_cn:
                return .chinese
            }
        }
        if let item = self as? Item<MarkInsideWebsite> {
            switch item.sectionID {
            case MarkInsideWebsite.SectionID.zh_cn:
                return .chinese
            }
        }
        return .english
    }
}

extension Language {
    var appDescription: String {
        switch self {
        case .chinese:
            return "你并不需要一个高端的笔记软件去创建、编辑、预览"
        default:
            return "You don’t need a fancy note editor to\ncreate, edit and preview"
        }
    }

    var and: String {
        switch self {
        case .chinese:
            return " 和 "
        default:
            return " , and "
        }
    }

    var supportedFeatures: Node<HTML.BodyContext> {
        switch self {
        case .chinese:
            return .p(
                .span(.class("font-bold"), .text("LaTeX 数学公式")),
                .text("、"),
                .span(.class("font-bold"), .text("Mermaid")),
                .text(" 和"),
                .span(.class("font-bold"), .text("任意 HTML"))
            )
        default:
            return .p(
                .span(.class("font-bold"), .text("LaTeX Math")),
                .text(", "),
                .span(.class("font-bold"), .text("Mermaid")),
                .text(", and "),
                .span(.class("font-bold"), .text("any HTML"))
            )
        }
    }

    var contactMe: String {
        switch self {
        case .chinese:
            return "联系我"
        default:
            return "Contact Me"
        }
    }

    var downloadFromAppStoreLink: String {
        switch self {
        case .chinese:
            return "/DownloadFromMAS_US.svg"
        default:
            return "/DownloadFromMAS_US.svg"
        }
    }

    var twitterCardPath: Path {
        switch self {
        case .chinese:
            return "Twitter_Card_ZH.png"
        default:
            return "Twitter_Card_EN.png"
        }
    }
}
