<?php

/**
* Simpla CMS
*
* @copyright   2018 Alexandr Alexandrov
* @link                http://php.net
* @author              Alexandr Alexandrov
*
*/

require_once('Simpla.php');

class Parameters extends Simpla
	{
	private $parameters = array();
	private $parameter;

	public function __construct(){
		parent::__construct();
		$this->init_parameters();
	}
	
        private function init_parameters()
        {
                $this->parameters = array();
                // Выбираем из базы валюты
    $query = "SELECT parameters_id, stock_parameters FROM __parameters";
                $this->db->query($query);
                $results = $this->db->results();

                foreach($results as $c)
                {
                        $this->parameters[$c->parameters_id] = $c;
                }
                /*возвращает первый елемент с массива если массив пуст*/
                $this->parameter = reset($this->parameters);
        }
	 /*
        *
        *  Вывод параметров для товара
        *  @param parameters
        *
        *
        */
	public function get_parameters () 
	{
		$parameters = array();
                foreach($this->parameters as $id=>$parameter){
			$parameters[$id] = $parameter;
		}
		return $parameters;
		
	}
	public function get_parameter($id = null)
        {
                if(!empty($id) && is_integer($id) && isset($this->parameters[$id]))
                        return $this->parameters[$id];

                if(!empty($id) && is_string($id))
                {
                        foreach($this->parameters as $parameter)
                        {
                                if($parameter->parameters_id == $id)
                                        return $parameter;
                        }
                }
                return $this->parameter;
        }	
	/*
        *
        * Добавления параметра
        * @param $param
        *
        */
	public function add_parameter($parameter)
        {
                $this->db->query("INSERT INTO __parameters SET ?%", $parameter);
                return $this->db->insert_id();
        
	}

        /*
        *
        * Обновление параметров
        * @param $param
        *
        */
        public function update_parameter($id, $parameter)
        {
	$query = $this->db->placehold('UPDATE __parameters SET ?% WHERE parameters_id in (?@)', $parameter , (array)$id);
		if(!$this->db->query($query))
			return false;
		$this->init_parameters();
                return $id;
        }
	public function delete_parameter($id)                                         {
                if(!empty($id))
                {
                        $query = $this->db->placehold("DELETE FROM __parameters WHERE parameters_id=? LIMIT 1", intval($id));
                        $this->db->query($query);
                }
                $this->init_parameters();
        }
}
