# Before 30 Blog

一个基于 Astro 搭建的极简中文博客，内容以 Markdown 维护，站点地址为 `https://blog.before30.site`。

## 项目定位

- 用最简单的方式写博客：一篇文章对应一个目录，一个 `index.md`
- 内容优先：尽量减少后台、数据库和复杂构建逻辑
- 部署简单：本地写作，推送到 GitHub 后由 Vercel 自动构建发布

## 技术栈

- Astro 6
- Markdown Content Collections
- `@astrojs/sitemap`
- `@astrojs/rss`
- Vercel

## 环境要求

- Node.js `>= 22.12.0`
- npm

项目要求见 [package.json](/Users/hpyi/Blog/package.json#L1)。

## 本地运行

在项目根目录执行：

```bash
npm install
npm run dev
```

启动后默认访问：

```text
http://localhost:4321
```

常用命令：

| 命令 | 作用 |
| :-- | :-- |
| `npm run dev` | 启动本地开发服务器 |
| `npm run build` | 构建生产版本到 `dist/` |
| `npm run preview` | 本地预览构建结果 |
| `npm run astro -- --help` | 查看 Astro CLI 帮助 |
| `npm run push` | 自动提交并推送当前改动 |

## 写文章流程

推荐每篇文章使用一个独立目录：

```text
src/content/blog/my-post/
├── index.md
└── cover.jpg
```

这样做的好处：

- URL 稳定，路径清晰
- 图片和正文放在一起，后续维护更省心
- 不需要单独管理文章资源目录

创建新文章示例：

```bash
mkdir -p src/content/blog/2026-04-01-my-new-post
cp templates/blog-post-template.md src/content/blog/2026-04-01-my-new-post/index.md
```

然后编辑：

[`templates/blog-post-template.md`](/Users/hpyi/Blog/templates/blog-post-template.md)

文章 frontmatter 当前字段包括：

- `title`
- `description`
- `pubDate`
- `tags`

示例：

```md
---
title: "这里写文章标题"
description: "这里写文章摘要，会出现在列表页和 SEO 描述中。"
pubDate: 2026-04-01
tags: ["标签1", "标签2"]
---
```

## 图片使用方式

如果文章需要插图，把图片放在文章目录内，直接在 Markdown 中用相对路径引用：

```md
![封面图](./cover.jpg)
```

示例可参考：

[`src/content/blog/hello-astro/index.md`](/Users/hpyi/Blog/src/content/blog/hello-astro/index.md)

## 目录结构

```text
.
├── public/                  # 静态资源
├── scripts/                 # 辅助脚本
├── src/
│   ├── components/          # 页面组件
│   ├── content/blog/        # 博客文章内容
│   ├── layouts/             # 页面布局
│   ├── pages/               # 路由页面
│   └── styles/              # 全局样式
├── templates/               # 写作模板
├── astro.config.mjs
└── package.json
```

## 自动提交脚本

项目内置了一个快捷脚本：

```bash
npm run push
```

它会调用：

[`scripts/push.sh`](/Users/hpyi/Blog/scripts/push.sh#L1)

脚本行为：

1. 检查当前目录是否为 Git 仓库
2. 检查是否存在未提交改动
3. 自动执行 `git add .`
4. 自动提交
5. 自动执行 `git push`

如果你没有传入提交信息，会自动生成默认 message，例如：

```text
chore: update blog 2026-04-01 21:30:00
```

也可以自定义提交信息：

```bash
bash scripts/push.sh "feat: add new post"
```

注意：这个脚本会把当前所有变更一起提交，使用前先确认工作区内容符合预期。

## 部署方式

当前推荐部署链路：

```text
本地写 Markdown -> push 到 GitHub -> Vercel 自动构建 -> 发布到 blog.before30.site
```

站点域名配置位于：

[`astro.config.mjs`](/Users/hpyi/Blog/astro.config.mjs#L1)

当前配置：

```js
site: 'https://blog.before30.site'
```

这会影响：

- sitemap
- RSS
- SEO canonical URL

如果需要完整部署说明，见：

[`DEPLOY_VERCEL_WEB.md`](/Users/hpyi/Blog/DEPLOY_VERCEL_WEB.md)

## 当前站点信息

站点标题和描述定义在：

[`src/consts.ts`](/Users/hpyi/Blog/src/consts.ts#L1)

当前值：

```ts
export const SITE_TITLE = 'Before 30';
export const SITE_DESCRIPTION = '一个只写 Markdown 的极简中文博客。';
```

## 建议工作流

1. 在 `src/content/blog/` 下新建文章目录
2. 从模板复制 `index.md`
3. 本地执行 `npm run dev` 预览
4. 确认无误后执行 `npm run push` 或手动 Git 提交
5. 等待 Vercel 自动部署

## 后续可补充内容

如果后面这个博客继续演进，README 还可以再补：

- 不知道啊
