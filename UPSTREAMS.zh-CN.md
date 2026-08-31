# 固定上游

[English](UPSTREAMS.md) | 简体中文

| 用途 | 仓库 | 提交 |
| --- | --- | --- |
| 内核构建树 | `https://github.com/LineageOS/android_kernel_xiaomi_sm8550.git` | `03e6e48a5b4ed606dfdd48bc782a57f9c778938b` |
| 外部内核模块 | `https://github.com/LineageOS/android_kernel_xiaomi_sm8550-modules.git` | `f5956ffd9766dcdae24a9f5c6a0c7512bb6b5f5a` |
| Xiaomi fuxi 相机参考 | `https://github.com/MiCode/vendor_qcom_opensource_camera-kernel.git` | `6c6099a85cb3154fc8a744c17b6b9f5fd361dea8` |
| 较新的 Xiaomi 相机参考 | `https://github.com/xiaomi-8550-kernel/vendor_qcom_opensource_camera-kernel.git` | `b9d1ea0985575f473957d6cae93e4fa7183a120d` |

覆盖层只针对前两个精确提交验证。两个 Xiaomi checkout 用于比对厂商行为，不是构建输入。

升级时先比较上游相机改动，再按 CCI、执行器、OIS、UAPI 的小组顺序重放覆盖，并在每组之后编译。
