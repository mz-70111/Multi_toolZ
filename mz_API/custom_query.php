<?php

$servername = "192.168.30.8";
$username = "mz";
$password = "mzrootmz";
$database="mz_db";
$status='';

$mysqli = new mysqli($servername, $username, $password,$database);
if($mysqli->connect_error){
echo json_encode("cennection error");
                     }else{
                     $customq='desc testm;';
                     $customq .='desc testm;';
                     $query=$customq;
                          if($query!=null){
                          $result = $mysqli->query($query);
                      
                            $row = $result->fetch_all();
                            echo json_encode($row);
                                         
                          }
                          else{
                            echo json_encode("no result found");
                                        }
                           }

