#!/bin/bash

current_date=$(date +'%Y-%m-%d')
branch_name="update-${current_date}"

echo $branch_name
git pull;

git co -b update;

# nvim
rm -rf ./nvim
cp -r ~/.config/nvim ./

#kitty
rm -rf ./kitty
cp -r ~/.config/kitty ./

#hammerspoon
rm -rf ./hammerspoon
cp -r ~/.hammerspoon ./

#zsh
cp -i ~/.zshrc ./

#tmux
cp -i ~/.tmux.conf ./

# various scripts
rm -rf ./scripts
cp -r ~/scripts ./

# applescript
rm -rf ./applescript
cp -r ~/applescript ./

git add .
git commit -am "update ${current_date}"
git push -u origin ${branch_name}
