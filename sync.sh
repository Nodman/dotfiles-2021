#!/bin/bash

current_date=$(date +'%Y-%m-%d_%H-%M')
branch_name="update-${current_date}"

git pull;

git co -b $branch_name;

# nvim
rm -rf ./nvim
cp -r ~/.config/nvim ./
rm -rf ./nvim/spell

#kitty
rm -rf ./kitty
cp -r ~/.config/kitty ./

#hammerspoon
rm -rf ./hammerspoon
cp -r ~/.hammerspoon ./

#zsh
cp -i ~/.zshrc ./

#git
cp -i ~/.gitconfig ./

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
git push -u origin $branch_name
