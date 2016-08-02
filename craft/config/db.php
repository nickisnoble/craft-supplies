<?php

/**
 * Database Configuration
 *
 * All of your system's database configuration settings go in here.
 * You can see a list of the default settings in craft/app/etc/config/defaults/db.php
 */

return array(
	'*' => array(		
		'server' => 'localhost',
		'database' => 'craft',
		'tablePrefix' => 'craft',
  ),

  'yoursite.dev' => array(
    'user' => 'homestead',
		'password' => 'secret',
  ),

  'yoursite.com' => array(
    'user' => 'root',
		'password' => 'SUPERSECRETPASSWORD',
  )

);
