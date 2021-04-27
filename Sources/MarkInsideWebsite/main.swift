import Foundation
import Publish
import Plot

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
    var appStoreURL = URL(string: "https://markinside.intii.com")!
    var windowsStoreURL = URL(string: "https://markinside.intii.com")!
}

// This will generate your website using the built-in Foundation theme:
try MarkInsideWebsite().publish(
    withTheme: .this,
    deployedUsing: .gitHub("intitni/MarkInsideWebsite")
)
