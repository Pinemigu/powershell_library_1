Class rest_call {

    [int]$status_code
    [string]$status_description
    hidden[object]$headers
    [string]$uri 
    [string]$key

    connect_call($uri){
        $URIString = $uri+ 'get'
        $call = Invoke-WebRequest -Uri $uRIString
        $this.status_code = $call.StatusCode
        $this.status_description = $call.StatusDescription 
        $this.headers = $call.Headers
        $this.uri = $uri
    }
    create_key($uri){
        $URIString = $uri+ 'uuid'
        $call = Invoke-WebRequest -Uri $uRIString
        $this.key = ($call.content | convertFrom-Json).uuid
    }   
}

function connect-AnsibleTower($uri){
    $my_call = New-Object rest_call
    $my_call.connect_call($uri)
    $my_call.create_key($uri)
    return $my_call 
}

$uri = "https://httpbin.org/"
$my_connection = connect-AnsibleTower $uri
$my_connection | FL

#Unit Tests
Describe "connect-AnsibleTower"{
    It "Server should be up return 200"{
        $my_connection.status_code | Should be 200
    }
    It "Server status should be OK "{
        $my_connection.status_description | Should be 'OK'
    }
    It "Headers not null" {
        $my_connection.headers | should not be $null
    }
    It "Key should be something"{
        $my_connection.key | should not be $null
    }
}