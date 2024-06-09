# 3ds-linux-bootstrap

This repository serves as an easy-to-use method for building a functional linux kernel and userland for the Nintendo 3DS. Instruction at the time being are meant for Debian-based distributions but better instructions for more distributions will be added in the future.

--

## Compiling 3DS Linux

Step 1: Install dependencies
```
sudo apt install which sed make binutils build-essential diffutils gcc gpp bash patch gzip bzip2 perl tar cpio unzip rsync file bc findutils wget python ncurses-bin libncurses-dev libqt5core5a git
```

Step 2: Clone the repository
```
git clone https://github.com/iAmInActions/3ds-linux-bootstrap && cd 3ds-linux-bootstrap
```

Step 3: Compile the userland and kernel
```
make -j$(nproc)
```
