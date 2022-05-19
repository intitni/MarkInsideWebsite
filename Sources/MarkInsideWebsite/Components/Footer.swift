import Plot
import Publish

struct Footer: Component {
    @EnvironmentValue(.language) var language
    @EnvironmentValue(.links) var links

    var body: Component {
        Plot.Footer(content: {
            Paragraph("©2022 MarkInside")
            Paragraph {
                Link(url: "mailto:markinsideapp@intii.com") {
                    Text(language.contactMe)
                }
            }
            Node<HTML.BodyContext>.script(
                .attribute(.src(links.gTagURL)), 
                .async()
            )
            Node<HTML.BodyContext>.script(.raw("""
            window.dataLayer = window.dataLayer || [];
            function gtag(){dataLayer.push(arguments);}
            gtag('js', new Date());
            gtag('config', 'G-GXHVET7ERS');
            """))
        })
        .class("flex justify-between items-center h-[120px]")
    }
}