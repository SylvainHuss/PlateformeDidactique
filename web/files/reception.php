<?php
$server = stream_socket_server('tcp://172.48.0.2:1231');

while (true){
$socket = stream_socket_accept($server);
$paquet = stream_socket_recvfrom($socket, 1500);
file_put_contents("resp",  $paquet);
}
fclose($socket);
fclose($server);

?>
