import Plot
import Publish

struct TemplatesPageContent: Component {
    @EnvironmentValue(.language) var language

    var body: Component {
        return ComponentGroup {
            H2 {
                ComponentGroup(html: """
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="w-[1em] h-[1em]">
                  <path d="M11.25 5.337c0-.355-.186-.676-.401-.959a1.647 1.647 0 01-.349-1.003c0-1.036 1.007-1.875 2.25-1.875S15 2.34 15 3.375c0 .369-.128.713-.349 1.003-.215.283-.401.604-.401.959 0 .332.278.598.61.578 1.91-.114 3.79-.342 5.632-.676a.75.75 0 01.878.645 49.17 49.17 0 01.376 5.452.657.657 0 01-.66.664c-.354 0-.675-.186-.958-.401a1.647 1.647 0 00-1.003-.349c-1.035 0-1.875 1.007-1.875 2.25s.84 2.25 1.875 2.25c.369 0 .713-.128 1.003-.349.283-.215.604-.401.959-.401.31 0 .557.262.534.571a48.774 48.774 0 01-.595 4.845.75.75 0 01-.61.61c-1.82.317-3.673.533-5.555.642a.58.58 0 01-.611-.581c0-.355.186-.676.401-.959.221-.29.349-.634.349-1.003 0-1.035-1.007-1.875-2.25-1.875s-2.25.84-2.25 1.875c0 .369.128.713.349 1.003.215.283.401.604.401.959a.641.641 0 01-.658.643 49.118 49.118 0 01-4.708-.36.75.75 0 01-.645-.878c.293-1.614.504-3.257.629-4.924A.53.53 0 005.337 15c-.355 0-.676.186-.959.401-.29.221-.634.349-1.003.349-1.036 0-1.875-1.007-1.875-2.25s.84-2.25 1.875-2.25c.369 0 .713.128 1.003.349.283.215.604.401.959.401a.656.656 0 00.659-.663 47.703 47.703 0 00-.31-4.82.75.75 0 01.83-.832c1.343.155 2.703.254 4.077.294a.64.64 0 00.657-.642z" />
                </svg>
                """)
                Span(html: t(.title))
            }.class("flex flex-row items-center space-x-1 text-left")
            t(parsing: .introduction)
            Div {
                t(parsing: .usage)
            }.class("p-4 pb-3 bg-slate-300 bg-opacity-20 rounded-lg text-[0.8em]")
            Template(
                title: t(.qrCodeTitle),
                imagePath: "/templates/QRCode.markinside.template.png",
                introduction: t(parsing: .qrCodeIntroduction)
            )
            Template(
                title: t(.markdownTitle),
                imagePath: "/templates/Markdown.markinside.template.png",
                introduction: t(parsing: .markdownIntroduction)
            )
            Template(
                title: t(.mindMapTitle),
                imagePath: "/templates/MindMap.markinside.template.png",
                introduction: t(parsing: .mindMapIntroduction)
            )
            Template(
                title: t(.syntaxHighlightingTitle),
                imagePath: "/templates/SyntaxHighlighting.markinside.template.png",
                introduction: t(parsing: .syntaxHighlightingIntroduction)
            )
        }.class("[&_code]:border-[1px] [&_code]:border-slate-200 [&_code]:border-solid [&_code]:rounded-sm [&_code]:text-[0.8em] [&_code]:px-0.5 [&_code]:bg-opacity-10 [&_code]:bg-white")
    }
}

extension TemplatesPageContent {
    struct Template: Component {
        var title: String
        var imagePath: String
        var introduction: Component

        var body: Component {
            Div {
                H3(title)
                    .class("text-lg font-bold")
                introduction
                Div {
                    Image(url: imagePath + "?rad=\(Int.random(in: 1000 ... 10000))", description: title)
                        .class("max-w-[70%] max-h-[300px] drop-shadow-2xl")
                    Link(url: imagePath) {
                        ComponentGroup(html: """
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4">
                          <path stroke-linecap="round" stroke-linejoin="round" d="M3 16.5v2.25A2.25 2.25 0 005.25 21h13.5A2.25 2.25 0 0021 18.75V16.5M16.5 12L12 16.5m0 0L7.5 12m4.5 4.5V3" />
                        </svg>
                        """)
                    }
                    .attribute(named: "download", value: nil, ignoreValueIfEmpty: false)
                    .class("absolute top-1 right-1 py-1 px-2 border-1 border-slate-300 rounded bg-slate-50 drop-shadow-2xl text-slate-500 text-xs")
                }.class("bg-blue-100 flex items-center justify-center p-2 rounded-lg border relative")

            }.class("mx-auto my-8 text-sm")
        }
    }
}

