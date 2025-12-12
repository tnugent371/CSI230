LOG="$1"
IOC="$2"

OUT="report.txt"
> "$OUT"

while IFS= read -r pattern; do
	[[ -z "$pattern" ]] && continue

	grep -F "$pattern" "$LOG" | while read -r line; do

		#echo $line
        
        	line="${line/- - /}"

        	line="${line/\"GET /}"

        	ip=$(echo "$line" | awk '{print $1}')
        	datetime=$(echo "$line" | awk '{print $2" "$3}')
        	url=$(echo "$line" | awk '{print $4}')

        	echo "$ip $datetime $url" >> "$OUT"
    	done

done < "$IOC"