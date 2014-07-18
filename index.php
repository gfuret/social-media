<?php

	include 'core/init.php';

	if (Session::exists('success')) {
		echo '<p>' . Session::flash('success') . '</p>';
	}

	$user = new User();
	if ($user->isLoggedIn()) {
?>
	<p>Hello <a href="profile.php?user=<?php echo escape($user->data()->username); ?>"><?php echo escape($user->data()->username); ?></a>!</p>
	<ul>
		<li><a href="logout.php">Log out</a></li>
		<li><a href="update.php">Update details</a></li>
		<li><a href="changepassword.php">Update password</a></li>
	</ul>

<?php
		if ($user->hasPermission('admin')) {
			echo "You are an admin";
		}else{
			echo "You are not an admin";
		}

	} else {
		echo '<p><a href="login.php">Login</a> or <a href="register.php">register</a></p>';
	}

