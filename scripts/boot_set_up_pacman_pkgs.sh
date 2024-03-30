#!@TERMUX_PREFIX@/bin/bash

# --- boot_set_up_pacman_pkgs.sh ---
# This script runs the packages 'post_install' function.
# They are not run during the creation of bootstrap based
# on pacman as this is not possible. They must be running
# on Termux devices for the packages to function completely properly.
#
# This script is one-time only. After launching, it will
# be automatically deleted to avoid running it again.

(
export TERMUX_PREFIX="@TERMUX_PREFIX@"

_boot_message() {
	echo -e "\033[1;34m[*]\033[0m ${1}"
}

_boot_message "Automatic one-time setup of packages has been launched, setup is in progress..."

for i in ${TERMUX_PREFIX}/var/lib/pacman/local/*/install; do
	(
		source ${i}
		if type post_install &> /dev/null; then
			DIR=$(dirname ${i})
			_boot_message "Setting up the ${DIR##*/} package..."
			post_install &> /dev/null || true
		fi
	)
done

_boot_message "Setting up packages is complete, pleasant use Termux :)"

rm ${BASH_SOURCE[0]}
)
