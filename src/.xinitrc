[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

exec i3

#unclutter --fork --timeout 3

autocutsel -fork &
autocutsel -selection PRIMARY -fork &
