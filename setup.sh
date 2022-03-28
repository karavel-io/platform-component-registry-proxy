#!/usr/bin/env bash
# shellcheck disable=SC2034

set -e

echo "Component name: "
read -r name

# Lowercase the name
name="$(tr '[:upper:]' '[:lower:]' <<<"$name")"

# Capitalize first character
title_name="$(tr '[:lower:]' '[:upper:]' <<<"${name:0:1}")${name:1}"
echo

echo "Component description: "
read -r description
echo

echo "Component upstream repo: "
read -r repo
echo

echo "Component upstream link (optional): "
read -r link
echo

link="${link:-$repo}"

mv README.md README.md.old
template="$(cat README.md.tpl)"
eval "echo \"${template}\"" > README.md
cp README.md docs/index.md

grep -rl 'https://example.com' chart | xargs -i@ sed -i "s|https://example.com|$link|g" @
grep -rl 'https://github.com/example/example' chart | xargs -i@ sed -i "s|https://github.com/example/example|$repo|g" @

grep -rl 'example' chart | xargs -i@ sed -i "s|example|$name|g" @
grep -rl 'Example' chart | xargs -i@ sed -i "s|Example|$title_name|g" @

sed -i "s|example|$name|g" docs/0.1.0/configuration.md

sed -i "s|example|$name|g" mkdocs.yml
sed -i "s|Example|$title_name|g" mkdocs.yml

sed -i "s|example|$name|g" CONTRIBUTING.md
sed -i "s|example|$name|g" RELEASE.md

echo
to_be_removed=("README.md.old" "README.md.tpl" "setup.sh")
echo "Done! Do you want me to remove the source template files? This will remove ${to_be_removed[*]} (y/N)"
answer="n"
read -r answer

case "$answer" in
  "y"|"Y"|"yes")
    echo "Removing ${to_be_removed[*]}"
    rm "${to_be_removed[@]}"
    ;;
  *) echo "Ok, you can always remove them yourself if you want."
esac
