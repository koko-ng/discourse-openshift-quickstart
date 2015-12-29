#!/bin/bash
function discourse_precompile_assets {
	if ! [ -d "$1" ]; then
		mkdir "$1"
	fi
	cd "${OPENSHIFT_REPO_DIR}"
	RAILS_ENV=production bundle exec rake assets:precompile
	mv "${OPENSHIFT_REPO_DIR}public/assets" "$1/"
}
function discourse_link_assets {
	ln -s "$1/assets" "${OPENSHIFT_REPO_DIR}public/assets"
}
function discourse_assets_usage {
         echo -ne "Usage: $0 [ACTION] ASSETS_PERMANENT_DIR
ACTIONS:
  precompile    precompile assets and move to ASSETS_PERMANENT_DIR
  link          link assets to the repo directory
"
	exit 0;
}
if ! [ "$2" ]; then
	discourse_assets_usage
fi
case "${1}" in
	precompile)
		discourse_precompile_assets "${2}"
		;;
	link)
		discourse_link_assets "${2}"
		;;
	help)
		discourse_assets_usage
		;;
esac
