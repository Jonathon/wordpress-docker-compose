margaret-dodd-australain-artist-styles.zip
=================

Ready-to-Use Child Theme for the OceanWP free WordPress theme.

### Usage
Download the child theme zip file. Upload the zip (oceanwp-child-theme-master.zip) under your WordPress dashboard, Appearance > Themes.The other method would be to extract files and upload via FTP at wp-content/themes/.

### Local Docker Workflow
This repository now includes a `plugins/` directory for local Docker development.

- `./` is mounted into `wp-content/themes/oceanwp-child-theme/`
- `./plugins` is mounted into `wp-content/plugins/`

This keeps installed plugins visible on disk and makes the local environment easier to reproduce and manage.
The `plugins/` directory is intended to be committed to Git so the local plugin set stays versioned with the project.

If you add or remove plugins through the WordPress admin while Docker is running, the changes will happen in the local `plugins/` folder instead of staying hidden inside the Docker volume.

Plugin management helpers:

- `./scripts/plugin-report.sh` prints installed plugin names, versions, and active status from the running container
- `./scripts/sync-plugins-from-container.sh` copies plugins from the running container back into `./plugins` if you ever need to resync


### Renaming
You can rename the zip file so it isn't called oceanwp-child-theme-master.zip.
You can also change the "Theme Name" at the top of the style.css file, as well as the rest of information in the same file. This is called whitelabeling a child theme.
