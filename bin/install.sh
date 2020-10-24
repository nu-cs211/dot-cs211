#!/bin/sh

set -eu

main () {
    # Change to project root:
    cd "${1-$(dirname "$(dirname "$(dirname "$0")")")}"

    install_dot_idea
    install_dot_gitignore
}

install_dot_idea () {
    rm -Rf .idea
    cp -vRL .cs211/idea .idea
}

install_dot_gitignore () {
    rm -Rf .gitignore
    cp -v .cs211/.gitignore .gitignore
}

####
main
####
