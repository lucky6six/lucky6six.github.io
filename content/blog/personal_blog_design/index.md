---
title: 个人blog技术路线
summary: 各种流行的个人blog方案，选出并配置适合自己的
date: 2024-08-19
authors:
  - admin
tags:
  - Markdown
  - Blox
  - blog
  - config
  - github_page
image:
  caption: "Image credit: [**Unsplash**](https://unsplash.com)"
commentable: true
---
最近想要利用Github Page搭建个人blog,对市面上常见的blog搭建框架做个简单的调研，最后形成了基于Hugo blox生成静态网页，obsidian作为编辑器，利用github托管，并进行一些配置微调的技术方案。
对于笔者来说，进行方案选择主要关注以下几点：
- 比较方便地部署在github page等托管平台
- 支持markdown语法，同时有优化易用特征
- 支持所见即所得，可以实时预览
- 图片拖拽上传并生成对应markdown语法（毕竟这个常用）
- 多端自动同步更新，新修改自动部署
- 配置完成后内容编辑以外需要的手动操作尽可能少
### 网站框架方案选择
#### 动态网站平台 Ghost/WordPress
![](Pasted%20image%2020240819190718.png)
二者是动态博客平台，增加了很多管理功能，但不适合部署静态网站到github page上，虽然可以手动导出内容或利用插件生成静态网站，但流程更繁琐，放弃。

#### 静态网站编辑客户端 Gridea/Publii
![](Pasted%20image%2020240819192317.png)
- 完全图形化界面，以客户端形式编辑内容，适合非技术用户。
- 提供多种主题和插件，轻松定制网站外观和功能。
- 一键部署
- 到 GitHub Pages、Netlify 等静态网站托管服务。
- 支持离线工作，适合隐私保护需求较高的用户。
- ==gridea两年没更新维护了，而且安装包的开发者信息过不了mac检查，主要考虑publii。

**问题：**
- gredea侧边栏可以预览，但图片导入要手动点击导入。还是太麻烦
- 所见即所得编辑器不支持markdown但如果想使用publii还是最推荐这个（markdown编辑器不会实时渲染只能说未来可期，块编辑器有点繁琐）
- publii文件管理倒是不错，拖拽上传图片会自动在站点文件夹内创建副本，但只能以弹出网页的形式预览。
- 支持插件，但暂时没有导出markdown的插件
**总结：** 这种客户端编辑器的形式一般集成了服务商配置的功能，可以进行一键发布，在后端上比较省心，简洁易用。但前端编辑器的实现上不尽人意，内容创作体验较差，只能说未来可期，放弃。（ps：对于**非互联网专业**的朋友来说，这种方案可能是最合适的）
#### 静态网站生成器 Hexo/Hugo blox（原hugo with wowchemy）
![](Pasted%20image%2020240819192532.png)

二者都是静态网站生成器，在配置后用户可以撰写markdown文档，经由框架转换为网站形式。网站的自定义程度高，模版丰富，没有一键式的后端集成，需要自己在github上稍微配置一下（action可抄）编辑方面就是markdown的编辑。
对比二者，笔者选择了Hugo，基于以下特点：
- go语言开发，网站生成速度快，千篇文章秒速生成
- 安装更简洁，配置更灵活
- 强调内置功能，虽然插件生态比hexo更弱，但本体功能的设计更符合笔者需求
- 官方文档及其详尽，易于上手

