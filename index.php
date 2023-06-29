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
    http_response_code(404);
    die();
endif;

//listing
if ($_SERVER['REQUEST_METHOD'] == 'GET') :
    $sql = "SELECT * FROM $route";
    $sql .= (isset($_GET['id'])) ? " WHERE id = {$_GET['id']}" : "";
    $args = [];
    $data = json_decode(file_get_contents('php://input'), true);
    if(isset($data['search'])) :
        $sql .= " WHERE ";
        
        $operator = $data['search']['operator'];
        unset($data['search']['operator']);
        $i=0;
        foreach($data['search'] AS $field => $value):
            if($i < count($data['search'])-1) :
                $sql .= "$field LIKE :$field $operator ";
                $args[$field] = (is_int($value)) ? $value : $value.'%';
            else : 
                $sql .= "$field LIKE :$field";
                $args[$field] = (is_int($value)) ? $value :  $value.'%';
            endif;
            $i++;
        endforeach;
    endif;//search
    //echo $sql;
    $rq = $connect->prepare($sql);
    $rq->execute($args);
    $nb_hits = $rq->rowCount();
    $rows = $rq->fetchAll();

    //myPrint_r($users);

    if($nb_hits > 0) :
    $response['content'] = $rows;
    //var_dump($response['content']);
    $response['message'] = "Liste $route";
    $response['code'] = 'ok';
    $response['nbhits'] = $nb_hits;
    else:
        $response['message'] = "Pas de réponse";
        $response['code'] = "pas ok";
        http_response_code(404);
    endif;
endif;

//insert
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
        $response['insert_id'] = $connect->lastInsertId();
        else:
            $response['message'] = "Error server";
            $response['code'] = "pas ok";
            http_response_code(500);
        endif;
endif;

//suppression
if ($_SERVER['REQUEST_METHOD'] == 'DELETE') :
    $data = json_decode(file_get_contents('php://input'), true);
    if(!isset($_GET['id']) AND !isset($data['delete'])) :
        $response['message'] = "Il manque un id";
        $response['code'] = "pas ok";
        http_response_code(302);
        echo json_encode($response);
        die();
    endif;

    //$sql =  "DELETE FROM $route WHERE id IN (:id)";
    //var_dump(implode(', ',$data['delete']));
    $id2delete = (isset($_GET['id'])) ? $_GET['id'] : implode(', ',$data['delete']);

    $sql = "DELETE FROM $route WHERE id IN ($id2delete)";
    $rq = $connect->prepare($sql);
    $rq->execute();
    //myPrint_r($rq);
    $nb_hits = $rq->rowCount();

    if($nb_hits > 0) :
    $response['message'] = "Suppression sur $route";
    $response['code'] = 'ok';
    $response['nbhits'] = $nb_hits;
    $response['id'] = $id2delete;
    else:
        $response['message'] = "Error server";
        $response['code'] = "pas ok";
        http_response_code(500);
    endif;
endif;

//update
if ($_SERVER['REQUEST_METHOD'] == 'PUT') :
    if(!isset($_GET['id'])) :
        $response['message'] = "Il manque un id";
        $response['code'] = "pas ok";
        http_response_code(302);
        echo json_encode($response);
        die();
    endif;
    $data = json_decode(file_get_contents('php://input'), true);
    unset($data['token']);
    $sql = "UPDATE $route SET ";
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
    $sql .= " WHERE id={$_GET['id']}";
    $rq = $connect->prepare($sql);
    $rq->execute($args);
    $nb_hits = $rq->rowCount();

    if($nb_hits > 0) :
        $response['message'] = "Edit sur $route";
        $response['code'] = 'ok';
        $response['nbhits'] = $nb_hits;
        $response['id'] = $_GET['id'];
        else:
            $response['message'] = "Error server";
            $response['code'] = "pas ok";
            http_response_code(500);
        endif;
endif;

echo json_encode($response);