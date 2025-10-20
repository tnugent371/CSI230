function gatherClasses(){
    $page = Invoke-WebRequest -TimeoutSec 2 http://localhost/Courses.html

    $trs = $page.ParsedHtml.getElementsByTagName("tr")

    $FullTable = @()
    for($i=1; $i -lt $trs.length; $i++){

        $stds = $trs[$i].getElementsByTagName("td")

        $times = $stds[5].innerText -split '-'

        $FullTable += [PSCustomObject]@{
            "Class Code" = $stds[0].innerText
            "Title" = $stds[1].innerText
            "Days" = $stds[4].innerText
            "Time Start" = $times[0].Trim()
            "Time End" = $times[1].Trim()
            "Instructor" = $stds[6].innerText
            "Location" = $stds[9].innerText
        }
    }
    return $FullTable
}

function daysTranslator($FullTable){
    for($i=0; $i -lt $FullTable.length; $i++){
        $Days = @()

        if($FullTable[$i].Days -like "*M*"){$Days += "Monday"}

        if($FullTable[$i].Days -like "*T*" -and $FullTable[$i].Days -notlike "*Th*"){$Days += "Tuesday"}
        elseif($FullTable[$i].Days -like "*Tu*"){$Days += "Tuesday"}

        if($FullTable[$i].Days -like "*W*"){$Days += "Wednesday"}

        if($FullTable[$i].Days -like "*Th*"){$Days += "Thursday"}

        if($FullTable[$i].Days -like "*F*"){$Days += "Friday"}

        $FullTable[$i].Days = $Days
    }
    return $FullTable
}
