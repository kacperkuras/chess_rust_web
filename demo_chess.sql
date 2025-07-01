-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Lip 01, 2025 at 07:12 PM
-- Wersja serwera: 10.4.32-MariaDB
-- Wersja PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `demo_chess`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `chat_messages`
--

CREATE TABLE `chat_messages` (
  `id` int(11) NOT NULL,
  `game_id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chat_messages`
--

INSERT INTO `chat_messages` (`id`, `game_id`, `sender_id`, `message`, `created_at`) VALUES
(1, 41, 61, 'siema cwelu', '2025-06-24 23:38:52'),
(2, 41, 62, 'siema chuju', '2025-06-24 23:39:04');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `games`
--

CREATE TABLE `games` (
  `id` int(11) NOT NULL,
  `white_player_id` int(11) NOT NULL,
  `black_player_id` int(11) NOT NULL,
  `white_player_initial_elo` int(11) NOT NULL,
  `black_player_initial_elo` int(11) NOT NULL,
  `game_type` enum('normal','blitz') NOT NULL,
  `result` enum('white_win','black_win','draw') DEFAULT NULL,
  `status` enum('in_progress','finished') NOT NULL DEFAULT 'in_progress',
  `started_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `ended_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `games`
--

INSERT INTO `games` (`id`, `white_player_id`, `black_player_id`, `white_player_initial_elo`, `black_player_initial_elo`, `game_type`, `result`, `status`, `started_at`, `ended_at`) VALUES
(1, 61, 62, 0, 0, 'normal', 'white_win', 'finished', '2025-06-16 23:25:56', '2025-06-16 23:26:13'),
(2, 62, 61, 0, 0, 'normal', 'white_win', 'finished', '2025-06-16 23:37:34', '2025-06-16 23:37:45'),
(3, 61, 62, 0, 0, 'normal', 'black_win', 'finished', '2025-06-16 23:37:48', '2025-06-16 23:38:09'),
(4, 61, 62, 0, 0, 'normal', 'white_win', 'finished', '2025-06-16 23:53:21', '2025-06-16 23:53:40'),
(5, 61, 62, 0, 0, 'normal', 'white_win', 'finished', '2025-06-17 02:05:15', '2025-06-17 02:05:28'),
(6, 61, 62, 0, 0, 'normal', 'white_win', 'finished', '2025-06-17 02:19:23', '2025-06-17 02:19:33'),
(7, 61, 62, 0, 0, 'normal', 'white_win', 'finished', '2025-06-17 02:26:40', '2025-06-17 02:27:10'),
(8, 62, 62, 0, 0, 'normal', NULL, 'in_progress', '2025-06-22 01:22:42', NULL),
(9, 62, 61, 0, 0, 'normal', 'white_win', 'finished', '2025-06-22 01:30:05', '2025-06-22 01:30:26'),
(10, 61, 62, 0, 0, 'normal', 'white_win', 'finished', '2025-06-22 01:36:13', '2025-06-22 01:36:28'),
(11, 61, 62, 0, 0, 'normal', 'white_win', 'finished', '2025-06-22 01:36:46', '2025-06-22 01:36:57'),
(12, 62, 61, 0, 0, 'normal', 'white_win', 'finished', '2025-06-22 01:37:07', '2025-06-22 01:37:20'),
(13, 61, 62, 0, 0, 'normal', 'white_win', 'finished', '2025-06-22 01:37:41', '2025-06-22 01:37:51'),
(14, 61, 62, 0, 0, 'normal', 'white_win', 'finished', '2025-06-22 01:37:55', '2025-06-22 01:38:08'),
(15, 61, 62, 0, 0, 'normal', 'white_win', 'finished', '2025-06-22 01:38:20', '2025-06-22 01:38:30'),
(16, 61, 62, 0, 0, 'normal', 'white_win', 'finished', '2025-06-22 01:43:13', '2025-06-22 01:43:24'),
(17, 61, 62, 0, 0, 'normal', 'white_win', 'finished', '2025-06-22 02:12:31', '2025-06-22 02:12:43'),
(18, 61, 62, 0, 0, 'normal', 'white_win', 'finished', '2025-06-22 02:14:49', '2025-06-22 02:15:01'),
(19, 61, 62, 0, 0, 'normal', 'white_win', 'finished', '2025-06-22 02:15:59', '2025-06-22 02:19:16'),
(20, 62, 61, 0, 0, 'normal', 'white_win', 'finished', '2025-06-22 02:19:28', '2025-06-22 02:19:45'),
(21, 62, 61, 0, 0, 'normal', 'white_win', 'finished', '2025-06-22 02:20:04', '2025-06-22 02:20:23'),
(22, 62, 61, 0, 0, 'normal', 'white_win', 'finished', '2025-06-22 02:20:38', '2025-06-22 02:20:53'),
(23, 61, 62, 0, 0, 'normal', 'white_win', 'finished', '2025-06-22 02:22:33', '2025-06-22 02:24:55'),
(24, 61, 62, 0, 0, 'normal', 'white_win', 'finished', '2025-06-22 02:28:45', '2025-06-22 02:29:00'),
(25, 61, 62, 0, 0, 'normal', 'white_win', 'finished', '2025-06-22 02:30:46', '2025-06-22 02:30:59'),
(26, 61, 62, 0, 0, 'normal', 'white_win', 'finished', '2025-06-22 02:46:29', '2025-06-22 02:47:03'),
(27, 61, 62, 0, 0, 'normal', NULL, 'in_progress', '2025-06-22 02:47:13', NULL),
(28, 61, 62, 0, 0, 'normal', NULL, 'in_progress', '2025-06-22 02:50:41', NULL),
(29, 62, 61, 0, 0, 'normal', 'black_win', 'finished', '2025-06-22 02:56:46', '2025-06-22 02:57:04'),
(30, 61, 62, 0, 0, 'normal', NULL, 'in_progress', '2025-06-22 02:57:12', NULL),
(31, 61, 62, 0, 0, 'normal', NULL, 'in_progress', '2025-06-22 03:01:35', NULL),
(32, 61, 62, 0, 0, 'normal', NULL, 'in_progress', '2025-06-22 03:05:35', NULL),
(33, 61, 62, 0, 0, 'normal', NULL, 'in_progress', '2025-06-22 03:06:49', NULL),
(34, 61, 62, 0, 0, 'normal', 'white_win', 'finished', '2025-06-22 03:11:40', '2025-06-22 03:11:47'),
(35, 61, 62, 0, 0, 'normal', 'black_win', 'finished', '2025-06-22 03:20:20', '2025-06-22 03:20:22'),
(36, 61, 62, 0, 0, 'normal', 'white_win', 'finished', '2025-06-22 03:20:26', '2025-06-22 03:20:26'),
(37, 62, 61, 0, 0, 'normal', 'black_win', 'finished', '2025-06-22 03:20:29', '2025-06-22 03:20:43'),
(38, 61, 62, 158, 100, 'normal', 'white_win', 'finished', '2025-06-24 23:06:57', '2025-06-24 23:07:33'),
(39, 61, 62, 184, 100, 'normal', 'black_win', 'finished', '2025-06-24 23:11:04', '2025-06-24 23:11:27'),
(40, 61, 62, 146, 138, 'normal', 'white_win', 'finished', '2025-06-24 23:12:36', '2025-06-24 23:12:48'),
(41, 61, 62, 176, 108, 'normal', NULL, 'in_progress', '2025-06-24 23:38:47', NULL);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `moves`
--

CREATE TABLE `moves` (
  `id` int(11) NOT NULL,
  `game_id` int(11) NOT NULL,
  `move_number` int(11) NOT NULL,
  `player_color` enum('black','white') NOT NULL,
  `pgn_move` varchar(16) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `moves`
--

INSERT INTO `moves` (`id`, `game_id`, `move_number`, `player_color`, `pgn_move`, `created_at`) VALUES
(1, 1, 1, 'white', 'e4', '2025-06-16 23:25:58'),
(2, 1, 1, 'black', 'h6', '2025-06-16 23:25:59'),
(3, 1, 2, 'white', 'Bc4', '2025-06-16 23:26:01'),
(4, 1, 2, 'black', 'h5', '2025-06-16 23:26:02'),
(5, 1, 3, 'white', 'Qxh5', '2025-06-16 23:26:04'),
(6, 1, 3, 'black', 'g6', '2025-06-16 23:26:06'),
(7, 1, 4, 'white', 'Qf3', '2025-06-16 23:26:10'),
(8, 1, 4, 'black', 'g5', '2025-06-16 23:26:12'),
(9, 1, 5, 'white', 'Qxf7#', '2025-06-16 23:26:13'),
(10, 2, 1, 'white', 'e4', '2025-06-16 23:37:36'),
(11, 2, 1, 'black', 'e5', '2025-06-16 23:37:38'),
(12, 2, 2, 'white', 'Bc4', '2025-06-16 23:37:39'),
(13, 2, 2, 'black', 'Na6', '2025-06-16 23:37:40'),
(14, 2, 3, 'white', 'Qh5', '2025-06-16 23:37:42'),
(15, 2, 3, 'black', 'Nb8', '2025-06-16 23:37:44'),
(16, 2, 4, 'white', 'Qxf7#', '2025-06-16 23:37:45'),
(17, 3, 1, 'white', 'e4', '2025-06-16 23:37:51'),
(18, 3, 1, 'black', 'e5', '2025-06-16 23:37:52'),
(19, 3, 2, 'white', 'Bc4', '2025-06-16 23:37:56'),
(20, 3, 2, 'black', 'Bc5', '2025-06-16 23:37:59'),
(21, 3, 3, 'white', 'Bf1', '2025-06-16 23:38:00'),
(22, 3, 3, 'black', 'Qh4', '2025-06-16 23:38:02'),
(23, 3, 4, 'white', 'a3', '2025-06-16 23:38:07'),
(24, 3, 4, 'black', 'Qxf2#', '2025-06-16 23:38:09'),
(25, 4, 1, 'white', 'e4', '2025-06-16 23:53:23'),
(26, 4, 1, 'black', 'e5', '2025-06-16 23:53:25'),
(27, 4, 2, 'white', 'Bc4', '2025-06-16 23:53:26'),
(28, 4, 2, 'black', 'Na6', '2025-06-16 23:53:34'),
(29, 4, 3, 'white', 'Qh5', '2025-06-16 23:53:36'),
(30, 4, 3, 'black', 'Nb8', '2025-06-16 23:53:37'),
(31, 4, 4, 'white', 'Qxf7#', '2025-06-16 23:53:40'),
(32, 5, 1, 'white', 'e4', '2025-06-17 02:05:17'),
(33, 5, 1, 'black', 'e5', '2025-06-17 02:05:18'),
(34, 5, 2, 'white', 'Bc4', '2025-06-17 02:05:20'),
(35, 5, 2, 'black', 'Na6', '2025-06-17 02:05:21'),
(36, 5, 3, 'white', 'Qh5', '2025-06-17 02:05:23'),
(37, 5, 3, 'black', 'Nb8', '2025-06-17 02:05:24'),
(38, 5, 4, 'white', 'Qxf7#', '2025-06-17 02:05:28'),
(39, 6, 1, 'white', 'e4', '2025-06-17 02:19:24'),
(40, 6, 1, 'black', 'e5', '2025-06-17 02:19:25'),
(41, 6, 2, 'white', 'Bc4', '2025-06-17 02:19:27'),
(42, 6, 2, 'black', 'Na6', '2025-06-17 02:19:28'),
(43, 6, 3, 'white', 'Qh5', '2025-06-17 02:19:30'),
(44, 6, 3, 'black', 'Nb8', '2025-06-17 02:19:32'),
(45, 6, 4, 'white', 'Qxf7#', '2025-06-17 02:19:33'),
(46, 7, 1, 'white', 'e4', '2025-06-17 02:26:42'),
(47, 7, 1, 'black', 'e5', '2025-06-17 02:26:44'),
(48, 7, 2, 'white', 'Bc4', '2025-06-17 02:26:46'),
(49, 7, 2, 'black', 'Na6', '2025-06-17 02:27:04'),
(50, 7, 3, 'white', 'Qh5', '2025-06-17 02:27:06'),
(51, 7, 3, 'black', 'Nb8', '2025-06-17 02:27:08'),
(52, 7, 4, 'white', 'Qxf7#', '2025-06-17 02:27:10'),
(53, 8, 1, 'white', 'e4', '2025-06-22 01:22:45'),
(54, 9, 1, 'white', 'e4', '2025-06-22 01:30:08'),
(55, 9, 1, 'black', 'e5', '2025-06-22 01:30:09'),
(56, 9, 2, 'white', 'Bc4', '2025-06-22 01:30:11'),
(57, 9, 2, 'black', 'Na6', '2025-06-22 01:30:16'),
(58, 9, 3, 'white', 'Qh5', '2025-06-22 01:30:18'),
(59, 9, 3, 'black', 'Nb8', '2025-06-22 01:30:25'),
(60, 9, 4, 'white', 'Qxf7#', '2025-06-22 01:30:26'),
(61, 10, 1, 'white', 'e4', '2025-06-22 01:36:14'),
(62, 10, 1, 'black', 'e5', '2025-06-22 01:36:17'),
(63, 10, 2, 'white', 'Bc4', '2025-06-22 01:36:19'),
(64, 10, 2, 'black', 'Na6', '2025-06-22 01:36:21'),
(65, 10, 3, 'white', 'Qh5', '2025-06-22 01:36:25'),
(66, 10, 3, 'black', 'Nb8', '2025-06-22 01:36:27'),
(67, 10, 4, 'white', 'Qxf7#', '2025-06-22 01:36:28'),
(68, 11, 1, 'white', 'e4', '2025-06-22 01:36:47'),
(69, 11, 1, 'black', 'e5', '2025-06-22 01:36:49'),
(70, 11, 2, 'white', 'Bc4', '2025-06-22 01:36:50'),
(71, 11, 2, 'black', 'Na6', '2025-06-22 01:36:53'),
(72, 11, 3, 'white', 'Qh5', '2025-06-22 01:36:54'),
(73, 11, 3, 'black', 'Nb8', '2025-06-22 01:36:55'),
(74, 11, 4, 'white', 'Qxf7#', '2025-06-22 01:36:57'),
(75, 12, 1, 'white', 'e4', '2025-06-22 01:37:08'),
(76, 12, 1, 'black', 'e5', '2025-06-22 01:37:11'),
(77, 12, 2, 'white', 'Bc4', '2025-06-22 01:37:13'),
(78, 12, 2, 'black', 'Na6', '2025-06-22 01:37:16'),
(79, 12, 3, 'white', 'Qh5', '2025-06-22 01:37:18'),
(80, 12, 3, 'black', 'Nb8', '2025-06-22 01:37:19'),
(81, 12, 4, 'white', 'Qxf7#', '2025-06-22 01:37:21'),
(82, 13, 1, 'white', 'e4', '2025-06-22 01:37:42'),
(83, 13, 1, 'black', 'e5', '2025-06-22 01:37:44'),
(84, 13, 2, 'white', 'Bc4', '2025-06-22 01:37:45'),
(85, 13, 2, 'black', 'Na6', '2025-06-22 01:37:47'),
(86, 13, 3, 'white', 'Qh5', '2025-06-22 01:37:49'),
(87, 13, 3, 'black', 'Nb8', '2025-06-22 01:37:50'),
(88, 13, 4, 'white', 'Qxf7#', '2025-06-22 01:37:51'),
(89, 14, 1, 'white', 'e4', '2025-06-22 01:37:56'),
(90, 14, 1, 'black', 'e5', '2025-06-22 01:37:57'),
(91, 14, 2, 'white', 'Bc4', '2025-06-22 01:37:59'),
(92, 14, 2, 'black', 'Na6', '2025-06-22 01:38:04'),
(93, 14, 3, 'white', 'Qh5', '2025-06-22 01:38:05'),
(94, 14, 3, 'black', 'Nb8', '2025-06-22 01:38:06'),
(95, 14, 4, 'white', 'Qxf7#', '2025-06-22 01:38:08'),
(96, 15, 1, 'white', 'e4', '2025-06-22 01:38:21'),
(97, 15, 1, 'black', 'e5', '2025-06-22 01:38:23'),
(98, 15, 2, 'white', 'Bc4', '2025-06-22 01:38:24'),
(99, 15, 2, 'black', 'Na6', '2025-06-22 01:38:26'),
(100, 15, 3, 'white', 'Qh5', '2025-06-22 01:38:27'),
(101, 15, 3, 'black', 'Nb8', '2025-06-22 01:38:28'),
(102, 15, 4, 'white', 'Qxf7#', '2025-06-22 01:38:30'),
(103, 16, 1, 'white', 'e4', '2025-06-22 01:43:14'),
(104, 16, 1, 'black', 'e5', '2025-06-22 01:43:16'),
(105, 16, 2, 'white', 'Bc4', '2025-06-22 01:43:17'),
(106, 16, 2, 'black', 'Na6', '2025-06-22 01:43:19'),
(107, 16, 3, 'white', 'Qh5', '2025-06-22 01:43:21'),
(108, 16, 3, 'black', 'Nb8', '2025-06-22 01:43:23'),
(109, 16, 4, 'white', 'Qxf7#', '2025-06-22 01:43:24'),
(110, 17, 1, 'white', 'e4', '2025-06-22 02:12:33'),
(111, 17, 1, 'black', 'e5', '2025-06-22 02:12:34'),
(112, 17, 2, 'white', 'Bc4', '2025-06-22 02:12:36'),
(113, 17, 2, 'black', 'Na6', '2025-06-22 02:12:38'),
(114, 17, 3, 'white', 'Qh5', '2025-06-22 02:12:40'),
(115, 17, 3, 'black', 'Nb8', '2025-06-22 02:12:42'),
(116, 17, 4, 'white', 'Qxf7#', '2025-06-22 02:12:43'),
(117, 18, 1, 'white', 'e4', '2025-06-22 02:14:51'),
(118, 18, 1, 'black', 'e5', '2025-06-22 02:14:52'),
(119, 18, 2, 'white', 'Bc4', '2025-06-22 02:14:53'),
(120, 18, 2, 'black', 'Na6', '2025-06-22 02:14:57'),
(121, 18, 3, 'white', 'Qh5', '2025-06-22 02:14:59'),
(122, 18, 3, 'black', 'Nb8', '2025-06-22 02:15:00'),
(123, 18, 4, 'white', 'Qxf7#', '2025-06-22 02:15:01'),
(124, 19, 1, 'white', 'e4', '2025-06-22 02:19:01'),
(125, 19, 1, 'black', 'e5', '2025-06-22 02:19:03'),
(126, 19, 2, 'white', 'Bc4', '2025-06-22 02:19:06'),
(127, 19, 2, 'black', 'Na6', '2025-06-22 02:19:08'),
(128, 19, 3, 'white', 'Qh5', '2025-06-22 02:19:12'),
(129, 19, 3, 'black', 'Nb8', '2025-06-22 02:19:13'),
(130, 19, 4, 'white', 'Qxf7#', '2025-06-22 02:19:16'),
(131, 20, 1, 'white', 'e4', '2025-06-22 02:19:31'),
(132, 20, 1, 'black', 'e5', '2025-06-22 02:19:33'),
(133, 20, 2, 'white', 'Bc4', '2025-06-22 02:19:37'),
(134, 20, 2, 'black', 'Na6', '2025-06-22 02:19:39'),
(135, 20, 3, 'white', 'Qh5', '2025-06-22 02:19:41'),
(136, 20, 3, 'black', 'Nb8', '2025-06-22 02:19:43'),
(137, 20, 4, 'white', 'Qxf7#', '2025-06-22 02:19:45'),
(138, 21, 1, 'white', 'e4', '2025-06-22 02:20:06'),
(139, 21, 1, 'black', 'e5', '2025-06-22 02:20:08'),
(140, 21, 2, 'white', 'Bc4', '2025-06-22 02:20:10'),
(141, 21, 2, 'black', 'Na6', '2025-06-22 02:20:17'),
(142, 21, 3, 'white', 'Qh5', '2025-06-22 02:20:18'),
(143, 21, 3, 'black', 'Nb8', '2025-06-22 02:20:21'),
(144, 21, 4, 'white', 'Qxf7#', '2025-06-22 02:20:23'),
(145, 22, 1, 'white', 'e4', '2025-06-22 02:20:40'),
(146, 22, 1, 'black', 'e5', '2025-06-22 02:20:42'),
(147, 22, 2, 'white', 'Bc4', '2025-06-22 02:20:44'),
(148, 22, 2, 'black', 'Na6', '2025-06-22 02:20:48'),
(149, 22, 3, 'white', 'Qh5', '2025-06-22 02:20:50'),
(150, 22, 3, 'black', 'Nb8', '2025-06-22 02:20:52'),
(151, 22, 4, 'white', 'Qxf7#', '2025-06-22 02:20:53'),
(152, 23, 1, 'white', 'e4', '2025-06-22 02:22:34'),
(153, 23, 1, 'black', 'e5', '2025-06-22 02:22:38'),
(154, 23, 2, 'white', 'Bc4', '2025-06-22 02:24:45'),
(155, 23, 2, 'black', 'Na6', '2025-06-22 02:24:48'),
(156, 23, 3, 'white', 'Qh5', '2025-06-22 02:24:51'),
(157, 23, 3, 'black', 'Nb8', '2025-06-22 02:24:53'),
(158, 23, 4, 'white', 'Qxf7#', '2025-06-22 02:24:55'),
(159, 24, 1, 'white', 'e4', '2025-06-22 02:28:47'),
(160, 24, 1, 'black', 'e5', '2025-06-22 02:28:49'),
(161, 24, 2, 'white', 'Bc4', '2025-06-22 02:28:52'),
(162, 24, 2, 'black', 'Na6', '2025-06-22 02:28:54'),
(163, 24, 3, 'white', 'Qh5', '2025-06-22 02:28:56'),
(164, 24, 3, 'black', 'Nb8', '2025-06-22 02:28:58'),
(165, 24, 4, 'white', 'Qxf7#', '2025-06-22 02:29:00'),
(166, 25, 1, 'white', 'e4', '2025-06-22 02:30:47'),
(167, 25, 1, 'black', 'e5', '2025-06-22 02:30:49'),
(168, 25, 2, 'white', 'Bc4', '2025-06-22 02:30:51'),
(169, 25, 2, 'black', 'Na6', '2025-06-22 02:30:53'),
(170, 25, 3, 'white', 'Qh5', '2025-06-22 02:30:56'),
(171, 25, 3, 'black', 'Nb8', '2025-06-22 02:30:58'),
(172, 25, 4, 'white', 'Qxf7#', '2025-06-22 02:30:59'),
(173, 26, 1, 'white', 'e4', '2025-06-22 02:46:30'),
(174, 26, 1, 'black', 'e5', '2025-06-22 02:46:32'),
(175, 26, 2, 'white', 'Bc4', '2025-06-22 02:46:34'),
(176, 26, 2, 'black', 'Na6', '2025-06-22 02:46:59'),
(177, 26, 3, 'white', 'Qh5', '2025-06-22 02:47:00'),
(178, 26, 3, 'black', 'Nb8', '2025-06-22 02:47:02'),
(179, 26, 4, 'white', 'Qxf7#', '2025-06-22 02:47:03'),
(180, 28, 1, 'white', 'e4', '2025-06-22 02:50:45'),
(181, 29, 1, 'white', 'e4', '2025-06-22 02:56:48'),
(182, 29, 1, 'black', 'e5', '2025-06-22 02:56:50'),
(183, 29, 2, 'white', 'Nh3', '2025-06-22 02:56:52'),
(184, 29, 2, 'black', 'Bc5', '2025-06-22 02:56:55'),
(185, 29, 3, 'white', 'Ng1', '2025-06-22 02:56:56'),
(186, 29, 3, 'black', 'Qh4', '2025-06-22 02:56:59'),
(187, 29, 4, 'white', 'a3', '2025-06-22 02:57:02'),
(188, 29, 4, 'black', 'Qxf2#', '2025-06-22 02:57:04'),
(189, 30, 1, 'white', 'e4', '2025-06-22 02:57:57'),
(190, 31, 1, 'white', 'e4', '2025-06-22 03:01:47'),
(191, 32, 1, 'white', 'e4', '2025-06-22 03:05:36'),
(192, 33, 1, 'white', 'e4', '2025-06-22 03:06:50'),
(193, 34, 1, 'white', 'e4', '2025-06-22 03:11:42'),
(194, 37, 1, 'white', 'e4', '2025-06-22 03:20:32'),
(195, 38, 1, 'white', 'e4', '2025-06-24 23:07:15'),
(196, 38, 1, 'black', 'e5', '2025-06-24 23:07:17'),
(197, 38, 2, 'white', 'Qh5', '2025-06-24 23:07:21'),
(198, 38, 2, 'black', 'Na6', '2025-06-24 23:07:23'),
(199, 38, 3, 'white', 'Bc4', '2025-06-24 23:07:27'),
(200, 38, 3, 'black', 'Nb8', '2025-06-24 23:07:28'),
(201, 38, 4, 'white', 'Qxf7#', '2025-06-24 23:07:30'),
(202, 39, 1, 'white', 'e4', '2025-06-24 23:11:08'),
(203, 39, 1, 'black', 'e5', '2025-06-24 23:11:09'),
(204, 39, 2, 'white', 'Bc4', '2025-06-24 23:11:11'),
(205, 39, 2, 'black', 'Bc5', '2025-06-24 23:11:13'),
(206, 39, 3, 'white', 'Na3', '2025-06-24 23:11:17'),
(207, 39, 3, 'black', 'Qh4', '2025-06-24 23:11:19'),
(208, 39, 4, 'white', 'Nb1', '2025-06-24 23:11:21'),
(209, 39, 4, 'black', 'Qxf2#', '2025-06-24 23:11:24'),
(210, 40, 1, 'white', 'e4', '2025-06-24 23:12:38'),
(211, 40, 1, 'black', 'e5', '2025-06-24 23:12:39'),
(212, 40, 2, 'white', 'Bc4', '2025-06-24 23:12:41'),
(213, 40, 2, 'black', 'Na6', '2025-06-24 23:12:42'),
(214, 40, 3, 'white', 'Qh5', '2025-06-24 23:12:44'),
(215, 40, 3, 'black', 'Nb8', '2025-06-24 23:12:45'),
(216, 40, 4, 'white', 'Qxf7#', '2025-06-24 23:12:46');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `statistics`
--

CREATE TABLE `statistics` (
  `user_id` int(11) NOT NULL DEFAULT 0,
  `games_played` int(11) NOT NULL DEFAULT 0,
  `games_won` int(11) NOT NULL DEFAULT 0,
  `games_lost` int(11) NOT NULL DEFAULT 0,
  `games_drawn` int(11) NOT NULL DEFAULT 0,
  `current_win_streak` int(11) NOT NULL DEFAULT 0,
  `max_win_streak` int(11) NOT NULL DEFAULT 0,
  `elo` int(11) NOT NULL DEFAULT 600,
  `max_elo` int(11) NOT NULL DEFAULT 600,
  `last_game_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `statistics`
--

INSERT INTO `statistics` (`user_id`, `games_played`, `games_won`, `games_lost`, `games_drawn`, `current_win_streak`, `max_win_streak`, `elo`, `max_elo`, `last_game_at`) VALUES
(61, 29, 22, 8, 0, 2, 7, 176, 644, '2025-06-24 23:12:48'),
(62, 29, 8, 22, 0, 0, 3, 108, 611, '2025-06-24 23:12:48');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(32) NOT NULL,
  `email` varchar(124) NOT NULL,
  `password_hash` varchar(256) NOT NULL,
  `role` enum('player','admin','moderator') NOT NULL DEFAULT 'player',
  `status` enum('active','banned','suspended','deleted') NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password_hash`, `role`, `status`, `created_at`) VALUES
(61, 'macius2010', '1@x.com', '$argon2id$v=19$m=19456,t=2,p=1$9dSHLRbypAwNgX4wwsJjwg$jEJJVZ0MiQXVxcyAw/2zWrofGW9+14kBe3lmzYJb2no', 'player', 'active', '2025-06-16 20:17:22'),
(62, 'rafalek2012', '2@x.com', '$argon2id$v=19$m=19456,t=2,p=1$jchnHyZW6aD3gS6KBUM+oQ$3pp5Kwbu5sTuwbY7CJud3i2suq0QMJbLkXdgmfytX8Y', 'player', 'active', '2025-06-16 20:18:11');

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `chat_messages`
--
ALTER TABLE `chat_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `games`
--
ALTER TABLE `games`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `moves`
--
ALTER TABLE `moves`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `statistics`
--
ALTER TABLE `statistics`
  ADD PRIMARY KEY (`user_id`);

--
-- Indeksy dla tabeli `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `chat_messages`
--
ALTER TABLE `chat_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `games`
--
ALTER TABLE `games`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `moves`
--
ALTER TABLE `moves`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=217;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `statistics`
--
ALTER TABLE `statistics`
  ADD CONSTRAINT `statistics_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
