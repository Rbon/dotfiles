[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

exec i3

# unclutter --fork --timeout 1 &
xbanish &

autocutsel -fork &
autocutsel -selection PRIMARY -fork &
