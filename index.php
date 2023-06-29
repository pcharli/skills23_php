<?php require_once('config.php');

$route = (isset($_GET['route'])) ? $_GET['route'] : "";



require_once('token.php');

if ($route == "") :
    $response['message'] = "documentation";
    $response['contenu'] = "bla bla";
    echo json_encode($response);
    die();
endif;

$routes_valides = ['pays', 'contacts','cities'];
if(!in_array($route,$routes_valides)) :
    $response['message'] = "access denied";
    $response['code'] = 'pas ok';
    echo json_encode($response);
    die();
endif;
//listing
if ($_SERVER['REQUEST_METHOD'] == 'GET') :
    $sql = "SELECT * FROM $route";
    $sql .= (isset($_GET['id'])) ? " WHERE id = {$_GET['id']}" : "";
    $rq = $connect->prepare($sql);
    $rq->execute();
    $nb_users = $rq->rowCount();
    $users = $rq->fetchAll();

    //myPrint_r($users);

    if(count($users) > 0) :
    $response['content'] = $users;
    $response['message'] = "Liste $route";
    $response['code'] = 'ok';
    $response['nbhits'] = $nb_users;
    else:
        $response['message'] = "Pas de réponse";
        $response['code'] = "pas ok";
    endif;
endif;

if ($_SERVER['REQUEST_METHOD'] == 'POST') :
    $data = json_decode(file_get_contents('php://input'), true);
    unset($data['token']);
    $sql = "INSERT INTO $route SET ";
    $args = [];
    $i=0;
    foreach($data AS $field => $value):
        if($i < count($data)-1) :
            $sql .= "$field = :$field, ";
            $args[$field] = $value;
        else : 
            $sql .= "$field = :$field";
            $args[$field] = $value;
        endif;
        $i++;
    endforeach;
    //myPrint_r($args);
    //die();
    $rq = $connect->prepare($sql);
    $rq->execute($args);
    $nb_hits = $rq->rowCount();

    if($nb_hits > 0) :
        $response['message'] = "Ajout sur $route";
        $response['code'] = 'ok';
        $response['nbhits'] = $nb_hits;
        else:
            $response['message'] = "Error server";
            $response['code'] = "pas ok";
        endif;
endif;

if ($_SERVER['REQUEST_METHOD'] == 'DELETE') :
    $sql = "DELETE FROM $route WHERE id = :id";
    $rq = $connect->prepare($sql);
    $rq->execute([
        "id" => $_GET['id']
    ]);
    $nb_hits = $rq->rowCount();

    if($nb_hits > 0) :
    $response['message'] = "Suppression sur $route";
    $response['code'] = 'ok';
    $response['nbhits'] = $nb_hits;
    $response['id'] = $_GET['id'];
    else:
        $response['message'] = "Error server";
        $response['code'] = "pas ok";
    endif;
endif;

echo json_encode($response);