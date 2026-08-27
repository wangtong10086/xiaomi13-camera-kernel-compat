# Flash and rollback

Flashing is deliberately not automated by this repository. A vendor_dlkm image is build-, ABI-, partition-, and slot-specific.

Before flashing:

1. Keep the stock/current image and its SHA-256 in an external recovery directory.
2. Confirm that only the intended phone is connected.
3. Read `product`, `current-slot`, and partition size from fastboot.
4. Verify the new image hash and ensure it fits the logical partition.
5. Make sure the phone can return to fastboot even if Android black-screens.

Example inspection (replace every placeholder):

```powershell
$serial = '<explicit-fastboot-serial>'
fastboot -s $serial getvar product
fastboot -s $serial getvar current-slot
fastboot -s $serial getvar partition-size:vendor_dlkm_b
Get-FileHash -Algorithm SHA256 ./vendor_dlkm_b-fuxi-production-v11.img
```

Only after the physical target, product, active/inactive slot strategy, and rollback image are confirmed should the corresponding `fastboot -s <serial> flash <exact-partition> <image>` command be run.

If Android black-screens or camera services repeatedly crash, return to fastboot and restore the saved image for the exact partition. Do not add further modules while the base kernel state is unknown.
