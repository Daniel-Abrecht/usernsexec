# usernsexec
Execute command in new user namespace, setting uid and gid mapping using shadows newuidmap &amp; newgidmap. This doesn't extend the permissions of a process, but can be useful for faking root or bootstrapping an fs without root privileges.

## Usage

```
usernsexec [uid lower count...] -- [gid lower count...] -- cmd [args...]
uexec cmd [args...]
```

With usernsexec, you can map any uid to any of your own uids.
Every uid not explicitly mapped in the new user namespace will be implicitly mapped to nobody:nogroup.
Access to files with such a mapping is usually denied, even if the others permission bits should allow it.
```usernsexec 0 $(id -u) 1 -- 0 $(id -g) 1 -- "$SHELL"``` is equivalent to ```unshare -r```.
This example maps the one uid for user root to the one for the current user, maps everything else to nobody, and does the same for the gids.
Unlike unshare, you can also map uids to your subuids.

```uexec``` is a helper script which automatically maps root (uid 0) to your user, and all of your remaining subuids to all uids from 1 onwards.
It does the same for the gids. It's often a good replacement for ```fakeroot```.
