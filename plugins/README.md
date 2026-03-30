Committed WordPress plugins live in this directory.

Workflow:

- WordPress mounts this folder to `wp-content/plugins`
- Plugin installs, removals, and updates made in wp-admin change files here
- Commit plugin changes when you want them tracked with the project

Helpful scripts:

- `./scripts/plugin-report.sh`
- `./scripts/sync-plugins-from-container.sh`
