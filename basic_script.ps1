$name = "Jeff"
$age = "32"


#Splatted

$myObject = @{
    name = $name
    age = $age
}

function get-info ($name, $age) {
    Write-Output "Your name is $name"
    Write-Output "Your age is $age"
    
}


