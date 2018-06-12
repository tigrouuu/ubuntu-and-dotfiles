<?php

// This configuration file allows you to store your web root and different elements.

/*
*  $projroot is a path for folder's Localhomepage.
*  It contains css/img files for build the "../index.php"
*/
$projroot = './Localhomepage';

/**
*  directory name(s)
*
*  Your directory where you keep your sites can be Sites folder in ~ (/Users/username)
*  So all folders are in "/srv/http/Code/*"
*
*  $dir = array("/srv/http/Code/*");
*
*  You have another directory where you keep your sites ? Add multiple directories like this:
*  $dir = array("/srv/http/Code-1/*","/srv/http/Code-2/*");
*/
$dir = ['/srv/http/Code/*'];

/*
*  Your local top level domain.
*  If you have a vhosts, change your local domain here.
*/
$tld = 'dev';

/*
*  Icon file names you would like to display next to the link to each site.
*  In order of the priority they should be used.
*  Put the favicon at the root of each folder.
*/
$icons = ['apple-touch-icon.png', 'favicon.ico'];

/*
*  Development tools you want displayed in the top navigation bar.
*  Each item should be an array containing keys 'name', 'url' and 'icon'.
*
*  No interest in having a Home link as we open all the links in a new tab
*/
$devtools = [
  [
    'name' => 'Trello',
    'url'  => 'https://trello.com/',
    'icon' => 'fab fa-trello'
  ], [
    'name' => 'Adminer',
    'url'  => 'http://code.local/adminer',
    'icon' => 'fas fa-database'
  ], [
    'name' => 'MailDev',
    'url'  => 'http://code.local:1080/',
    'icon' => 'fas fa-envelope'
  ], [
    'name' => 'PHPinfo',
    'url'  => 'http://code.local/Localhomepage/info.php',
    'icon' => 'fab fa-php'
  ], [
    'name' => 'Github',
    'url'  => 'https://github.com/tigrouuu',
    'icon' => 'fab fa-github'
  ], [
    'name' => 'Folders',
    'url'  => 'http://code.local/Folders',
    'icon' => 'fas fa-folder-open'
  ]
];

/*
*  Options for sites being displayed. These are completely optional, if you don't set
*  anything there are default options which will take over.
*
*  If you only want to specify a display name for a site you can use the format:
*
*  'sitedir' => 'Display Name',
*
*  Otherwise, if you want to set additional options you'll use an array for the options.
*
*  'sitedir' => array( 'displayname' => 'Display Name', 'adminurl' => 'http://example.sites.dev/admin' ),
*/
$siteoptions = [
  // 'dirname' => 'images',
  // 'dirname' => array( 'displayname' => 'DisplayName', 'adminurl' => 'http://something/admin' ),
];

/*
*  Directory names of sites you want to hide from the page.
*  If you're using multiple directories in $dir be aware that any directory
*  names in the array below that show up in any of your directories will
*  be hidden.
*  It also works for files.
*
*  By default, we don't want "index.php" and "Localhomepage" to be indexed in the list.
*  And we want a folder containing other files or folders without being indexed here.
*  We create "Folders", put here in $hiddensites et put in $devtools.
*/
$hiddensites = ['Labs'];
