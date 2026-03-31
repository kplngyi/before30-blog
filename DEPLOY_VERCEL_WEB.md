# Vercel 网页版部署教程

这份文档只讲最简单的一条路径：

`本地写 Markdown -> push 到 GitHub -> Vercel 网页后台自动部署 -> 绑定 blog.before30.site`

适合当前这个 Astro 极简博客项目，不涉及服务器手动拉取部署。

---

## 1. 前提条件

部署前请先确认下面几件事已经完成：

- 本地项目已经能正常运行
- 代码已经推送到 GitHub
- 你有一个 Vercel 账号
- 你拥有域名 `before30.site`，并且能修改它的 DNS

当前项目仓库：

```text
https://github.com/kplngyi/before30-blog
```

当前正式博客域名目标：

```text
blog.before30.site
```

---

## 2. 在 Vercel 导入 GitHub 仓库

打开：

```text
https://vercel.com/new
```

然后按下面步骤操作：

1. 登录 Vercel
2. 选择 `Continue with GitHub`
3. 在仓库列表里找到 `before30-blog`
4. 点击 `Import`

如果第一次使用 Vercel，它可能会要求你授权读取 GitHub 仓库，按提示授权即可。

---

## 3. 检查项目构建配置

Vercel 通常会自动识别 Astro 项目。

导入项目后，确认这几个配置：

- Framework Preset: `Astro`
- Build Command: `npm run build`
- Output Directory: `dist`
- Install Command: `npm install`

如果页面显示的就是这些默认值，直接继续即可。

然后点击：

```text
Deploy
```

---

## 4. 等待首次部署完成

第一次部署完成后，Vercel 会给你一个默认访问地址，通常类似：

```text
https://before30-blog.vercel.app
```

先打开这个地址确认：

- 首页能打开
- `/blog` 文章列表能打开
- `/blog/hello-astro/` 文章详情页能打开

如果这些页面都正常，说明部署已经成功。

---

## 5. 绑定正式域名 `blog.before30.site`

进入当前项目后台：

1. 打开项目 `before30-blog`
2. 点击 `Settings`
3. 点击 `Domains`
4. 输入：

```text
blog.before30.site
```

5. 点击 `Add`

添加以后，Vercel 会提示你需要配置一条 DNS 记录。

---

## 6. 在域名服务商处配置 DNS

去你的域名管理平台，找到 `before30.site` 的 DNS 设置页面。

你需要新增一条子域名记录。通常会是：

```text
Type: CNAME
Name: blog
Value: cname.vercel-dns.com
TTL: Auto
```

注意：

- 这里的 `Value` 以 Vercel 页面实时显示的值为准
- 如果 Vercel 给你的不是 `cname.vercel-dns.com`，就按它页面提示填写
- 不要自己猜目标地址

如果你的 DNS 托管在 Cloudflare：

- 先设置为 `DNS only`
- 不要一开始就启用代理

---

## 7. 回到 Vercel 验证域名

DNS 配置保存后，回到 Vercel 项目的 `Settings -> Domains` 页面等待验证。

当页面显示类似下面的状态时，说明已经生效：

```text
Valid Configuration
```

之后就可以通过正式域名访问博客：

```text
https://blog.before30.site
```

---

## 8. 当前项目里和域名有关的配置

当前 Astro 项目已经配置好了正式站点地址：

文件：

[`astro.config.mjs`](/Users/hpyi/Blog/astro.config.mjs)

核心配置：

```js
site: 'https://blog.before30.site'
```

这个配置会影响：

- sitemap
- RSS
- SEO 相关链接生成

所以这里不需要再改。

---

## 9. 后续如何更新博客

以后每次发新文章，只需要在本地操作：

```bash
cd /Users/hpyi/Blog
```

新建文章目录：

```bash
mkdir -p src/content/blog/2026-04-01-my-new-post
touch src/content/blog/2026-04-01-my-new-post/index.md
```

本地预览：

```bash
npm run dev
```

提交并推送：

```bash
git add .
git commit -m "feat: add new post"
git push
```

推送后，Vercel 会自动：

- 拉取 GitHub 最新代码
- 自动构建
- 自动更新线上站点

你不需要再手动登录服务器。

---

## 10. 推荐的文章目录结构

建议每篇文章一个文件夹：

```text
src/content/blog/
└── my-new-post/
    ├── index.md
    ├── cover.jpg
    └── image-1.png
```

在 `index.md` 中直接使用相对路径引用图片：

```md
![封面](./cover.jpg)
![插图](./image-1.png)
```

最终文章地址会是：

```text
/blog/my-new-post/
```

---

## 11. 常见问题

### Q1：为什么 GitHub 推送了，但网站没更新？

先检查：

- GitHub 仓库里是否真的有最新提交
- Vercel 项目是否连接的是正确仓库
- Vercel 的 `Deployments` 页面里是否构建失败

---

### Q2：为什么域名一直没有生效？

先检查：

- DNS 记录是否填错
- 记录类型是否应该是 `CNAME`
- 是否还没有等待足够时间
- 是否被 CDN 或代理配置干扰

---

### Q3：以后还需要服务器吗？

如果你采用的是 `GitHub + Vercel` 方案：

- 这个博客不再依赖你自己的 Linux 服务器部署
- 只要 GitHub 和 Vercel 正常即可

---

## 12. 最简流程总结

第一次部署：

1. 把代码推到 GitHub
2. 在 Vercel 导入仓库
3. 点击 Deploy
4. 添加域名 `blog.before30.site`
5. 配置 DNS

以后更新：

```bash
git add .
git commit -m "feat: add new post"
git push
```

然后等待 Vercel 自动部署完成。
