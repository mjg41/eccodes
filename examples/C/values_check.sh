#!/bin/sh
# (C) Copyright 2005- ECMWF.
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.
# 
# In applying this licence, ECMWF does not waive the privileges and immunities granted to it by
# virtue of its status as an intergovernmental organisation nor does it submit to any jurisdiction.
#

. ./include.sh

#Define a common label for all the tmp files
label="values_check_c"
tempOut=${label}.tmp.out
tempErr=${label}.tmp.err
tempRef=${label}.tmp.ref


cat > $tempRef <<EOF
Error: "level" Value is different
Error: "levelll" Key/value not found
EOF

# Input file path is hard coded in the example
${examples_dir}/c_values_check 2> $tempErr 1> $tempOut

# Compare output with the reference
diff $tempRef $tempErr

# Clean up
rm -f $tempRef $tempErr $tempOut
