<?php
require_once('api/Simpla.php');

class ParametersAdmin extends Simpla
{
        public function fetch()
        {
		if($this->request->method('post'))
               	{

		foreach($this->request->post('parameters') as $n=>$va)
                                foreach($va as $i=>$v)
                                        {
                                          if(empty($parameters[$i]))
                                              $parameters[$i] = new stdClass;
                                                $parameters[$i]->$n = $v;
				}
		foreach ($parameters as $parameter) {
			if($parameter->parameters_id){
		$this->parameters->update_parameter($parameter->parameters_id, $parameter);
		$this->design->assign('message_success','updated');
			}
			else {
		$parameter->parameters_id = $this->parameters->add_parameter($parameter);
		$this->design->assign('message_success','added');
			}	
		}
			$action = $this->request->post('action');
                        $id = $this->request->post('action_id');
                        if(!empty($action) && !empty($id)){
					$this->parameters->delete_parameter($id);
				}
		}
		$parameters = $this->parameters->get_parameters();
		$parameter = $this->parameters->get_parameter();
                $this->design->assign('parameters', $parameters);
		$this->design->assign('parameter', $parameter);	
		return $this->design->fetch('parameters.tpl'); 	

	}
}

