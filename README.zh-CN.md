# Xiaomi 13 相机内核兼容层

[English](README.md) | 简体中文

这是用于 Xiaomi 13（`fuxi`）LineageOS 23.2 / Android 16 相机与 OIS 修复的可复现源码覆盖层。

> [!WARNING]
> Release 中的文件是**预发布、绑定特定构建的恢复工件**，不是通用刷机包。只有在设备确为 `fuxi`，且 ROM、内核 ABI、分区布局、镜像哈希及回滚路径均匹配时才可使用。错误镜像可能导致系统无法启动。

仓库只保留 18 个修改或新增的相机内核文件，不镜像 LineageOS 或 Xiaomi 的完整源码树。`scripts/Apply-Overlay.ps1` 仅会在 modules 仓库工作区干净且位于固定提交时应用覆盖。

## 修复内容

- 恢复 BU24721 厂商 OIS 固件初始化及后处理流程。
- 恢复 Xiaomi 实现使用的 OIS 固件名缓冲区大小。
- 恢复执行器 park-lens 工作线程。
- 补充厂商路径所需的 CCI 与传感器兼容改动。
- 恢复相机流水线需要的 flush-request 处理。

这些改动与 [UPSTREAMS.zh-CN.md](UPSTREAMS.zh-CN.md) 中固定的提交绑定。每次更新内核或 `vendor_dlkm` 后，都必须重新审阅、rebase 与构建。

## 复现

1. 克隆两个 LineageOS 仓库并 checkout 到固定提交。
2. 执行 `./scripts/Apply-Overlay.ps1 -ModulesRepo '<modules-repo-path>'`。
3. 准备与目标 ROM 匹配的 clang 工具链及内核输出目录。
4. 在 Linux/WSL 中运行 `scripts/build-camera-module.sh`。
5. 校验模块；如确有需要，仅重打包与目标构建匹配的 `vendor_dlkm` 副本。
6. 严格遵循[刷写与回滚指南](docs/flash-and-rollback.zh-CN.md)，不得使用隐式设备或分区槽位。

本地验证过的 production-v11 工件位于 GitHub 预发布中，不进入 Git 历史；SHA-256 见 [RELEASES.md](RELEASES.md)。“已验证”仅指记录中的单一构建链，不保证兼容其他 ROM 或内核。

## 贡献、安全与许可

提交 PR 前请阅读 [CONTRIBUTING.zh-CN.md](CONTRIBUTING.zh-CN.md)。安全问题请使用 GitHub 私密漏洞报告，不要创建公开 Issue；参见 [SECURITY.md](SECURITY.md)。

覆盖文件在适用范围内遵循 GPL-2.0-only，文件中已有的许可证声明及上游条款具有优先效力。来源见 [NOTICE.md](NOTICE.md) 与 [UPSTREAMS.zh-CN.md](UPSTREAMS.zh-CN.md)。
