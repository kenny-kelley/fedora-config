# Mounting an SMB network file share
Make a new file in your home folder that only you can read and write to:
```bash
touch ~/.smb_credentials
chmod 600 ~/.smb_credentials
```

Then add something like this to that file with your text editor of choice:
```
username=<share_username>
password=<share_password>
```

Now make a directory for the share to be mounted to:
```bash
sudo mkdir /mnt/<some_share_name>
```

Here, `<some_share_name>` is really whatever you want.

Next, add something like this to `/etc/fstab`:
```
//<share_address>/<share_name> /mnt/<some_share_name> cifs credentials=/home/<local_username>/.smb_credentials,uid=<local_username>,gid=<local_group>,file_mode=0750,dir_mode=0750 0 0
```

Now the share can be mounted via the new entry in `/etc/fstab` with this:
```bash
sudo mount -a
sudo systemctl daemon-reload
```
