#!/bin/bash

COLOR256=1
HEARTS=("♥" "<3" "LOVE" "ǝʌol" "SUGAR" "SHAINE" "SUNSHINE" "TEMPTING" "GORGEOUS" "CUTE" "KAWAI" "EXQUISITE" "GRACEFUL" "MAGNETIC" "COTTONCANDY" "DELICIOUS" "foxy" "Adorable" "I Love You *kiss*" ":)" "❤" "CHOCOLATY" "BOBO")
HEART_COLORS=("\e[31m" "\e[31;1m" "\e[35m" "\e[35;1m")

if [[ $COLOR256 ]]; then
	for i in {4..5}; do
		for j in {0..5}; do
			HEART_COLORS=("${HEART_COLORS[@]}" "\e[38;5;$((i * 36 + 16 + j))m")
		done
	done
fi

STEP_DURATION=0.1
NEW_HEART_ODD=50
MAX_HEARTS=100
FALLING_ODD=50
NUM_HEART_METADATA=4


HEART_1_WIDTH=56
HEART_1_HEIGHT=19
HEART_1="    ***     ***                   ***     ***                   ***     ***
 **   ** **   **               **   ** **   **               **   ** **   **
*       *       *             *       *       *             *       *       *
*               *             *               *             *               *
 *   Shaine    *               *     LOVE U  *               *    Shaine   *
  **         **   ***     ***   **         **   ***     ***   **         **
    **     **   **   ** **   **   **     **   **   ** **   **   **     **
      ** **    *       *       *    ** **    *       *       *    ** **
        *      *               *      *      *               *      *
                *     LOVE U  *               *     LOVE U  *
   ***     ***   **         **   ***     ***   **         **   ***     ***
 **   ** **   **   **     **   **   ** **   **   **     **   **   ** **   **
*       *       *    ** **    *       *       *    ** **    *       *       *
*               *      *      *               *      *      *               *
 *     LOVE    *               *    Shaine   *               *     LOVE    *
  **         **   ***     ***   **         **   ***     ***   **         **
    **     **   **   ** **   **   **     **   **   ** **   **   **     **
      ** **    *       *       *    ** **    *       *       *    ** **
        *      *               *      *      *               *      *
                *     LOVE U  *               *     LOVE U  *
                 **         **                 **         **
                   **     **                     **     **
                     ** **                         ** **
                       *                             *
"

HEART_2="			  .  .   .  .
			 .      .      .
			.    {~._.~}    .
			.     ( Y )     .   
			 .   ()~*~()   .    
			   . (_)-(_) .
			     .     .
			        .
 "


HEART_3="          @@@   @@@       @@@   @@@       @@@   @@@       @@@   @@@
          @   @ @   @     @   @ @   @     @   @ @   @     @   @ @   @
