<?php

$servername = "192.168.30.8";
$username = "mz";
$password = "mzrootmz";
$database="mz_db";
$status='';

$mysqli = new mysqli($servername, $username, $password,$database);
if($mysqli->connect_error){
    $status= "connection error";
}else{
    $status= "connection success";
}

$mysqli->close();

