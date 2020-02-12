-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Фев 12 2020 г., 12:00
-- Версия сервера: 10.4.11-MariaDB
-- Версия PHP: 7.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `transportas`
--

-- --------------------------------------------------------

--
-- Структура таблицы `das_auto`
--

CREATE TABLE `das_auto` (
  `id` int(10) UNSIGNED NOT NULL,
  `modelis` varchar(50) COLLATE utf8_lithuanian_ci NOT NULL,
  `metai` int(11) NOT NULL,
  `rida` int(11) NOT NULL,
  `spalva` varchar(50) COLLATE utf8_lithuanian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

--
-- Дамп данных таблицы `das_auto`
--

INSERT INTO `das_auto` (`id`, `modelis`, `metai`, `rida`, `spalva`) VALUES
(1, 'audi', 2015, 65400, 'balt'),
(2, 'honda', 2000, 23215632, 'juoda'),
(3, 'bmw', 2001, 42563, 'zalia'),
(4, 'renault', 2010, 100000, 'orand'),
(5, 'cioperis', 2010, 100000, 'melina');

-- --------------------------------------------------------

--
-- Структура таблицы `klientas`
--

CREATE TABLE `klientas` (
  `id` int(10) UNSIGNED NOT NULL,
  `vardas` varchar(50) COLLATE utf8_lithuanian_ci NOT NULL,
  `pavarde` varchar(50) COLLATE utf8_lithuanian_ci NOT NULL,
  `tel_nr` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

--
-- Дамп данных таблицы `klientas`
--

INSERT INTO `klientas` (`id`, `vardas`, `pavarde`, `tel_nr`) VALUES
(1, 'haroldas', 'kauskinas', 2616023),
(2, 'kestas', 'bakas', 5232563),
(3, 'justas', 'kopustas', 6523652),
(4, 'justassss', 'smotas', 100000);

-- --------------------------------------------------------

--
-- Структура таблицы `klientu_auto`
--

CREATE TABLE `klientu_auto` (
  `id` int(10) UNSIGNED NOT NULL,
  `id_auto` int(11) UNSIGNED NOT NULL,
  `id_kliento` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

--
-- Дамп данных таблицы `klientu_auto`
--

INSERT INTO `klientu_auto` (`id`, `id_auto`, `id_kliento`) VALUES
(6, 1, 1),
(7, 2, 2),
(8, 3, 3),
(9, 4, 4);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `das_auto`
--
ALTER TABLE `das_auto`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `klientas`
--
ALTER TABLE `klientas`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `klientu_auto`
--
ALTER TABLE `klientu_auto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_kliento` (`id_kliento`),
  ADD KEY `id_auto` (`id_auto`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `das_auto`
--
ALTER TABLE `das_auto`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `klientas`
--
ALTER TABLE `klientas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `klientu_auto`
--
ALTER TABLE `klientu_auto`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `klientu_auto`
--
ALTER TABLE `klientu_auto`
  ADD CONSTRAINT `klientu_auto_ibfk_1` FOREIGN KEY (`id_auto`) REFERENCES `das_auto` (`id`),
  ADD CONSTRAINT `klientu_auto_ibfk_2` FOREIGN KEY (`id_kliento`) REFERENCES `klientas` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
