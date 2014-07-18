<?php

	/**
	* 
	*/
	class DB{
		
		private static $_instance = null;
		private $_pdo, 
				$_query, 
				$_error = false, 
				$_results, 
				$_count = 0;
		/*
		*	creates connection using the config class and vars in init.php files
		*
		*/
		private function __construct()
		{
			try {
				$this->_pdo = new PDO('mysql:host=' . Config::get('mysql/host') . ';dbname=' . 
					Config::get('mysql/db') . ';', Config::get('mysql/username'), Config::get('mysql/password'));
			} catch (Exception $e) {
				die($e->getMessage());	
			}
		}
		/*
		*	Calls the construct method to create connection if there is no connection
		*	@returns  PDO object created in the construct method
		*/
		public static function getInstance(){
			if (!isset(self::$_instance)) {
				self::$_instance = new DB();
			}
			return self::$_instance;
		}

		/*
		*	Creates query results
		*	@param $sql is the SQL statement for the PDO object
		*	example SELECT * FROM table WHERE name = ?
		*	@param $params array with params that are going to be prepare
		*	example 'Juan' for name
		*	@return object
		*	load result set into $_result property
		*/
		public function query($sql, $params = array()){
			$this->_error = false;
			if ($this->_query = $this->_pdo->prepare($sql)) {
				$x = 1;
				if (count($params)) {
					foreach ($params as $param) {
						$this->_query->bindValue($x, $param);
						$x++;
					}
				}
				if ($this->_query->execute()) {
					$this->_results = $this->_query->fetchAll(PDO::FETCH_OBJ);
					$this->_count = $this->_query->rowCount();
				}else{
					$this->_error = true;
				}
			}
			return $this;
		}

		/*
		*	prepare query statement
		*	@param $action string describe the type of operation
		*	@param $table string with the table name
		*	@param $where array is for the field research; example 'name' '=' 'billy'
		*	returns result set using query method
		*/
		public function action($action, $table, $where = array()){
			if(count($where) === 3) {
				$operators = array('=', '>', '<', '>=', '<=');

				$field 		= $where[0];
				$operator 	= $where[1];
				$value 		= $where[2];

				if(in_array($operator, $operators)){
					$sql = "{$action} FROM {$table} WHERE {$field} {$operator} ?";

					if(!$this->query($sql, array($value))->error()) {
						return $this;
					}
				}
			}
			return false;
		}

		/*
		*	Simplify action/query methods of this class for select mysql functions
		*	it has * by default in the field specification, use action for more accurate search
		*	@param $table use the table name
		*	@param where is for the field research; example 'name' '=' 'billy'
		*	@return result set using action method  
		*/
		public function get($table, $where = array()){
			return $this->action('SELECT *', $table, $where);
		}		

		/*
		*	Simplify action/query methods of this class for delete mysql function
		*	@param $table use the table name
		*	@param where is for the field research; example 'name' '=' 'billy'
		*	@return result set using action method  
		*/
		public function delete($table, $where = array()){
			return $this->action('DELETE', $table, $where);
		}

		/*
		*	@return 
		*	
		*/
		public function results(){
			return $this->_results;
		}


		/*
		*	@return 
		*	
		*/
		public function insert($table, $fields = array()){
			$keys = array_keys($fields);		
			$values = '';
			$i = 1;

			foreach ($fields as $field) {
				$values .= "?";
				if ($i < count($fields)) {
					$values .= ', ';
				}
				$i++;
			}

			$sql = "INSERT INTO {$table} (`" . implode('`, `', $keys) ."`) VALUES ({$values})";

			if (!$this->query($sql, $fields)->error()) {
				return true;
			}
			return false;
		}

		/*
		*	@return 
		*	
		*/
		public function update($table, $id, $fields){
			$set = '';
			$i = 1;

			foreach ($fields as $name => $value) {
				$set .= "{$name} = ?";
				if ($i < count($fields)) {
					$set .= ', ';
				}
				$i++;
			}

			$sql = "UPDATE {$table} SET {$set} WHERE id = {$id}";
			//var_dump($id);echo"<hr>";var_dump($sql);echo"<hr>";var_dump($fields);echo"<hr>";die();
			if (!$this->query($sql, $fields)->error()) {
				return true;
			}
			return false;
		}

		/*
		*	@return 
		*	
		*/
		public function first(){
			return $this->results()[0];
		}

		/*
		*	@return 
		*	
		*/
		public function count(){
			return $this->_count;
		}

		/*
		*	@return the content of the _error property
		*	true = errors, false = no errors
		*/
		public function error(){
			return $this->_error;
		}

	}
