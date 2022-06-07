<?php
/**
 * @author Denysaw
 */
declare(strict_types=1);

namespace App\Controllers;

/**
 * Class EmployeeController
 * @package App\Controllers
 */
class EmployeeController extends ApiController
{
    /**
     * @param object $params
     */
    public function findAction($params)
    {
        if (!isset($params->cn)) {
            $this->jsonResponse(['error' => 'Required `cn` parameter is missing']);
        }

        $stm = DB->prepare("SELECT employees.full_name, string_agg(departments.name, ',') AS department
            FROM rfid_cards 
            JOIN employees ON rfid_cards.employee_id = employees.id
            JOIN department_employee ON department_employee.employee_id = employees.id
            JOIN departments ON department_employee.department_id = departments.id
            WHERE card_number = :card_number GROUP BY employees.id");

        $stm->bindValue(':card_number', $params->cn);
        $stm->execute();

        $res = $stm->fetchObject();

        if (!$res) {
            $this->jsonResponse(['full_name' => '', 'department' => []]);
        }

        $res->department = explode(',', $res->department);

        $this->jsonResponse($res);
    }
}