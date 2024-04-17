-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 10-04-2024 a las 12:37:38
-- Versión del servidor: 10.4.11-MariaDB
-- Versión de PHP: 7.4.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bd_academia`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumnos`
--

CREATE TABLE `alumnos` (
  `al_id` int(11) NOT NULL,
  `al_nombre` varchar(50) NOT NULL,
  `al_apellidos` varchar(50) NOT NULL,
  `al_fnac` date NOT NULL,
  `al_cur_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `alumnos`
--

INSERT INTO `alumnos` (`al_id`, `al_nombre`, `al_apellidos`, `al_fnac`, `al_cur_id`) VALUES
(1, 'pepe', 'pep', '2000-01-01', 1),
(2, 'juan', 'jua', '1999-01-01', 1),
(3, 'ana', 'an', '2001-01-01', 2),
(4, 'eva', 'ev', '2002-01-01', 2),
(5, 'claudia', 'candelas', '2005-03-12', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asignaturas`
--

CREATE TABLE `asignaturas` (
  `as_id` int(11) NOT NULL,
  `as_nombre` varchar(50) NOT NULL,
  `as_descripcion` text NOT NULL,
  `as_cur_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `asignaturas`
--

INSERT INTO `asignaturas` (`as_id`, `as_nombre`, `as_descripcion`, `as_cur_id`) VALUES
(1, 'FOL', '', 1),
(2, 'FOL', '', 2),
(3, 'Marcas', '', 1),
(4, 'Marcas', '', 2),
(5, 'BBDD', '', 1),
(6, 'BBDD', '', 2),
(7, 'Programacion', '', 1),
(8, 'Programacion', '', 2),
(9, 'Sistemas', '', 1),
(10, 'Sistemas', '', 2),
(11, 'Entornos', '', 1),
(12, 'Entornos', '', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cursos`
--

CREATE TABLE `cursos` (
  `cur_id` int(11) NOT NULL,
  `cur_nombre` varchar(50) NOT NULL,
  `cur_plazas` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cursos`
--

INSERT INTO `cursos` (`cur_id`, `cur_nombre`, `cur_plazas`) VALUES
(1, 'DAM1', 30),
(2, 'DAW1', 25),
(3, 'DAM2', 20),
(4, 'DAW2', 30),
(5, 'x', 33),
(6, 'modificado', 33);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notas`
--

CREATE TABLE `notas` (
  `als_al_id` int(11) NOT NULL,
  `als_as_id` int(11) NOT NULL,
  `als_nota` decimal(4,0) NOT NULL,
  `als_fecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alumnos`
--
ALTER TABLE `alumnos`
  ADD PRIMARY KEY (`al_id`),
  ADD KEY `r_alumnos_cursos` (`al_cur_id`);

--
-- Indices de la tabla `asignaturas`
--
ALTER TABLE `asignaturas`
  ADD PRIMARY KEY (`as_id`),
  ADD KEY `r_asignaturas_cursos` (`as_cur_id`);

--
-- Indices de la tabla `cursos`
--
ALTER TABLE `cursos`
  ADD PRIMARY KEY (`cur_id`);

--
-- Indices de la tabla `notas`
--
ALTER TABLE `notas`
  ADD PRIMARY KEY (`als_al_id`,`als_as_id`,`als_fecha`),
  ADD KEY `r_als_asignaturas` (`als_as_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `alumnos`
--
ALTER TABLE `alumnos`
  MODIFY `al_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `asignaturas`
--
ALTER TABLE `asignaturas`
  MODIFY `as_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `cursos`
--
ALTER TABLE `cursos`
  MODIFY `cur_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `alumnos`
--
ALTER TABLE `alumnos`
  ADD CONSTRAINT `r_alumnos_cursos` FOREIGN KEY (`al_cur_id`) REFERENCES `cursos` (`cur_id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `asignaturas`
--
ALTER TABLE `asignaturas`
  ADD CONSTRAINT `r_asignaturas_cursos` FOREIGN KEY (`as_cur_id`) REFERENCES `cursos` (`cur_id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `notas`
--
ALTER TABLE `notas`
  ADD CONSTRAINT `r_als_alumnos` FOREIGN KEY (`als_al_id`) REFERENCES `alumnos` (`al_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `r_als_asignaturas` FOREIGN KEY (`als_as_id`) REFERENCES `asignaturas` (`as_id`) ON DELETE NO ACTION ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
