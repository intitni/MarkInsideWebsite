import Foundation
import Plot
import Publish

// This type acts as the configuration for your website.
struct MarkInsideWebsite: Website {
    enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case zh_cn = "zh-cn"
    }

    struct ItemMetadata: WebsiteItemMetadata {}

    // Update these properties to configure your website:
    var url = URL(string: "https://markinside.intii.com")!
    var name = "MarkInside for macOS and Windows"
    var description = "MarkInside for macOS and Windows"
    var language: Language { .english }
    var imagePath: Path? { nil }
}

struct Links {
var appStoreURL: URL { URL(string: "https://apps.apple.com/cn/app/markinside/id1551813400")! }
    var windowsStoreURL: URL { URL(string: "https://markinside.intii.com")! }
    var changeLogURL: URL { URL(string: "https://www.craft.do/s/3U2bTBDh3YGYG7")! }
    var privacyPolicyURL: URL { URL(string: "https://www.craft.do/s/202QeKkBT1MksS")! }
    var gTagURL: URL { URL(string: "https://www.googletagmanager.com/gtag/js?id=G-GXHVET7ERS")! }
}

extension Website {
    var links: Links { .init() }
}

// This will generate your website using the built-in Foundation theme:
try MarkInsideWebsite().publish(
    withTheme: .this,
    deployedUsing: .gitHub("intitni/MarkInsideWebsite"),
    additionalSteps: [
        .installPlugin(.tailwindcss(
            themeFilePath: "Resources/theme.css",
            configFilePath: "Resources/tailwind.config.js",
            outputFilePath: "styles.css"
        )),
    ]
)
