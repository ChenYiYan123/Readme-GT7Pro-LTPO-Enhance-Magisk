MODDIR=${0%/*}
BASEDIR="$(dirname $(readlink -f "$0"))"
# Default root ator coolapk@int萌新很新
MNT="/mnt/vendor/"
MagiskVers="$(magisk -V)"
KsuVers="$(/data/adb/ksud -V)"
KsuVers="ksud 0.5.2"


function my_mount(){
	if [ "$1" -eq "overlay" ];then
		mount -t overlay -o lowerdir=${0%/*}/$2:/mnt/vendor/$2 overlay /mnt/vendor/$2
	fi
	if [ "$MagiskVers" -lt 26000 ] && [ "$3" -eq 1 ]; then
  		mount --bind "$1" "$2"
	else
		mount -o bind "$1" "$2"
	fi
}

function my_mount_recursive(){
    for file in "$MODDIR/$1"/*; do
        if [ -f "$file" ]; then
            # If the file is a regular file, mount it in the corresponding subfile in root
            sub_file=$(basename "$file")
            chmod --reference="$MNT$1/$sub_file" "$file" 
            chown --reference="$MNT$1/$sub_file" "$file" 
            my_mount "$file" "$MNT$1/$sub_file" 
            # Preserve the original file's permissions and ownership
        elif [ -d "$file" ]; then
            # If the file is a directory, recurse into it and mount all files inside
            sub_dir=$(basename "$file")
            my_mount_recursive "$1/$sub_dir"
        fi
    done
}

# Example usage:
# my_mount my_product
# my_mount odm

MNT="/" #从根目录挂载（默认从/mnt/vendor/挂载）

my_mount_recursive my_product
#可弃用修改项