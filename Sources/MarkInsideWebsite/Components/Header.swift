import Plot
import Publish

struct Header: Component {
    @EnvironmentValue(.language) var language
    @EnvironmentValue(.links) var links
    
    var body: Component {
        Plot.Header {
            Div {
                Paragraph {
                    Link(
                        language.changelog,
                        url: links.changeLogURL
                    )
                }
                Paragraph {
                    Link(
                        language.privacyPolicy,
                        url: links.privacyPolicyURL
                    )
                }
            }.class("flex flex-row justify-end space-x-4 text-xs")
        }
    }
}
