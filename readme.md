没想到挺容易破解的

要做两件事：

1. 修改与激活相关的注册表
2. 添加防火墙规则，阻止 https 连接 （虽然很粗疏，但貌似可以实现只拦截认证请求，保留 在线词典 / 翻译 / Ai 等功能）

把这两个操作做成了 powershell 脚本，一键破解。

[github.com/john-walks-slow/eudic-crack](https://github.com/john-walks-slow/eudic-crack)
