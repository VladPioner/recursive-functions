<?php

function getTreeRecurs($category_degree,$category_id = 0){
    $tree = [];
    foreach($category_degree[$category_id] as $id=>$val){
        $tree[$id] = $val;
        if(isset($category_degree[$id])){
            $tree[$id]['children'] = getTreeRecurs($category_degree,$id);
        }
    }
    return $tree;
}

function getTreeMenu($arr_tree,$link = ''){
    echo '<ul>';
    foreach ($arr_tree as $item){
        $link1 = "$link/{$item['alias']}";
        echo "<li><a href='$link1'>{$item['title']}</a>";
        if ($item['children'])
            getTreeMenu($item['children'],$link1);
        echo '</li>';
    }
    echo '</ul>';
}

// с рекурсивным созданием ссылки
function getTreeMenuFromDegree($category_degree,$category_id = 0,$link = "http://site.com"){
    echo '<ul>';
    foreach ($category_degree[$category_id] as $cat){
        $link1 = "$link/{$cat['alias']}";
        echo "<li><a href='$link1'>{$cat['title']}</a>";
        if($category_degree[$cat['id']])
            getTreeMenuFromDegree($category_degree,$cat['id'],$link1);
        echo '</li>';
    }
    echo '</ul>';
}
// без рекурсивного создания ссылки
function getTreeMenuFromDegreeRecursionLink($category_degree,$category_id = 0){
    echo '<ul>';
    foreach ($category_degree[$category_id] as $cat){
        echo "<li><a href='{$cat['alias']}'>{$cat['title']}</a>";
        if($category_degree[$cat['id']])
            getTreeMenuFromDegree($category_degree,$cat['id'],$link1);
        echo '</li>';
    }
    echo '</ul>';
}

//Подключаемся к базе данных
$db = new PDO("mysql:host=localhost;dbname=test",'root','');

$sql = "SELECT * FROM category";
$stmp = $db->query($sql);

while($row = $stmp->fetch(PDO::FETCH_ASSOC)){
    $category_degree[$row['parent_id']][$row['id']] = $row;
}

//получение HTML меню напрямую из массива полученного из БД
/*
getTreeMenuFromDegree($category_degree);
*/


//получение сначала массива категорий с неограниченной вложенностью
//псле чего из этого массива получение HTML меню
/*
$arr_tree_menu =  getTreeRecurs($category_degree);
getTreeMenu($arr_tree_menu);
*/