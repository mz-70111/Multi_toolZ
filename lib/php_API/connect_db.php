<?php

$sdn="mysql:host=192.168.30.8;dbname=mz_db";
$username='mz';
$password='mzrootmz';
$option=array (PDO::MYSQL_ATTR_INIT_COMMAND=>"SET NAMES UTF8",PDO::ATTR_TIMEOUT=>15);
try{
$conn=new PDO($sdn,$username,$password,$option);
$conn->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
echo json_encode("تم الاتصال بنجاح");
}catch(PDOException $e){
    echo $e->getMessage();
echo json_encode("فشلت عملية الاتصال");
}



?>