#!/bin/bash

sudo -E -u perforce p4p -d -p ${PORT} -t ${P4TARGET} -r ${P4PCACHE} -L ${P4PLOGFILE} -v 3
