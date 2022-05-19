import Foundation
import Plot
import Publish

extension Location {
    var language: Language {
        if let section = self as? Section<MarkInsideWebsite> {
            switch section.id {
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

    var changelog: String {
        switch self {
        case .chinese:
            return "版本记录"
        default:
            return "Change Log"
        }
    }

    var privacyPolicy: String {
        switch self {
        case .chinese:
            return "隐私协议"
        default:
            return "Privacy Policy"
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