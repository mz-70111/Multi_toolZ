<?php

$servername = "192.168.30.8";
$username = "mz";
$password = "mzrootmz";
$database="mz_db";

$mysqli = new mysqli($servername, $username, $password,$database);
if($mysqli->connect_error){
echo json_encode("cennection error");
                          }else{
                          $customquery=$_POST["customquery"];
                         if($query!=null){
                          $q = $mysqli->query($customquery);
                          $result = $q->fetch_all();
                          echo json_encode($q);
                          }
                          }

