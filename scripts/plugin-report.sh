#!/bin/sh

set -eu

CONTAINER_NAME="${1:-wordpress-oceanwp}"

docker exec "$CONTAINER_NAME" php -r '
require "/var/www/html/wp-load.php";
require_once ABSPATH . "wp-admin/includes/plugin.php";

$plugins = get_plugins();
ksort($plugins);

foreach ($plugins as $file => $data) {
    $name = $data["Name"] ?? "";
    $version = $data["Version"] ?? "";
    $status = is_plugin_active($file) ? "active" : "inactive";
    echo $file, "|", $name, "|", $version, "|", $status, PHP_EOL;
}
'
