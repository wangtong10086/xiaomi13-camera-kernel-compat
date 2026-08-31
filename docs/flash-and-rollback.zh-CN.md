# 刷写与回滚

[English](flash-and-rollback.md) | 简体中文

本仓库有意不自动执行刷写。`vendor_dlkm` 镜像与设备、构建、ABI、分区和槽位强绑定；Release 是面向 `fuxi` 的预发布恢复工件，不是通用更新包。

刷写前必须：

1. 将当前原始镜像及 SHA-256 保存在手机之外的恢复目录。
2. 确认只连接了目标手机，并记录明确的 fastboot serial。
3. 从 fastboot 读取 `product`、`current-slot` 与目标分区大小。
4. 校验新镜像哈希并确认未超过逻辑分区大小。
5. 确认 Android 黑屏时仍能返回 fastboot。
6. 核对 ROM 构建、内核提交、模块 ABI 与 `fuxi` 产品名。

示例只用于检查；必须替换所有占位符：

```powershell
$serial = '<explicit-fastboot-serial>'
fastboot -s $serial getvar product
fastboot -s $serial getvar current-slot
fastboot -s $serial getvar partition-size:vendor_dlkm_b
Get-FileHash -Algorithm SHA256 ./vendor_dlkm_b-fuxi-production-v11.img
```

只有在物理设备、产品名、活动/非活动槽策略、精确目标分区与回滚镜像全部确认后，才可运行对应的 `fastboot -s <serial> flash <exact-partition> <image>`。

若 Android 黑屏或相机服务反复崩溃，请立即回到 fastboot，并把为该精确分区保存的镜像恢复。在基础内核状态未知时，不要叠加更多模块。
