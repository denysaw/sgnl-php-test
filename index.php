<?php
/**
 * @author Denysaw
 */
ini_set('display_errors', true);
error_reporting(E_ALL);

define('APP_PATH', __DIR__);

if (php_sapi_name() == 'cli') {
    die('Sorry, this app cannot be ran in terminal');
}

spl_autoload_extensions('.php');

spl_autoload_register(function($class) {
    $parts = explode('\\', $class);
    $class = array_pop($parts);
    array_shift($parts);

    $dirs = implode('/', array_map(function($dir) {
        return strtolower($dir);
    }, $parts));

    $path = APP_PATH."/$dirs/$class.php";

    if (file_exists($path)) {
        include_once $path;
    } else {
        die("Fatal error: cannot load class $class at $path");
    }
});

try {
    $host = getenv('DB_HOST') ?: 'localhost';
    $port = getenv('DB_PORT') ?: '5432';
    $name = getenv('DB_NAME') ?: 'sgnl_test2';
    $user = getenv('DB_USER') ?: 'denysaw';
    $pass = getenv('DB_PASS') ?: '';

    define('DB', new PDO("pgsql:host=$host;port=$port;dbname=$name;user=$user;password=$pass"));
}
catch(PDOException $e) {
    echo $e->getMessage();
}

// Simplest migration:
$migrated = DB->query("SELECT EXISTS (SELECT FROM pg_tables WHERE tablename = 'departments')")->fetchObject();

if (!$migrated->exists) {
    DB->exec(file_get_contents('migration.sql'));
}

require_once APP_PATH. '/routes.php';