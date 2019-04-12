<?php

// Create connection
function connectiondb(){
        $servername = "172.48.0.3";
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
                $envoie = "";
                $erreur = "false";
                while($row = $result->fetch_assoc()) {
                        echo "id: " . $row["id"] . " nom: " . $row["nom"] . " mdp: " . $row["mdp"] . " type : " . $row["type"] . "\n";
                }
        }
}
/* Lit l'id de l'exo */
$idexo = substr($paquet, 0, strpos($paquet, " ") +1);

/* Lit le code et enregistre dans bin */
$ideleve = substr(substr($paquet, strpos($paquet, " ")+1), 0, strpos($paquet, " ") +1);

$bin = substr(substr($paquet, strpos($paquet, " ") +1), strpos($paquet, " ") +1);

/* Converti bin et enregistre dans exe*/
file_put_contents("bin", $bin);
shell_exec("xxd -r bin > exe");

shell_exec("chmod 777 exe");

/*Se connecte a la base de donnees et teste pour chaque entrees le programme et compare la sortie*/
$requete = "select * from jeutest where id_ex=$idexo";
$result = $conn->query($requete);

if ($result->num_rows > 0) {
        // output data of each row
        $envoie = "";
        $erreur = "false";
        while($row = $result->fetch_assoc()) {
                $entree = $row["entree"];
                $sortie = $row["sortie"];
                $out = substr(shell_exec("./exe $entree ; echo $?"), 0, -1);
                if ($sortie == $out){
                        $envoie = $envoie . "1";
                } else {
                        $envoie = $envoie . "0";
                        $erreur = "true";
                }
        }
}

/* Envoie des donn  es directement */
fwrite($socketemission, $envoie);

if ($erreur == "true"){
        $requete = "select * from realise where id_ex=$idexo and id_eleve=$ideleve";
        $result = $conn->query($requete);
        if ($result->num_rows > 0) {
		echo "maj\n";
                // output data of each row
                while($row = $result->fetch_assoc()) {
                        $nberreur = $row["nb_essai"] + 1;
                }
        } else {
		echo "creation\n";
                $nberreur = 1;
                $requete = "insert into realise values ( $idexo , $ideleve , NOW() , NOW() , 0)";
                $result = $conn->query($requete);
        }

        $requete = "update realise set nb_essai = $nberreur where id_ex=$idexo and id_eleve=$ideleve";
        $result = $conn->query($requete);
} else {
	$requete = "update realise set temps_valide = NOW() where id_ex=$idexo and id_eleve=$ideleve";
        $result = $conn->query($requete);
}

shell_exec("rm bin exe");
}

?>
