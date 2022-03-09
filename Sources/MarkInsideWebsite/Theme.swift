import Foundation
import Ink
import Plot
import Publish
import Sweep

extension Theme {
    static var this: Self {
        Theme(
            htmlFactory: AHTMLFactory(),
            resourcePaths: []
        )
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
        return .english
    }

    var appDescription: String {
        switch language {
        case .chinese:
            return "你并不需要一个高端的笔记软件去创建、编辑、预览"
        default:
            return "You don’t need a fancy note editor to\ncreate, edit and preview"
        }
    }

    var and: String {
        switch language {
        case .chinese:
            return " 和 "
        default:
            return " , and "
        }
    }

    var supportedFeatures: Node<HTML.BodyContext> {
        switch language {
        case .chinese:
            return .p(
                .span(.class("bold"), .text("LaTeX 数学公式")),
                .text("、"),
                .span(.class("bold"), .text("Mermaid")),
                .text(" 和"),
                .span(.class("bold"), .text("任意 HTML"))
            )
        default:
            return .p(
                .span(.class("bold"), .text("LaTeX Math")),
                .text(", "),
                .span(.class("bold"), .text("Mermaid")),
                .text(", and "),
                .span(.class("bold"), .text("any HTML"))
            )
        }
    }

    var changelog: String {
        switch language {
        case .chinese:
            return "版本记录"
        default:
            return "Change Log"
        }
    }

    var privacyPolicy: String {
        switch language {
        case .chinese:
            return "隐私协议"
        default:
            return "Privacy Policy"
        }
    }

    var contactMe: String {
        switch language {
        case .chinese:
            return "联系我"
        default:
            return "Contact Me"
        }
    }

    var downloadFromAppStoreLink: String {
        switch language {
        case .chinese:
            return "/DownloadFromMAS_US.svg"
        default:
            return "/DownloadFromMAS_US.svg"
        }
    }

    var twitterCardPath: Path {
        switch language {
        case .chinese:
            return "Twitter_Card_ZH.png"
        default:
            return "Twitter_Card_EN.png"
        }
    }
}

private struct AHTMLFactory<Site: Website>: HTMLFactory {
    func makeIndexHTML(for index: Index, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .customHead(for: index, on: context.site),
            .body(
                .class("wrapper"),
                .header(for: index, on: context.site),
                .appBanner(for: index, on: context.site),
                .div(
                    .class("content"),
                    index.content.body.node
                ),
                .footer(for: index, on: context.site)
            )
        )
    }

    func makeSectionHTML(
        for section: Section<Site>,
        context: PublishingContext<Site>
    ) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .customHead(for: section, on: context.site),
            .body(
                .class("wrapper"),
                .header(for: section, on: context.site),
                .appBanner(for: section, on: context.site),
                .div(
                    .class("content"),
                    section.content.body.node
                ),
                .footer(for: section, on: context.site)
            )
        )
    }

    func makeItemHTML(for item: Item<Site>, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .customHead(for: item, on: context.site)
        )
    }

    func makePageHTML(for page: Page, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .customHead(for: page, on: context.site)
        )
    }

    func makeTagListHTML(for page: TagListPage, context: PublishingContext<Site>) throws -> HTML? {
        return nil
    }

    func makeTagDetailsHTML(
        for page: TagDetailsPage,
        context: PublishingContext<Site>
    ) throws -> HTML? {
        return nil
    }
}

extension Node where Context == HTML.BodyContext {
    static func appBanner<T: Website>(
        for location: Location,
        on site: T
    ) -> Node<HTML.BodyContext> {
        return .div(
            .class("introduction-stack"),
            .div(
                .class("app-icon"),
                .img(.src("/AppIcon.png"))
            ),
            .div(
                .class("app-title"),
                .h1(.text("MarkInside"))
            ),
            .div(
                .class("app-introduction"),
                .p(.text(location.appDescription)),
                location.supportedFeatures
            ),
            .div(
                .class("downloads"),
                .a(
                    .href(site.appStoreURL),
                    .img(.src(location.downloadFromAppStoreLink))
                )
            )
        )
    }

    static func header<T: Website>(
        for location: Location,
        on site: T
    ) -> Node<HTML.BodyContext> {
        return .header(
            .class("header"),
            .div(
                .class("page-links"),
                .p(.a(
                    .href(site.changeLogURL),
                    .text(location.changelog)
                )),
                .p(.a(
                    .href(site.privacyPolicyURL),
                    .text(location.privacyPolicy)
                ))
            )
        )
    }

    static func footer<T: Website>(
        for location: Location,
        on site: T
    ) -> Node<HTML.BodyContext> {
        return .footer(
            .class("footer"),
            .p(.text("Copyright © 2021")),
            .p(.a(
                .text(location.contactMe),
                .href("mailto:markinsideapp@intii.com")
            )),
            .script(.attribute(.src(site.gTagURL)), .async()),
            .script(.raw("""
            window.dataLayer = window.dataLayer || [];
            function gtag(){dataLayer.push(arguments);}
            gtag('js', new Date());
            gtag('config', 'G-GXHVET7ERS');
            """))
        )
    }
}

extension Node where Context == HTML.DocumentContext {
    static func customHead<T: Website, L: Location>(
        for location: L,
        on site: T
    ) -> Node<HTML.DocumentContext> {
        let title = site.name

        return .head(
            .encoding(.utf8),
            .siteName(title),
            .url(site.url(for: location)),
            .title(title),
            .description(site.description),
            .twitterCardType(.summaryLargeImage),
            .forEach(["/styles.css"]) { .stylesheet($0) },
            .viewport(.accordingToDevice),
            .unwrap(site.favicon) { .favicon($0) },
            .socialImageLink({
                let url = site.url(for: location.twitterCardPath)
                var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
                components.queryItems = [
                    .init(name: "random", value: String(Int.random(in: 1 ... 9999))),
                ]
                return components.url!
            }()),
            .meta(
                .attribute(named: "name", value: "twitter:site"),
                .attribute(named: "content", value: "@intitni")
            ),
            .meta(
                .attribute(named: "name", value: "twitter:creator"),
                .attribute(named: "content", value: "@intitni")
            )
        )
    }
}
