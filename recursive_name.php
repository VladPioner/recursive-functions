<?php

function next_name($name,$name_s,$files,$num = 0){
    if(in_array($name_s,$files)){
        $num++;
        $fill_name = pathinfo($name,PATHINFO_FILENAME);
        $fill_ext = pathinfo($name,PATHINFO_EXTENSION);
        return next_name($name,"$fill_name($num).$fill_ext",$files,$num);
    }
    return $name_s;
}

$dir = 'dir';//путь к папке с файлами
$files = scandir($dir); //получаем список файлов директории
$name = 'image.jpg';
//параметры функции $name и $name_s при зпапуске функции одинаковы
//это имя которе мы хотим присвоить новому файлу
//различными эти параметры будут внутри функции при выполнении ее рекурсивно
echo next_name($name,$name,$files);
