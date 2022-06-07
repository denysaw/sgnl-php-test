<?php
/**
 * @author Denysaw
 */
declare(strict_types=1);

use App\Utils\Router;

$router = new Router();

$router->add('/employee/find', 'employee/find');

$router->handle($_SERVER['REQUEST_URI']);