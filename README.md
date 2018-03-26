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
function getTreeMenuFromDegree($category_degree,$category_id = 0,$link = &quot;http://site.com&quot;){
    echo &apos;<ul>&apos;;
    foreach ($category_degree[$category_id] as $cat){
        $link1 = &quot;$link/{$cat[&apos;alias&apos;]}&quot;;
        echo &quot;<li><a href=&apos;$link1&apos;>{$cat[&apos;title&apos;]}</a>&quot;;
        if($category_degree[$cat[&apos;id&apos;]])
            getTreeMenuFromDegree($category_degree,$cat[&apos;id&apos;],$link1);
        echo &apos;</li>&apos;;
    }
    echo &apos;</ul>&apos;;
}
</pre>
<p>Если вы не хотите чтоб в href ссылки при каждой последующей вложенности категории добавлялась родительская категория то следует убрать из функции параметр $link, а в href ссылки записываем $cat[&apos;alias&apos;]:</p>
<pre>
function getTreeMenuFromDegree($category_degree,$category_id = 0){
 echo &apos;<ul>&apos;;
 foreach ($category_degree[$category_id] as $cat){
  echo &quot;<li><a href=&apos;{$cat[&apos;alias&apos;]}&apos;>{$cat[&apos;title&apos;]}</a>&quot;;
  if($category_degree[$cat[&apos;id&apos;]])
   getTreeMenuFromDegree($category_degree,$cat[&apos;id&apos;],$link1);
  echo &apos;</li>&apos;;
 }
 echo &apos;</ul>&apos;;
}
</pre>

