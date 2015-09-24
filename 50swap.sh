# Add a swapfile on the data store drive 
# (rsync needs this for large file copies)
# you still need to manually create the .internal dir on one of your disks

sed -i 's/^SWAP=.*/SWAP=swap/' /etc/firmware

cat <<'EOF' > /etc/init.d/swap
STORE_DIR=.internal
rm -f /tmp/swapinfo

echo "Running $0" > /tmp/swapinfo
while read device mountpoint fstype remainder; do
    echo "Checking $device at $mountpoint" >> /tmp/swapinfo
    if [ ${device:0:7} == "/dev/sd" -a -e "$mountpoint/$STORE_DIR" ];then
            swapfile="$mountpoint/$STORE_DIR"/swapfile
            if [ ! -e "$swapfile" ]; then
                echo "Creating swapfile $swapfile" >> /tmp/swapinfo
                # large blocksize is flash-friendlier
                dd if=/dev/zero of="$swapfile" bs=64k count=1024
                # create swapfile signature
                mkswap "$swapfile"
            fi
            swapon "$swapfile" >> /tmp/swapinfo 2>&1
            if [ $? -eq 0 ]; then
                echo "Turned on swap for $swapfile" >> /tmp/swapinfo
            else
                echo "There was an error turning on swap" >> /tmp/swapinfo
            fi
            exit 0
    fi
done < /proc/mounts
exit 0
EOF

# Make executable, and run right now!
chmod +x /etc/init.d/swap
echo pre-apply:
free
/etc/init.d/swap
echo post-apply:
free
