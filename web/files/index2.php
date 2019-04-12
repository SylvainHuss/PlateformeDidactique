<!DOCTYPE html>
<html>
<body>

<h1>lolMy First Heading</h1>

<p>My first paragraph.</p>




<?php
// Create connection

function connectiondb(){
        $servername = "172.58.0.3";
        $username = "web";
        $password = "mdp";
        $dbname = "bd";

        $conn = new mysqli($servername, $username, $password, $dbname);
        if ($conn->connect_error) {

                die("Connection failed: " . $conn->connect_error);
        }
        return $conn;
}

function getUser($conn){
        $requete = "select * from utilisateur";
        $result = $conn->query($requete);

        if ($result->num_rows > 0) {
                // output data of each row
                while($row = $result->fetch_assoc()) {
                        echo "id: " . $row["id"] . " nom: " . $row["nom"] . " mdp: " . $row["mdp"] . " type : " . $row["type"] . "\n";
                }
        }
}

function test($conn, $idexo, $ideleve, $file){

    /*Se connecte a la base de donnees et teste pour chaque entrees le programme et compare la sortie*/
    $requete = "select * from jeutest where id_ex=$idexo";
    $result = $conn->query($requete);

    if ($result->num_rows > 0) {
            // output data of each row
            $envoi = "";
            $erreur = "false";
            while($row = $result->fetch_assoc()) {
                    $entree = $row["entree"];
                    $sortie = $row["sortie"];
                    $out = substr(shell_exec("./$file $entree ; echo $?"), 0, -1);
                    if ($sortie == $out){
                            $envoi = $envoi . "1";
                    } else {
                            $envoi = $envoi . "0";
                            $erreur = "true";
                    }
            }
    }
    
    if ($erreur == "true"){
        $valide = 0;
        $requete = "select * from realise where id_ex=$idexo and id_eleve=$ideleve";
        $result = $conn->query($requete);
        if ($result->num_rows > 0) {
            // output data of each row
            while($row = $result->fetch_assoc()) {
                $nberreur = $row["nb_essai"] + 1;
                $valide = $row["valide"];
            }
        } else {
            $nberreur = 1;
            $requete = "insert into realise values ( $idexo , $ideleve , NOW() , NOW() , 0, 0)";
            $result = $conn->query($requete);
        }
        if ($valide == 0){
            $requete = "update realise set nb_essai = $nberreur where id_ex=$idexo and id_eleve=$ideleve";
            $result = $conn->query($requete);
        }
    } elseif ($valide == 0) {
        $requete = "update realise set temps_valide = NOW() , valide = 1 where id_ex=$idexo and id_eleve=$ideleve";
            $result = $conn->query($requete);
    }
    echo $envoi;
}

$conn = connectiondb();
test($conn, 2, 1, 'code');

?>


</body>
</html>

