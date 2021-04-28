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
            .head(for: index, on: context.site),
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
            .head(for: section, on: context.site),
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
            .head(for: item, on: context.site)
        )
    }

    func makePageHTML(for page: Page, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site)
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
                .p("You don’t need a fancy markdown editor to create, edit and preview"),
                .p(
                    .span(
                        .class("bold"),
                        "Latex Math"
                    ),
                    " and ",
                    .span(
                        .class("bold"),
                        "Mermaid"
                    )
                )
            ),
            .div(
                .class("downloads"),
                .a(
                    .href(site.appStoreURL),
                    .img(.src("/DownloadFromMAS_US.svg"))
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
                    .text("Change Log")
                )),
                .p(.a(
                    .href(site.privacyPolicyURL),
                    .text("Privacy Policy")
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
                .text("Contact Me"),
                .href("mailto:abnormalmouseapp@intii.com")
            )),
            .script(.attribute(.src(site.gTagURL)))
        )
    }
}

extension Node where Context == HTML.DocumentContext {
    func head<T: Website>(
        for location: Location,
        on site: T
    ) -> Node<HTML.DocumentContext> {
        var title = location.title

        if title.isEmpty {
            title = site.name
        } else {
            title.append("|" + site.name)
        }

        var description = location.description

        if description.isEmpty {
            description = site.description
        }

        return .head(
            .encoding(.utf8),
            .siteName(title),
            .url(site.url(for: location)),
            .title(title),
            .description(description),
            .twitterCardType(.summaryLargeImage),
            .forEach(["/styles.css"]) { .stylesheet($0) },
            .viewport(.accordingToDevice),
            .unwrap(site.favicon) { .favicon($0) },
            .unwrap(location.imagePath ?? site.imagePath) { path in
                let url = site.url(for: path)
                var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
                components.queryItems = [
                    .init(name: "random", value: String(Int.random(in: 1...9999))),
                ]
                return .socialImageLink(components.url!)
            },
            .meta(
                .attribute(named: "name", value: "twitter:site"),
                .attribute(named: "content", value: "@intitni")
            ),
            .meta(
                .attribute(named: "name", value: "twitter:creator"),
                .attribute(named: "content", value: "@intitni")
            ),
            .script( // Enable Gtag
                .raw("""
                window.dataLayer = window.dataLayer || [];
                function gtag(){dataLayer.push(arguments);}
                gtag('js', new Date());
                gtag('config', 'UA-17603222-4');
                """)
            ),
            .script( // Google Tag Manager
                .raw("""
                (function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
                new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
                j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
                'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
                })(window,document,'script','dataLayer','GTM-5K84TFL');
                """)
            )
        )
    }
}
