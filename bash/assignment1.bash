#! /bin/bash
clear

# filling courses.txt
bash courses.bash

courseFile="courses.txt"

function displayCoursesofInst(){

echo -n "Please Input an Instructor Full Name: "
read instName

echo ""
echo "Courses of $instName :"
cat "$courseFile" | grep "$instName" | cut -d';' -f1,2 | \
sed 's/;/ | /g'
echo ""

}

function courseCountofInsts(){

echo ""
echo "Course-Instructor Distribution"
cat "$courseFile" | cut -d';' -f7 | \
grep -v "/" | grep -v "\.\.\." | \
sort -n | uniq -c | sort -n -r 
echo ""

}

function displayCoursesOfLocation() {

	echo -n "Please input a classroom:"
	read classroom

	echo ""
	echo "Classes in $classroom :"
	echo ""

	grep "$classroom" "$courseFile" | while IFS=';' read -r code title credits seats daysTimes instructor rest
	do
		echo "$code | $title | $daysTimes | $instructor"
	done
	echo ""
}

function displayAvaliableCoursesOfSubject() {
	echo -n "Please input a subject name:"
	read subject
	echo ""
	echo "Avaliable $subject courses:"
	echo ""

	grep "^subject" "$courseFile" | while IFS=';' read -r code title credits seats daysTimes instructor rest
	do
		if [[ "$seats" -gt 0 ]]; then
			echo "$code | $title | $daysTimes | $instructor | FREE $seats"
		fi
	done		
}

while :
do
	echo ""
	echo "Please select and option:"
	echo "[1] Display courses of an instructor"
	echo "[2] Display course count of instructors"
	echo "[3] Display courses of a classroom"
	echo "[4] Display avaliable courses of a subject"
	echo "[5] Exit"

	read userInput
	echo ""

	if [[ "$userInput" == "5" ]]; then
		echo "Goodbye"
		break

	elif [[ "$userInput" == "1" ]]; then
		displayCoursesofInst

	elif [[ "$userInput" == "2" ]]; then
		courseCountofInsts

	elif [[ "$userInput" == "3" ]]; then
		displayCoursesOfLocation

	elif [[ "$userInput" == "4" ]]; then
		displayAvaliableCoursesOfSubject

	else
		echo "Invalid option.  Plaese try again."
	fi
done
