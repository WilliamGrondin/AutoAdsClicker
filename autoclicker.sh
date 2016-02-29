#!/bin/bash
export DISPLAY=:1
BASEDIR=$(dirname $0)
echo $BASEDIR
#killall chromium-browser
#get country
readarray -t usersCountry < "$BASEDIR/countries"
length=${#usersCountry[@]}
index=$((RANDOM%$length))
country=${usersCountry[$index]}
echo $country
rm -rf $BASEDIR/user1
cp -r $BASEDIR/default-user $BASEDIR/user1
sqlite3 $BASEDIR/user1/Default/Local\ Storage/chrome-extension_gkojfkhlekighikafcpjkiklfbnlmeio_0.localstorage "UPDATE ItemTable SET value=replace(value,'ca','$country') WHERE key='be_rules';"
sqlite3 $BASEDIR/user1/Default/Local\ Storage/chrome-extension_gkojfkhlekighikafcpjkiklfbnlmeio_0.localstorage "SELECT value FROM ItemTable WHERE key='be_rules';"
sleep 5
url="http://materialdesign.fr"
chromium-browser --user-data-dir="$BASEDIR/user1/" --display=:1 "$url" &
sleep 40
ads=$((RANDOM%4))
if [ "$ads" -eq "0" ]
then
echo "ads 0"
xdotool mousemove 520 130 click 1
fi
sleep 40
if [ "$ads" -eq "1" ]
then
echo "ads 1"
x=$((RANDOM%690+90))
y=$((RANDOM%50+670))
xdotool mousemove $x $y click 1
fi
for i in `seq 1 500`
do
xdotool click --clearmodifiers 5
done

sleep 5

if [ "$ads" -eq "2" ]
then
echo "ads 2"
x=$((RANDOM%280+80))
y=$((RANDOM%170+120))
xdotool mousemove $x $y click 1
fi

if [ "$ads" -eq "3" ]
then
echo "ads 3"
x=$((RANDOM%570+380))
y=$((RANDOM%170+120))
xdotool mousemove $x $y click 1
fi
