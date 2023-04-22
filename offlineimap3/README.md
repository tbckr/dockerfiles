# Offlineimap3

Offlineimap3 is a fork of Offlineimap2, a Python IMAP/Maildir synchronization tool.

## Usage

1. Create the necessary directories and files:

  ```shell
  mkdir -p $HOME/mail
  touch $HOME/.offlineimaprc
  ```

1. Configure your `$HOME/.offlineimaprc` file. See the archlinux wiki for
   an [example](https://wiki.archlinux.org/title/OfflineIMAP).
2. Change the permissions of the mail directory and the offlineimaprc file:

  ```shell
  sudo chown 65532 $HOME/mail
  sudo chown 65532 $HOME/.offlineimaprc
  ```

1. Start the container:

  ```shell
  docker run --rm -v $HOME/.offlineimaprc:/home/nonroot/.offlineimaprc -v $HOME/mail:/home/nonroot/mail ghcr.io/tbckr/offlineimap3
  ```

## Unsupported features

- GSSAPI authentication
