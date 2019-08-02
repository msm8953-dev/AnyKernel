# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=KudProject Continuous Integration Kernel
do.devicecheck=1
do.modules=0
do.cleanup=1
do.cleanuponabort=1
device.name1=grus
supported.versions=9
supported.patchlevels=
'; } # end properties

# shell variables
block=/dev/block/platform/soc/1d84000.ufshc/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;


## AnyKernel install
dump_boot;

uncompressed_image=/tmp/anykernel/files/Image
compressed_image=$uncompressed_image.gz
if [ -d $ramdisk/.backup ]; then
  ui_print " " "Magisk patched boot image detected";
  $bin/magiskboot hexpatch $uncompressed_image 736B69705F696E697472616D667300 77616E745F696E697472616D667300;
fi

$bin/magiskboot compress=gzip $uncompressed_image $compressed_image;
cat $compressed_image /tmp/anykernel/files/*.dtb > /tmp/anykernel/Image.gz-dtb;

write_boot;
## end install

