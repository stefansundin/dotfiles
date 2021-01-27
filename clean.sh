#!/bin/bash -e

clean() {
  (
    set -x
    find . -name 'Thumbs.db' "$@"
    find . -name 'Thumbs.db:encryptable' "$@"
    find . -name '.DS_Store' "$@"
    find . -name '._*' "$@"
    find . -name '*:xdg.origin.url' "$@"
    find . -name '*:xdg.referrer.url' "$@"
    find . -name '*:Zone.Identifier' "$@"
    find . -name '*:com.apple.metadata?kMDItemWhereFroms' "$@"
    find . -name '*:com.apple.quarantine' "$@"
    find . -name '*:com.dropbox.attributes' "$@"
    find . -name '*:AFP_AfpInfo' "$@"
    find . -name '*:AFP_Resource' "$@"
    find . -name '*:user.xdg.origin.url' "$@"
    find . -name '*:com.apple.lastuseddate#PS' "$@"
    find . -name '*:com.apple.metadata?_kMDItemUserTags' "$@"
  )
}

clean -exec ls -lhQ {} \;

echo
read -p "Press enter to delete the files. "
echo

clean -delete
