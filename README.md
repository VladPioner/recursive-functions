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
