<h1>Рекурсия на все случаи жизни</h1>

<p>Здесь представлены функции с рекурсивным вызовом, которые по мнению автора, наиболее часто используются при разработке сайтов</p>

<p><i>Примечание:</i><br>
Если есть возможность избежать использование функций с рекурсивным вызовом, то не следует использовать эти функции. Это является следствием того, что функции с рекурсивным вызовом являются ресурсоемкими
</p>
<h3>Здесь представлены функции для решения следующих задач:</h3>

<h2>1. Создание меню категорий не ограниченной вложенности</h2>

<p>Это меню будет создаваться из категорий которые хранятся в базе данных в таблице следующего вида:</p>

<table>
    <thead>
    <tr>
        <th>id</th>
        <th>alias</th>
        <th>parent_id</th>
        <th>title</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td>1</td>
        <td>sportswear</td>
        <td>0</td>
        <td>Sportswear</td>
    </tr>
    <tr>
        <td>2</td>
        <td>mens</td>
        <td>0</td>
        <td>Mens</td>
    </tr>
    <tr>
        <td>3</td>
        <td>nike</td>
        <td>1</td>
        <td>Nike</td>
    </tr>
        <td>4</td>
        <td>dior</td>
        <td>2</td>
        <td>Dior</td>
    </tr>
    </tbody>
</table>
<p>Бекап SQL таблици лежит в файле <b>category.sql</b></p>

<p>Из этой таблицы нужно получить массив в котором ключи первого уровня являются id категорий которые имеют дочерние категории а ключи второго уровня это id категории значение у которого является массив с данными категории. Выглядеть он будет следующим образом:</p>
<pre>
Array
(
    [0] => Array
        (
            [1] => Array
                (
                    [id] => 1
                    [alias] => sportswear
                    [parent_id] => 0
                    [title] => Sportswear
                )
            [2] => Array
                (
                    [id] => 2
                    [alias] => mens
                    [parent_id] => 0
                    [title] => Mens
                )
        )
    [1] => Array
        (
            [3] => Array
                (
                    [id] => 3
                    [alias] => nike
                    [parent_id] => 1
                    [title] => Nike
                )
        )
    [2] => Array
        (
            [4] => Array
                (
                    [id] => 4
                    [alias] => dior
                    [parent_id] => 4
                    [title] => Dior
                )
        )
)
</pre>
<p>Сделать  это можно следующим образом:</p>
<pre>
    $db = new PDO("mysql:host=localhost;dbname=test",'root','');

    $sql = "SELECT * FROM category";
    $stmp = $db->query($sql);

    while($row = $stmp->fetch(PDO::FETCH_ASSOC)){
        $category_degree[$row['parent_id']][$row['id']] = $row;
    }
</pre>

<h4>Далее есть два варианта развития событий</h4>
<h3>1.1	Сразу из полученного массива создать меню в виде HTML</h3>
<p>Этот вариант производительнее поэтому предпочтительнее, но имеет меньшую гибкость если Вы к примеру создаете CMS</p>
<p>Для этого следует использовать функцию: </p>
<pre>
function getTreeMenuFromDegree($category_degree,$category_id = 0,$link = "http://site.com"){
    echo '&lt;ul>';
    foreach ($category_degree[$category_id] as $cat){
        $link1 = "$link/{$cat['alias']}";
        echo "&lt;li>&lt;a href='$link1'>{$cat['title']}&lt;/a>";
        if($category_degree[$cat['id']])
            getTreeMenuFromDegree($category_degree,$cat['id'],$link1);
        echo '&lt;/li>';
    }
    echo '&lt;/ul>';
}
</pre>
<p>Если вы не хотите чтоб в href ссылки при каждой последующей вложенности категории добавлялась родительская категория то следует убрать из функции параметр $link, а в href ссылки записываем $cat[&apos;alias&apos;]:</p>
<pre>
function getTreeMenuFromDegree($category_degree,$category_id = 0){
    echo '&lt;ul>';
    foreach ($category_degree[$category_id] as $cat){
        echo "&lt;li>&lt;a href='{$cat['alias']}'>{$cat['title']}&lt;/a>";
        if($category_degree[$cat['id']])
            getTreeMenuFromDegree($category_degree,$cat['id'],$link1);
        echo '&lt;/li>';
    }
    echo '&lt;/ul>';
}
</pre>

<h3>1.2	Из массива категорий который мы получили из БД рекурсивно получаем массив вложенных в друг друга категорий (с неограниченной вложенностью), а после из этого массива, также рекурсивно, получаем меню в виде HTML</h3>
<p>Этот способ является менее производительным так как используются две рекурсивных функции, поэтому он является менее предпочтительным, но при этом имеет большую гибкость</p>
<p>Итак для этого способа нам понадобится две функции:</p>
<p><b>- Получение массив вложенных в друг друга категорий</b></p>
<pre>
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
</pre>
<p><b>- Вывод меню в виде HTML </b></p>
<pre>
function getTreeMenu($arr_tree,$link = ''){
    echo '&lt;ul>';
    foreach ($arr_tree as $item){
        $link1 = "$link/{$item['alias']}";
        echo "&lt;li>&lt;a href='$link1'>{$item['title']}&lt;/a>";
        if ($item['children'])
            getTreeMenu($item['children'],$link1);
        echo '&lt;/li>';
    }
    echo '&lt;/ul>';
}
</pre>
<p>Для использования сначала получаем массив  $category_degree из БД как это показано выше</p>
<pre>
$arr_tree_menu =  getTreeRecurs($category_degree);
getTreeMenu($arr_tree_menu);
</pre>
<p>Эти функции вы можете найти в файле <b>recursive_menu.php</b></p>
