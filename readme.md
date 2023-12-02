没想到挺容易破解的

要做两件事：

1. 修改与激活相关的注册表
2. 添加防火墙规则，阻止连接
（目前是阻止了全部的联网，待研究：如何只拦截认证请求，保留联网功能）

把这两个操作做成了 powershell 脚本，一键破解。

如果想保留联网功能，另一种可能的方式是，每次运行前更新注册表，然后用ahk隐藏激活窗口。激活窗口弹出期间软件还是处于已破解状态/


[github.com/john-walks-slow/eudic-crack](https://github.com/john-walks-slow/eudic-crack)