////      @    @    @     @    @    @     @    @    @     @    @    @
    ------@  )---(  @-----@  )---(  @-----@  )---(  @-----@  )---(   @-------->
////       @       @       @       @       @       @       @       @
            @     @         @     @         @     @         @     @
             @   @           @   @           @   @           @   @
              @ @             @ @             @ @             @ @
               @               @               @               @
"

HEART_4="        LoveLoveLov                eLoveLoveLo
     veLoveLoveLoveLove          LoveLoveLoveLoveLo
  veLoveLoveLoveLoveLoveL      oveLoveLoveLoveLoveLove
 LoveLoveLoveLoveLoveLoveL    oveLoveLoveLoveLoveLoveLo
veLoveLoveLoveLoveLoveLoveL  oveLoveLoveLoveLoveLoveLove
LoveLoveLoveLoveLoveLoveLoveLoveLoveLoveLoveLoveLoveLove
LoveLoveLoveLoveLoveLoveLoveLoveLoveLoveLoveLoveLoveLove
 LoveLoveLoveLoveLoveLoveLoveLoveLoveLoveLoveLoveLoveLo
 veLoveLoveLoveLoveLoveLoveLoveLoveLoveLoveLoveLoveLove
   LoveLoveLoveLoveLoveLoveLoveLoveLoveLoveLoveLoveLo
     veLoveLoveLoveLoveLoveLoveLoveLoveLoveLoveLove
       LoveLoveLoveLoveLoveLoveLoveLoveLoveLoveLo
         veLoveLoveLoveLoveLoveLoveLoveLoveLove
           LoveLoveLoveLoveLoveLoveLoveLoveLo
             veLoveLoveLoveLoveLoveLoveLove
               LoveLoveLoveLoveLoveLoveLo
                  veLoveLoveLoveLoveLo
                      veLoveLoveLo
                           ve

       	   I LOVE YOU LOTS❤❤❤                    
                           

"


heart_type=0

sigwinch() {
	TERM_WIDTH=$(tput cols)
	TERM_HEIGHT=$(tput lines)
	HEART_1_X=$(((TERM_WIDTH-HEART_1_WIDTH)/2))
	}

sigint() {
	local x, y
	end_text="         ❤  I love you Kriztal Shaine!! ❤ "
	x=$(((TERM_WIDTH - ${#end_text}) / 2))
	for ((y=1; y<=TERM_HEIGHT/2; y++)); do
		do_render 1

		if [[ $COLOR256 ]]; then
			color="$((6 - 6 * y / (TERM_HEIGHT / 2)))"
			if ((color == 0)); then
				color="\e[31;1m"
			else
				color="\e[38;5;$((5 * 36 + 16 + color - 1))m"
			fi
		else
			color="\e[31;1m"
		fi

		echo -ne "\e[${y};${x}H${color}${end_text}\e[0m"
		sleep 0.025
	done
	do_exit
	}

do_exit() {
	echo -ne "\e[${TERM_HEIGHT};1H\e[0K"
	
	# Show cursor and echo stdin
	echo -ne "\e[?25h"
	stty echo
	exit 0
	}

print_heart(){
	y=$(((TERM_HEIGHT-HEART_1_HEIGHT)/2))
		color="${HEART_COLORS[${#HEART_COLORS[@]} * RANDOM / 32768]}"
		OLDIFS="$IFS"
		IFS=$'\n'
		echo -n "$1" | while read line_heart; do
			echo -ne "\e[${y};${HEART_1_X}H${color}${line_heart}"
			((y++))
		done
		IFS="$OLDIFS"
}
	
do_render() {
	local x, y
	echo -ne "\e[2J"
	case $heart_type in

	1) print_heart "$HEART_1" ;;
	2) print_heart "$HEART_2" ;;
	3) print_heart "$HEART_3" ;;
	4) print_heart "$HEART_4" ;;
	

	esac
	
	idx=1
	while ((idx<=num_hearts)); do
		if [[ -z "$1" ]] && ((100 * RANDOM / 32768 < FALLING_ODD)); then
			if ((++hearts[(idx - 1) * NUM_HEART_METADATA + 1] > TERM_HEIGHT)); then
				hearts=(
					"${hearts[@]:0:(idx-1)*NUM_HEART_METADATA}"
					"${hearts[@]:idx*NUM_HEART_METADATA:(num_hearts-idx)*NUM_HEART_METADATA}"
					)
				((num_hearts--))
				continue
			fi
		fi
		X=${hearts[(idx - 1) * NUM_HEART_METADATA]}
		Y=${hearts[(idx - 1) * NUM_HEART_METADATA + 1]}
		HEART=${hearts[(idx - 1) * NUM_HEART_METADATA + 2]}
		HEART_COLOR=${hearts[(idx - 1) * NUM_HEART_METADATA + 3]}
		echo -ne "\e[${Y};${X}H${HEART_COLOR}${HEART}"
		((idx++))
	done
	}

trap do_exit TERM
trap sigint INT
trap sigwinch WINCH
stty -echo
echo -ne "\e[?25l"

hearts=()
echo -ne "\e[2J"
sigwinch
while :; do
	read -n 1 -t $STEP_DURATION ch
	case "$ch" in
		q|Q)
			sigint
			;;
		l|L)
		
			case "$heart_type" in
			
			0) heart_type=1 
				;;
			
			1) heart_type=2 ;;
			
			2) heart_type=3 ;;
			
			3) heart_type=4 ;;
			
			4) heart_type=1 ;;
			
			esac
	esac
	
	num_hearts=$((${#hearts[@]} / NUM_HEART_METADATA))
	if ((num_hearts <= MAX_HEARTS)) && ((100 * RANDOM / 32768 < NEW_HEART_ODD)); then
		HEART="${HEARTS[${#HEARTS[@]} * RANDOM / 32768]}"
		X=$((TERM_WIDTH * RANDOM / 32768 + 1 - ${#HEART}))
		Y=1
		HEART_COLOR="${HEART_COLORS[${#HEART_COLORS[@]} * RANDOM / 32768]}"
		hearts=("${hearts[@]}" "$X" "$Y" "$HEART" "$HEART_COLOR")
		echo -ne "\e[${Y};${X}H${HEART_COLOR}${HEART}"
		((num_hearts++))
	fi
	do_render
done
