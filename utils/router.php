<?php
/**
 * @author Denysaw
 */
declare(strict_types=1);

namespace App\Utils;
use ReflectionException;

/**
 * Class Router
 * @package App\Utils
 */
class Router
{

    /**
     * @var array
     */
    protected array $routes = [];


    /**
     * @param string $url
     * @param string $action
     */
    public function add(string $url, string $action): void
    {
        $this->routes[] = (object) ['url' => $url, 'action' => $action];
    }


    /**
     * @param string $url
     * @throws ReflectionException
     */
    public function handle(string $url): void
    {
        $url = strtok($_SERVER["REQUEST_URI"], '?');

        foreach ($this->routes as $route) {
            if (preg_match('~^' . $route->url . '$~', $url)) {
                @list($controller, $action) = explode('/', $route->action);
                break;
            }
        }

        if (!isset($controller)) $controller = 'api';
        if (!isset($action)) $action = 'notFound';

        $controller = 'App\\Controllers\\'. ucfirst($controller). 'Controller';
        $controller = $this->instantiate($controller);

        $controller->{$action. 'Action'}((object)[...$_GET, ...$_POST]);
    }


    /**
     * @param string $class
     * @return mixed
     * @throws ReflectionException
     */
    protected function instantiate(string $class): mixed
    {
        $args = [];

        if (method_exists($class, '__construct')) {
            $reflection = new \ReflectionMethod($class, '__construct');

            foreach ($reflection->getParameters() as $param) {
                $dependency = (string) $param->getType();
                if (!trim($dependency)) continue;

                $args[] = $this->instantiate($dependency);
            }
        }

        return new $class(...$args);
    }
}