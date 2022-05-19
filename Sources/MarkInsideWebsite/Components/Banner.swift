import Foundation
import Plot
import Publish

struct Banner: Component {
    @EnvironmentValue(.language) var language
    @EnvironmentValue(.links) var links

    var body: Component {
        Div {
            Div {
                Image("/AppIcon.png")
            }
            .class("md:w-[400px] md:h-[400px] w-[240px] h-[240px]")

            Div {
                H1("MarkInside")
                .class("leading-[1em] h-[1em] mb-0 mt-0")
            }
            .class("text-center")

            Div {
                Paragraph(language.appDescription)
                language.supportedFeatures
            }
            .class("text-center text-[#d9e6ff]")

            Div {
                DownloadFromMacAppStoreBadge(
                    url: links.appStoreURL,
                    imagePath: language.downloadFromAppStoreLink
                )
                DownloadFromWindowsStoreBadge()
            }
            .class("flex flex-row space-x-1")
        }
        .class("flex flex-col items-center justify-center space-y-2 max-w-[min(580px, 100%)]")
    }
}

private struct DownloadFromMacAppStoreBadge: Component {
    var url: URL
    var imagePath: String
    var body: Component {
        Link(
            url: url,
            label: { Image(imagePath).class("h-[54px]") }
        )
        .class("shadow-none")
    }
}

private struct DownloadFromWindowsStoreBadge: Component {
    var body: Component {
        Element(name: "ms-store-badge") {
            Node<HTML.BodyContext>.script(
                .src("https://getbadgecdn.azureedge.net/ms-store-badge.bundled.js"),
                .async()
            )
        }
        .attribute(named: "productid", value: "9PGRHRK83M62")
        .attribute(named: "size", value: "small")
    }
}