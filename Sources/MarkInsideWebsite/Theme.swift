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

private struct AHTMLFactory<Site: Website>: HTMLFactory {
    func makeIndexHTML(for index: Index, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .customHead(for: index, on: context.site),
            .component(
                IndexBody(content: index.content.body.node)
                    .environmentValue(context.site.links, key: .links)
                    .environmentValue(index.language, key: .language)
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
            .component(
                IndexBody(content: section.content.body.node)
                    .environmentValue(context.site.links, key: .links)
                    .environmentValue(section.language, key: .language)
            )
        )
    }

    func makeItemHTML(for item: Item<Site>, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .customHead(for: item, on: context.site),
            .component(
                {
                    switch item.path.string {
                    case let x where x.hasSuffix("templates"):
                        return PageBody(content: TemplatesPageContent())
                    default:
                        return PageBody(content: item.content.body.node)
                    }
                }()
                    .environmentValue(context.site.links, key: .links)
                    .environmentValue(item.language, key: .language)
            )
        )
    }

    func makePageHTML(for page: Page, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .customHead(for: page, on: context.site),
            .component(
                {
                    switch page.path.string {
                    case let x where x.hasSuffix("templates"):
                        return PageBody(content: TemplatesPageContent())
                    default:
                        return PageBody(content: page.content.body.node)
                    }
                }()
                    .environmentValue(context.site.links, key: .links)
                    .environmentValue(page.language, key: .language)
            )
        )
    }

    func makeTagListHTML(for _: TagListPage, context _: PublishingContext<Site>) throws -> HTML? {
        return nil
    }

    func makeTagDetailsHTML(
        for _: TagDetailsPage,
        context _: PublishingContext<Site>
    ) throws -> HTML? {
        return nil
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
            .forEach(["/styles.css"]) {
                .stylesheet($0 + "?random=\(String(Int.random(in: 0 ... 1000)))")
            },
            .viewport(.accordingToDevice),
            .unwrap(site.favicon) { .favicon($0) },
            .socialImageLink({
                let url = site.url(for: location.language.twitterCardPath)
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
