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
    var favicon: Favicon? { .init(path: "favicon.png") }
}

struct Links {
    var appStoreURL: URL { URL(string: "https://apps.apple.com/cn/app/markinside/id1551813400")! }
    var windowsStoreURL: URL { URL(string: "https://www.microsoft.com/store/apps/9PGRHRK83M62")! }
    var changeLogURL: URL { URL(string: "https://intii.craft.me/3U2bTBDh3YGYG7")! }
    var changeLogChineseURL: URL { URL(string: "https://intii.craft.me/EDRauaO42w8f7g")! }
    var privacyPolicyURL: URL { URL(string: "https://intii.craft.me/202QeKkBT1MksS")! }
    var privacyPolicyChineseURL: URL { URL(string: "https://intii.craft.me/DQ7DmXraIklRHL")! }
    var gTagURL: URL { URL(string: "https://www.googletagmanager.com/gtag/js?id=G-GXHVET7ERS")! }
}

extension Website {
    var links: Links { .init() }
}

// This will generate your website using the built-in Foundation theme:
try MarkInsideWebsite().publish(
    withTheme: .this,
    deployedUsing: .gitHub("intitni/MarkInsideWebsite")
)
