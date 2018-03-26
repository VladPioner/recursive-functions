-- phpMyAdmin SQL Dump
-- version 4.7.3
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Мар 26 2018 г., 18:48
-- Версия сервера: 5.6.37
-- Версия PHP: 5.6.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `yii2test`
--

-- --------------------------------------------------------

--
-- Структура таблицы `category`
--

CREATE TABLE `category` (
  `id` int(10) UNSIGNED NOT NULL,
  `alias` varchar(255) NOT NULL,
  `parent_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `title` varchar(255) NOT NULL,
  `keywords` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `images` text NOT NULL,
  `content` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `category`
--

INSERT INTO `category` (`id`, `alias`, `parent_id`, `title`, `keywords`, `description`, `images`, `content`) VALUES
(1, 'sportswear', 0, 'Sportswear', NULL, NULL, '', ''),
(2, 'mens', 0, 'Mens', NULL, NULL, '', ''),
(3, 'womens', 0, 'Womens', NULL, NULL, '', ''),
(4, 'nike', 1, 'Nike', NULL, NULL, '', ''),
(5, 'ubder_armour', 1, 'Under Armour', NULL, NULL, '', ''),
(6, 'adidas', 8, 'Adidas', NULL, NULL, '', ''),
(7, 'puma', 8, 'Puma', NULL, NULL, '', ''),
(8, 'asics', 4, 'ASICS', NULL, NULL, '', ''),
(9, 'fendi', 2, 'Fendi', NULL, NULL, '', ''),
(10, 'guess', 2, 'Guess', NULL, NULL, '', ''),
(11, 'valentino', 2, 'Valentino', NULL, NULL, '', ''),
(12, 'dior', 2, 'Dior', NULL, NULL, '', ''),
(13, 'versace', 2, 'Versace', NULL, NULL, '', ''),
(14, 'armani', 2, 'Armani', NULL, NULL, '', ''),
(15, 'prada', 2, 'Prada', NULL, NULL, '', ''),
(16, 'dolce_end_gabana', 2, 'Dolce and Gabbana', NULL, NULL, '', ''),
(17, 'canel', 2, 'Chanel', NULL, NULL, '', ''),
(18, 'gucci', 2, 'Gucci', NULL, NULL, '', ''),
(19, 'fandi1', 3, 'Fendi', '', '', '', ''),
(20, 'guess1', 3, 'Guess', NULL, NULL, '', ''),
(21, 'valentino1', 3, 'Valentino', NULL, NULL, '', ''),
(22, 'dior1', 3, 'Dior', NULL, NULL, '', ''),
(23, 'versace1', 3, 'Versace', NULL, NULL, '', ''),
(24, 'kids', 0, 'Kids', NULL, NULL, '', ''),
(25, 'fashion', 0, 'Fashion', NULL, NULL, '', ''),
(26, 'households', 0, 'Households', NULL, NULL, '', ''),
(27, 'interiors', 0, 'Interiors', NULL, NULL, '', ''),
(28, 'clothing', 0, 'Clothing', NULL, NULL, '', ''),
(29, 'bags', 0, 'Bags', 'сумки ключевики...', 'сумки описание...', '', 'Контент сраници категории Bags'),
(30, 'shoes', 0, 'Shoes', NULL, NULL, '', ''),
(33, 'nike22', 1, 'Nike', NULL, NULL, '', ''),
(34, 'ubder_armour222', 1, 'Under Armour', NULL, NULL, '', ''),
(35, 'adidas222', 8, 'Adidas', NULL, NULL, '', ''),
(36, 'puma222', 8, 'Puma', NULL, NULL, '', ''),
(37, 'asics222', 4, 'ASICS', NULL, NULL, '', ''),
(38, 'fendi222', 2, 'Fendi', NULL, NULL, '', ''),
(39, 'guess222', 2, 'Guess', NULL, NULL, '', ''),
(40, 'valentino222', 2, 'Valentino', NULL, NULL, '', ''),
(41, 'dior222', 2, 'Dior', NULL, NULL, '', ''),
(42, 'versace222', 2, 'Versace', NULL, NULL, '', ''),
(43, 'armani222', 2, 'Armani', NULL, NULL, '', ''),
(44, 'prada222', 2, 'Prada', NULL, NULL, '', ''),
(45, 'dolce_end_gabana222', 2, 'Dolce and Gabbana', NULL, NULL, '', ''),
(46, 'canel222', 2, 'Chanel', NULL, NULL, '', ''),
(47, 'gucci222', 2, 'Gucci', NULL, NULL, '', ''),
(48, 'fandi1222', 3, 'Fendi', '', '', '', ''),
(49, 'guess1222', 3, 'Guess', NULL, NULL, '', ''),
(50, 'valentino1222', 3, 'Valentino', NULL, NULL, '', ''),
(51, 'dior1222', 3, 'Dior', NULL, NULL, '', ''),
(52, 'versace1222', 3, 'Versace', NULL, NULL, '', '');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique` (`alias`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `category`
--
ALTER TABLE `category`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
