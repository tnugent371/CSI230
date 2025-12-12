INPUT="report.txt"
OUTPUT="/var/www/html/report.html"

cat > "$OUTPUT" <<EOF
<html>
<head>
	<style>
		table, th, td {
			border: 1px solid black;
		}
	</style>
</head>
<body>
Access logs with IOC indicators:
<table>
	
EOF

while IFS= read -r line; do
	echo "    <tr><td>${line}</td></tr>" >> "$OUTPUT"
done < "$INPUT"

cat >> "$OUTPUT" <<EOF
</table>
</body>
</html>
EOF