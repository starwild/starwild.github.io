#!/bin/sh
BASE="$(cd "$(dirname "$0")" && pwd)"
HUGO=$BASE/bin/hugo

chmod +x $HUGO

cd $BASE

ARGS="  -D \
		--config config.yaml"

build() {
	$HUGO $ARGS -d ../docs
}

server() {
	$HUGO server $ARGS -p 58005 --bind 172.27.0.15 --baseURL localhost --disableFastRender
}

commit() {
	git add ..
	git commit -m "$(date +%Y-%m-%d\ %H:%M:%S)"
	git push origin main
}


while getopts ':bsc' P; do 
	case $P in
		b)
			build
		;;
		s)
			server
		;;
		c)
			commit
		;;
		?)
			echo "usage: `basename $0` [options]"
		;;
	esac
done

shift $(($OPTIND - 1))
