. .\courseFunctions.ps1

$FullTable = (gatherClasses)
$FullTable = (daysTranslator $FullTable)

#$FullTable | select "Class Code", "Title", "Location", "Days", "Time Start", "Time End", "Instructor" |
#    where {$_.Instructor -eq "Furkan Paligu"}

#$FullTable | where {$_.Location -eq "JOYC 310" -and $_.days -like "*Monday*"} |
#    select "Class Code", "Time Start", "Time End" |
#    sort "Time Start"

$ITSInstructors = $FullTable | where {
    $_."Class Code" -like "SYS*" -or
    $_."Class Code" -like "NET*" -or
    $_."Class Code" -like "SEC*" -or
    $_."Class Code" -like "FOR*" -or
    $_."Class Code" -like "CSI*" -or
    $_."Class Code" -like "DAT*"
} | select "Instructor" -Unique | sort "Instructor"

$FullTable | where {$_.Instructor -in $ITSInstructors.Instructor } |
    group "Instructor" |
    select Count, name |
    sort Count -Descending
