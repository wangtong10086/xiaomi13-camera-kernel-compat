# Source and license notice

This repository is a small derivative overlay assembled from publicly available Linux and Qualcomm/Xiaomi camera-kernel sources. It does not grant rights to proprietary Xiaomi firmware or binaries.

The build baseline is LineageOS `android_kernel_xiaomi_sm8550-modules` commit `f5956ffd9766dcdae24a9f5c6a0c7512bb6b5f5a`, paired with kernel commit `03e6e48a5b4ed606dfdd48bc782a57f9c778938b`. Vendor behavior was compared with the public camera repositories and commits listed in [UPSTREAMS.md](UPSTREAMS.md).

Most overlay files carry `SPDX-License-Identifier: GPL-2.0-only`; `cam_sensor.h` carries `GPL-2.0-only WITH Linux-syscall-note`. The following vendor-derived files do not contain an SPDX identifier in the preserved upstream form, so this repository does not invent one:

- `cam_actuator_parklens_thread.c`
- `cam_actuator_parklens_thread.h`
- `bu24721.c`
- `bu24721.h`
- `xiaomi_flash_ois.h`

Existing file headers, copyright notices, and upstream license terms remain authoritative. The root `LICENSE` contains GPL version 2 for the repository's GPL-covered work.