extension TemplatesPageContent: LocalizedComponent {
    enum I18nKey: Hashable, CaseIterable {
        case title
        case introduction
        case usage
        case qrCodeTitle
        case qrCodeIntroduction
        case markdownTitle
        case markdownIntroduction
        case mindMapTitle
        case mindMapIntroduction
        case syntaxHighlightingTitle
        case syntaxHighlightingIntroduction
    }

    var i18nDict: [Language: [I18nKey: String]] { [
        .chinese: I18nKey.allCases.reduce(into: [:]) { partialResult, key in
            partialResult[key] = {
                switch key {
                case .title:
                    return "模板 (v1.3.0+)"
                case .introduction: 
                    return """
                    MarkInside 中的模板就像很多其他 app 中的插件那样，能够绕过懒惰的开发者为 MarkInside 带来更多的功能。
                    """
                case .usage:
                    return """
                    只需要将下方的图片拖入模板文件夹即可安装对应模板。模板文件夹可以通过点击菜单栏的 `文件 > 模板收藏夹 > 打开模板文件夹` 打开。添加之后，模板会出现在 `模板收藏夹` 中。
                    
                    你也可以把模板放在任意位置，并通过菜单栏的 `文件 > 使用模板` 使用它们。实际上所有通过 MarkInside 生成的图片都能作为模板使用。
                    """
                case .qrCodeTitle:
                    return "二维码"
                case .qrCodeIntroduction:
                    return "使用 [qr-creator](https://github.com/nimiq/qr-creator/) 创建二维码。"
                case .markdownTitle:
                    return "Markdown"
                case .markdownIntroduction:
                    return """
                    使用 [marked](https://marked.js.org/) 渲染 markdown。

                    因为 markdown 支持表格，如果你想快速地创建表格，也可以使用这个模板。
                    """
                case .mindMapTitle:
                    return "思维导图"
                case .mindMapIntroduction:
                    return "使用 [markmap](https://markmap.js.org) 通过 markdown 创建思维导图。"
                case .syntaxHighlightingTitle:
                    return "代码高亮"
                case .syntaxHighlightingIntroduction:
                    return """
                    使用 [Prism](https://prismjs.com) 高亮代码。

                    模板支持的插件有：
                    
                    - 行高亮（Line Highlight）
                    - 显示行标（Line Numbers）
                    - 高亮 Diff（Diff Highlight）

                    你可以根据自己的需求修改模板增加其他插件。
                    """
                }
            }()
        },
        .xDefault: I18nKey.allCases.reduce(into: [:]) { partialResult, key in
            partialResult[key] = {
                switch key {
                case .title:
                    return "Templates (v1.3.0+)"
                case .introduction: 
                    return """
                    Templates in MarkInside are like plugins in other apps. It helps you to enhance MarkInside without asking the lazy developer.
                    """
                case .usage:
                    return """
                    To install a template, just drag the images below into the template folder. You can open the template folder by clicking `File > Template Collection > Open Template Folder` from the menu bar. The installed templates will be available in the `Template Collection` after that.
                    
                    You can also store the templates anywhere and use them by clicking `File > Use Template`. All files created by MarkInside can be used as templates.
                    """
                case .qrCodeTitle:
                    return "QRCode"
                case .qrCodeIntroduction:
                    return "Generate QRCode of input texts. Powered by [qr-creator](https://github.com/nimiq/qr-creator/)."
                case .markdownTitle:
                    return "Markdown"
                case .markdownIntroduction:
                    return """
                    Render markdown into image. Powered by [marked](https://marked.js.org/).

                    This template is also helpful when you need to create tables.
                    """
                case .mindMapTitle:
                    return "Mind Map"
                case .mindMapIntroduction:
                    return "Create mind map by writing markdown. Powered by [markmap](https://markmap.js.org)."
                case .syntaxHighlightingTitle:
                    return "Syntax Highlighting"
                case .syntaxHighlightingIntroduction:
                    return """
                    Highlight the syntax of your code. Powered by [Prism](https://prismjs.com).

                    The currently supported plugins in this template are:

                    - Line Highlight
                    - Line Numbers
                    - Diff Highlight

                    But you are always free to mutate the template and add more plugins!
                    """
                }
            }()
        },
    ] }
}


