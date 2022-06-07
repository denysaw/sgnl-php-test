<?php
/**
 * @author Denysaw
 */
declare(strict_types=1);

namespace App\Controllers;

/**
 * Class ApiController
 * @package App\Controllers
 */
class ApiController
{
    public function notFoundAction()
    {
        echo 'Endpoint not found';
    }

    /**
     * @param string $str
     */
    protected function textResponse(string $str)
    {
        die($str);
    }

    /**
     * @param array|object $data
     */
    protected function jsonResponse(array|object $data)
    {
        header('Content-Type: application/json; charset=utf-8');
        die(json_encode($data));
    }
}