### 托管平台选择：Github Page
- 简单，免费.
- 社区资源丰富。[Hugo Blox教程资源](https://docs.hugoblox.com/tutorial/blog/)
- 和git与github的关联度高，便于版本管理，上手开销小.
### 编辑器选择：obsidian
到这里其实网站基础已经搭好了，可以在github的codespace中直接编辑网站内容：![](Pasted%20image%2020240819205717.png)但这种方式既不优雅，也不高效，我们还要为hugo blox选择一个编辑器。官方文档给出了如下六种编辑方式，这里笔者只推荐vscode和obsidian两种，其他有兴趣的朋友可以自己尝试。![](Pasted%20image%2020240819205645.png)
#### VScode
![](Pasted%20image%2020240819210556.png)
~~宇宙第一编辑器~~vscode针对代码编辑的超强能力和可拓展性这里不再赘述，只简单说明笔者放弃用它编辑网页的原因：
- 不甚美观
- 不支持所见即所得，在编辑过程中充斥特殊符号和链接，需要展开预览才能看到最终网页效果
- 需要手动git操作进行同步和发布，增加时间成本
当然以上问题都可以通过配置插件解决（大不了自己写插件），而且vscode的自由度是最高的。这里推荐喜欢折腾的专业同学
#### Obsidian
![](Pasted%20image%2020240819212029.png)
obsidian几乎是兼具大而全和简单方便的最好用的本地笔记工具（而且免费）。
笔者选择obsidian的原因如下：
- 全本地存储+原生markdown格式，数据转移与隐私
- 好用的markdown编辑器（媲美Typona）
- 细致的自定义配置选项，满足写作需要
- 丰富的插件社区，实现额外功能
- 支持拖拽上传图片，自动副本保存
### 针对性配置
#### 工作流
![](Pasted%20image%2020240819212117.png)
利用Hugo初始化网页初始化项目仓库，上传github.io仓库，通过github page托管，github action中配置push操作触发网站部署。耗时1min即可见到更新。obsidian将该仓库作为vault打开进行编辑
	vault是obsidian中的知识库单位

#### 选择喜欢的模版，定制化自己的网站
#### obsidian编辑器配置
我们需要微调一下obsidian的默认配置，让它符合Hugo的渲染习惯。
- 首先，hugo渲染给予markdown语法，所以我们要配置obsidian格式尽可能贴近原生markdown（关闭一些易用性优化和模糊处理，如下图中wiki链接）
![](Pasted%20image%2020240819213018.png)
- 此外，hugo要求文章markdown与内容中引用的图片在同层目录（网络图床除外），为了迎合该需求，我们要更改拓展粘贴后自动拷贝的图片存放位置（上图默认存放路径）到当前文件所在文件夹，否则每次拖拽图片都需要移动图片并更改引用路径。
#### 自动化git流
该功能其实并不是很推荐，但如果有怕麻烦的或者频繁更新的朋友可能需要。解决每次在obsidian中编辑完后需要在命令行手动执行git命令，同步远程的问题。

在obsidian第三方插件中，解除安全模式，安装git插件，支持obsidian内手动一键提交，且可以设置定时备份（commit & push），定时同步（pull），请可以自定义时间间隔及提交信息（commit message）。~~懂得人看图就懂~~![](Pasted%20image%2020240819212602.png)
#### Hugo中的特殊标记
##### Mindmaps
<div class="highlight">
<pre class="chroma">
<code>
```markmap {height="200px"}
- Hugo Modules
  - Hugo Blox
  - blox-plugins-netlify
  - blox-plugins-netlify-cms
  - blox-plugins-reveal
```
</code>
</pre>
</div>
renders as
```markmap {height="200px"}
- Hugo Modules
  - Hugo Blox
  - blox-plugins-netlify
  - blox-plugins-netlify-cms
  - blox-plugins-reveal
```
##### Highlighting
<mark>Highlight</mark> important text with `mark`:
```html
<mark>Highlighted text</mark>
```
##### Callouts

Use [callouts](https://docs.hugoblox.com/reference/markdown/#callouts) (aka _asides_, _hints_, or _alerts_) to draw attention to notes, tips, and warnings.

By wrapping a paragraph in `{{%/* callout note */%}} ... {{%/* /callout */%}}`, it will render as an aside.

```markdown
{{%/* callout note */%}}
A Markdown aside is useful for displaying notices, hints, or definitions to your readers.
{{%/* /callout */%}}
```

renders as

{{% callout note %}}
A Markdown aside is useful for displaying notices, hints, or definitions to your readers.
{{% /callout %}}

Or use the `warning` callout type so your readers don't miss critical details:

{{% callout warning %}}
A Markdown aside is useful for displaying notices, hints, or definitions to your readers.
{{% /callout %}}

### 引入评论功能（基于giscus）

#### 在hugo网站中引入comment配置，provider选择giscus

`params.yaml`
```yaml
# Site features
features:
  math:
    enable: false
  privacy_pack:
    enable: false
  repository:
    url: 'https://github.com/HugoBlox/hugo-blox-builder/'
    content_dir: starters/blog/content
    branch: main
  comment:
    # Choose a provider: giscus, disqus, commento, or '' to disable commenting
    provider: 'giscus'
    giscus:
      repo: ''
      repo_id: ''
      category: ''
      category_id: ''
      theme: preferred_color_scheme
      language_code: en
      mapping: pathname
    disqus:
      # Paste the shortname from your Disqus dashboard.
      shortname: ''
      # Show comment count in page header? (true/false)
      show_count: true
    commento:
      # If you self-host Commento, enter your custom Commento URL here.
      url: ''
```
#### 配置giscus
1. 选择一个仓库安装 giscus
点击 [这里](https://github.com/apps/giscus) 进入 giscus app 的 安装界面，大概长这样：
![](Pasted%20image%2020240820161304.png)点击安装，一般选择github page托管的网站仓库即可，后续 giscus 就会从该仓库读取数据。
2. 开启 Discussions
然后打开之前选择的仓库，进入设置界面，勾选上 Discussions 以开启该仓库的 Discussions。
3. 从 giscus 官网获取配置信息
完成上述准备工作后就可以访问 [giscus 官网](https://giscus.app/zh-CN) 获取配置信息了，具体如下：
- 映射关系：一般使用pathname
- discussion分类：推荐使用announcements
- 勾选只搜索该分类中的discussion
4. 配置完成后，会生成一个配置文件，主要关注以下字段：配置到blog对应位置（即上一步的yaml文件中）即可。
- data-repo
- data-repo-id
- data-category
- data-category-id
- data-mapping
#### discussion
有人评论后，giscus 会自动在配置好的仓库的 discussion 里创建一条数据用于保存评论。
![../../../img/blog/giscus/discussion-manage.png](https://www.lixueduan.com/img/blog/giscus/discussion-manage.png "discussion-manage")

在这里可以对评论进行管理
