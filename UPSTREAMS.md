# Pinned upstreams

English | [简体中文](UPSTREAMS.zh-CN.md)

| Purpose | Repository | Commit |
| --- | --- | --- |
| Kernel build tree | `https://github.com/LineageOS/android_kernel_xiaomi_sm8550.git` | `03e6e48a5b4ed606dfdd48bc782a57f9c778938b` |
| External kernel modules | `https://github.com/LineageOS/android_kernel_xiaomi_sm8550-modules.git` | `f5956ffd9766dcdae24a9f5c6a0c7512bb6b5f5a` |
| Xiaomi fuxi camera reference | `https://github.com/MiCode/vendor_qcom_opensource_camera-kernel.git` | `6c6099a85cb3154fc8a744c17b6b9f5fd361dea8` |
| Newer Xiaomi camera reference | `https://github.com/xiaomi-8550-kernel/vendor_qcom_opensource_camera-kernel.git` | `b9d1ea0985575f473957d6cae93e4fa7183a120d` |

The overlay was validated against the first two exact commits. The Xiaomi checkouts are references for vendor behavior; they are not build inputs.

For an upgrade, compare upstream camera changes first, then replay the overlay in small groups (CCI, actuator, OIS, UAPI) and compile after each group.
