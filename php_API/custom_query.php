<?php
$sdn="mysql:host=192.168.30.8;dbname=mz_db";
$username='mz';
$password='mzrootmz';
$option=array (PDO::MYSQL_ATTR_INIT_COMMAND=>"SET NAMES UTF8",PDO::ATTR_TIMEOUT=>15);

function filtersecure($requestname){
   return htmlspecialchars(strip_tags($_POST[$requestname]));
  };
    
try{
$conn=new PDO($sdn,$username,$password,$option);
$conn->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
$customquery=filtersecure("customquery");
$stmt = $conn->prepare($customquery);
$stmt->execute();
$result = $stmt->fetchAll(PDO::FETCH_ASSOC);
echo json_encode($result);
}catch(PDOException $e){
echo $e->getMessage();
}