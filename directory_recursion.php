<?php

// Рекурсивный обход директории с созданием массива соответствующего дереву данной директории
function getTreeDir($dir){
    $arr_return = [];
    foreach (scandir($dir) as $dir_descendant){
        $name_dir_des = $dir.DIRECTORY_SEPARATOR.$dir_descendant;
        if($dir_descendant != '.' and $dir_descendant != '..'){
            $arr_return[$dir_descendant] = $dir_descendant;
            if(is_dir($name_dir_des)){
                $arr_return[$dir_descendant] = getTreeDir($name_dir_des);
            }
        }
    }
    return $arr_return;
}

// Рекурсивное удаление директории со всем ее содержимым
function recursiveRemoveDir($dir){
    if(file_exists($dir)){
        foreach (scandir($dir) as $dir_descendant){
            $name_dir_des = $dir.DIRECTORY_SEPARATOR.$dir_descendant;
            if($dir_descendant != '.' and $dir_descendant != '..'){
                if(is_dir($name_dir_des))
                    dellRecursDir($name_dir_des);
                else
                    unlink($name_dir_des);
            }
        }
        rmdir($dir);
    }
}