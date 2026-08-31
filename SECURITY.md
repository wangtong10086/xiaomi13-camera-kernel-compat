# Security policy / 安全政策

## Reporting / 报告方式

Use GitHub private vulnerability reporting for vulnerabilities, unsafe flash behavior, or accidental exposure of sensitive data. Do not open a public issue before a fix is available.

如发现漏洞、不安全刷写行为或敏感数据意外暴露，请使用 GitHub 私密漏洞报告；修复可用前不要创建公开 Issue。

Include the affected commit or release, device/product, ROM and kernel versions, reproduction steps, impact, and sanitized diagnostics. Never send signing keys, account credentials, FCM/XMSF registration IDs, device serials, message content, wallet data, or raw private databases.

请提供受影响提交或 Release、设备产品名、ROM 与内核版本、复现步骤、影响及脱敏诊断信息。切勿发送签名密钥、账户凭据、FCM/XMSF 注册 ID、设备序列号、消息正文、钱包数据或原始私有数据库。

## Supported versions / 支持范围

Only the latest source on `main` and explicitly listed prerelease artifacts are reviewed. Compatibility is limited to the exact build lineage documented with each artifact; there is no blanket support for other kernels or ROMs.

仅审阅 `main` 最新源码及明确列出的预发布工件。兼容性只覆盖每个工件记录的精确构建链，不承诺支持其他内核或 ROM。
