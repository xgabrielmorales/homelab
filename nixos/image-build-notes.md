# Raspberry Pi SD image

## Steps

1. **Build**

   ```bash
   just build-worker-image-aarch64
   ```

2. **Decompress**:

   ```bash
   zstd -d result/sd-image/*.img.zst -o pi.img
   ```

3. **Verify the image before flashing**

   ```bash
   sudo losetup -fP --show pi.img    # prints /dev/loopN
   sudo fsck.ext4 -fn /dev/loopNp2
   sudo losetup -d /dev/loopN
   ```

4. **Flash** (check the device with `lsblk` first):

   ```bash
   sudo dd if=pi.img of=/dev/sdX bs=4M status=progress conv=fsync && sync
   ```

5. **Install the age key**

   ```bash
   sudo mount /dev/sdX2 /mnt
   sudo mkdir -p /mnt/var/lib/sops-nix
   sudo install -m 600 keys.txt /mnt/var/lib/sops-nix/keys.txt
   sudo umount /mnt
   ```

6. **Boot.** First boot takes 1–3 min (filesystem expansion, SSH host keys,
   first Docker start); later boots are faster.
