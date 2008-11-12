#!/bin/bash

export PTX_KGEN_DIR="${PTXDIST_TEMPDIR}/kgen"

#
# local defined vars
#
# FIXME: use these globaly
#
PTXDIST_OVERWRITE_DIRS_MSB=( "${PTXDIST_PLATFORMCONFIGDIR}" "${PTXDIST_WORKSPACE}" "${PTXDIST_TOPDIR}" )
PTXDIST_OVERWRITE_DIRS_LSB=( "${PTXDIST_TOPDIR}" "${PTXDIST_WORKSPACE}" "${PTXDIST_PLATFORMCONFIGDIR}" )

ptxd_kgen_awk()
{
    gawk '
	BEGIN {
	    FS = ":##[[:space:]]*SECTION=|[[:space:]]*$";
	}

	{
	    file = $1;
	    section = $2;
	    pkg = gensub(/.*\//, "", "g", file);

	    pkgs[section, pkg] = file;
	}

	END {
	    n = asorti(pkgs, sorted);

	    for (i = 1; i <= n; i++) {
		split(sorted[i], sep, SUBSEP)

		file = pkgs[sorted[i]];
		section = sep[1];
		pkg = sep[2];

		output = "'"${PTX_KGEN_DIR}"'" "/" section ".in";

#		print output ":", "source \"" file "\""
		print "source \"" file "\"" > output
	    }
	}
	'
}


ptxd_kgen_generate_sections()
{
    local dir

    (
	for dir in "${PTXDIST_OVERWRITE_DIRS_LSB[@]}"; do
	    if [ \! -d "${dir}/rules" ]; then
		continue
	    fi

	    if [ -z "$(find "${dir}/rules" -name *.in)" ]; then
		continue
	    fi

	    grep -R -H -e "^##[[:space:]]*SECTION=" "${dir}/rules/"*.in
	done
    ) | ptxd_kgen_awk
}


ptxd_kgen()
{
    if [ -e "${PTX_KGEN_DIR}" ]; then
	rm -rf "${PTX_KGEN_DIR}"
    fi

    mkdir -p "${PTX_KGEN_DIR}"

    ptxd_kgen_generate_sections
}
