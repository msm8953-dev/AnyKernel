#!/system/bin/sh
# KudKernel tweaks and parameters
# Copyright (C) 2018-2019 KudProject Development

# Allows us to get init-rc-like style
write() { echo "$2" > "$1"; }

# Set maxfreq to 1804 MHz
write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 1804800

# Switch to BFQ I/O scheduler
setprop sys.io.scheduler bfq

# Disable slice_idle on supported block devices
for block in mmcblk0 mmcblk1 dm-0 dm-1 sda; do
    write /sys/block/$block/queue/iosched/slice_idle 0
done

# Set read ahead to 128 kb for external storage
# The rest are handled by qcom-post-boot
write /sys/block/mmcblk1/queue/read_ahead_kb 128

# Make sure Yama ptrace settings can't be changed
write /proc/sys/kernel/yama/ptrace_scope 3

# Display/fingerprint wakeup delay fix
chown system:system /sys/devices/soc/qpnp-fg-19/power_supply/bms/hi_power
chmod 0660 /sys/devices/soc/qpnp-fg-19/power_supply/bms/hi_power
write /sys/devices/soc/qpnp-fg-19/power_supply/bms/hi_power 1
