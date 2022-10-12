import Plot
import Publish

struct PageBody: Component {
    var content: Component

    var body: Component {
        Element(name: "body") {
            Header(showReturnToHomeButton: true)
            Article {
                content
            }
            .class("mt-2 mb-8")
            Footer()
        }
        .class("max-w-[800px] pl-2 pr-2 flex flex-col justify-center mr-auto ml-auto")
    }
}
