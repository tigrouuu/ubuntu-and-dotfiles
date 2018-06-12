<?php require('./Localhomepage/config.php'); ?>

<!doctype html>
<html lang="fr">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Liste de projets</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link rel="icon" href="<?= $projroot ?>/img/favicon.ico">
    <link rel="stylesheet" href="<?= $projroot ?>/css/main.css">
    <link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css" rel="stylesheet">
  </head>
  <body>
    <div class="canvas">
      <header>
        <h1>Liste de projets</h1>

        <nav>
          <ul>
            <?php
            foreach ($devtools as $tool) {
                echo '<li><a href="'.$tool['url'].'" target="_blank"><i class="'.$tool['icon'].'"></i>
                '.$tool['name'].'</a></li>';
            }
            ?>
          </ul>
        </nav>
      </header>
      <content class="cf">
        <?php
        foreach ($dir as $d) {
            /*
            *  Retrieves the folder where your working folders are placed
            *  /srv/http/Code/* gives : Code ($dirname)
            */
            $dirsplit = explode('/', $d);
            $dirname = $dirsplit[count($dirsplit)-2];

            printf('<ul class="sites %1$s">', $dirname);

            /*
            *  glob($d) returns all files and folders in your $dirname
            *  $file is a full path of file/folder (ex : /srv/http/Code/Blog)
            */
            foreach (glob($d) as $file) {
                // $project gives the name of the file/folder (ex : Blog)
                $project = basename($file);

                // Only non-blacklisted files/folders
                if (in_array($project, $hiddensites)) {
                    continue;
                }

                echo '<li>';

                /*
                *  $siteroot show a link like : http://blog.dev
                *
                *  Edit your httpd-vhosts.conf and add this :
                *  <VirtualHost *:80>
                *      DocumentRoot "/srv/http/Code/blog/"
                *      ServerName blog.dev
                *  </VirtualHost>
                *
                *  Otherwise change the following line by :
                *
                *  $siteroot = sprintf( 'http://code.local/%1$s', $project );
                *  $siteroot gives http://code.local/blog
                *
                *  $siteroot = sprintf( 'http://%1$s.%2$s', $project, $tld );
                */

                $siteroot = sprintf('http://code.local/Code/%1$s', $project);

                // Display an icon for the site
                $icon_output = '<span class="no-img"></span>';

                foreach ($icons as $icon) {
                    if (file_exists($file . '/' . $icon)) {
                        /*
                        *  Put the favicon at the root of each folder
                        *  Show : <img src="http://blog.dev/apple-touch-icon.png">
                        */
                        $icon_output = sprintf('<img src="%1$s/%2$s">', $siteroot, $icon);
                        break;
                    }
                }

                echo $icon_output;

                // Display a link to the site
                $displayname = $project;

                // If you added things in $siteoptions in your config.php
                if (array_key_exists($project, $siteoptions)) {
                    if (is_array($siteoptions[$project])) {
                        $displayname = array_key_exists('displayname', $siteoptions[$project]) ?
                          $siteoptions[$project]['displayname'] : $project;
                    } else {
                        $displayname = $siteoptions[$project];
                    }
                }

                if (is_dir($file . '/vendor/laravel')) {
                    $siteroot = $siteroot . '/public/';
                }

                echo '<a class="site" href="'.$siteroot.'" target="_blank">'.ucfirst($displayname).'</a>';

                // Display a link to the admin area
                $adminurl = '';

                // Admin url for Laravel 5
                if (is_dir($file . '/app/Http/Controllers/Backend')) {
                    $adminurl = sprintf('%1$s/admin', $siteroot);
                }

                // Admin url for WordPress
                if (is_dir($file . '/wp-admin')) {
                    $adminurl = sprintf('%1$s/wp-admin', $siteroot);
                }

                // If you added an adminurl in $siteoptions in your config.php
                if (isset($siteoptions[$project]) &&
                    is_array($siteoptions[$project]) &&
                    array_key_exists('adminurl', $siteoptions[$project])
                ) {
                    $adminurl = $siteoptions[$project]['adminurl'];
                }

                // Display an icon for the admin area
                if (!empty($adminurl)) {
                    if (is_dir($file . '/app/Http/Controllers/Backend')) {
                        echo '<a class="laravel icon" href="'.$adminurl.'">Admin</a>';
                    } elseif (is_dir($file . '/wp-admin')) {
                        echo '<a class="wp icon" href="'.$adminurl.'">Admin</a>';
                    } else {
                        echo '<a class="admin icon" href="'.$adminurl.'">Admin</a>';
                    }
                }

                echo '</li>';
            } // foreach(glob($d) as $file)

            echo '</ul>';
        } // foreach ($dir as $d)
        ?>
      </content>
      <footer class="cf"></footer>
    </div>
  </body>
</html>
