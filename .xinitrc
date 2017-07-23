[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

exec i3

# unclutter --fork --timeout 1 &
xbanish &

autocutsel -fork &
autocutsel -selection PRIMARY -fork &

xset -dpms &
xset s noblank &
xset s off &
