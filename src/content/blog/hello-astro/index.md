---
title: "我的第一篇博客"
description: "使用 Astro 和 Markdown 搭建 blog.before30.site 的起点。"
pubDate: 2026-03-31
tags: ["Astro", "博客", "Markdown"]
---

这是博客的第一篇文章。

以后新增文章时，推荐在 `src/content/blog/` 下为每篇文章创建一个独立文件夹，并把正文写在 `index.md` 里。

## 这套博客的工作流

1. 本地写 Markdown
2. 推送到 GitHub
3. Vercel 或服务器拉取最新代码
4. 重新构建并部署

## 文件夹和链接

当前文件路径是：

`src/content/blog/hello-astro/index.md`

最终页面地址会是：

`/blog/hello-astro/`

后续你可以继续使用英文 slug 作为文件夹名，保持 URL 简洁稳定。

## 本地图片引用

当一篇文章需要插图时，可以把图片和 `index.md` 放在同一个目录里，然后直接使用相对路径：

![示例图片](./sample.jpg)

这样文章和资源会长期保持在一起，后续维护最省心。
