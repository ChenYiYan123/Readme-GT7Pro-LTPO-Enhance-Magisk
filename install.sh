##########################################################################################
# Config Flags
##########################################################################################

# Set to true if you do *NOT* want Magisk to mount
# any files for you. Most modules would NOT want
# to set this flag to true
SKIPMOUNT=false

# Set to true if you need to load system.prop
PROPFILE=true

# Set to true if you need post-fs-data script
POSTFSDATA=true

# Set to true if you need late_start service script
LATESTARTSERVICE=true


REPLACE=""


print_modname()
{
    echo ""
    echo "* 作者: 我是江小白_"
    echo "* 版本: v1.4"
    echo ""
}

# Copy/extract your module files into $MODPATH in on_install.
on_install()
{
    $BOOTMODE || abort "! It cannot be installed in recovery."

    ui_print "- Extracting module files"
    unzip -o "$ZIPFILE" -x 'META-INF/*' -d $MODPATH > /dev/null
	unzip -o "$ZIPFILE" 'bin/*' -d $MODPATH >&2
    ui_print "- Installing"
    rm -rf $MODPATH/com*
    rm -rf $MODPATH/install.sh
}

# Only some special files require specific permissions
# This function will be called after on_install is done
# The default permissions should be good enough for most cases
set_permissions()
{
    # Here are some examples:
    # set_perm_recursive  $MODPATH/system/lib       0     0       0755      0644
    # set_perm  $MODPATH/system/bin/app_process32   0     2000    0755      u:object_r:zygote_exec:s0
    # set_perm  $MODPATH/system/bin/dex2oat         0     2000    0755      u:object_r:dex2oat_exec:s0
    # set_perm  $MODPATH/system/lib/libart.so       0     0       0644
   # set_perm $MODPATH/bin/screen_on_LTPO 0 0 0755 u:object_r:system_file:s0
    set_perm_recursive $MODPATH/my_product 0 0 0755 0644 u:object_r:system_file:s0
    return
}

# You can add more functions to assist your custom script code
