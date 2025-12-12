URL="http://10.0.17.6/Assignment.html"
html=$(curl -s "$URL")

temps=$(echo "$html" |
	sed -n '/<table id="temp"/,/<\/table>/p' |
	grep "<td>" |
	sed 's/<td>//g; s/<\/td>//g')

press=$(echo "$html" |
	sed -n '/<table id="press"/,/<\/table>/p' |
	grep "<td>" |
	sed 's/<td>//g; s/<\/td>//g')

readarray -t T <<< "$temps"
readarray -t P <<< "$press"

#echo ${P[1]}

for ((i=0; i<${#T[@]}; i+=2)); do
	#echo ${T[$i]}

	temp="${T[$i]}"
	dt="${T[$i+1]}"
	press="${P[$1]}"

	echo "$press $temp $dt"
done