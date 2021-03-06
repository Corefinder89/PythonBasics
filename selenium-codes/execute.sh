#!/bin/bash

set -eu

# Check if html_reports directory is present
if [ -d "html_reports" ]; then
    echo "directory html_reports already present in path"
else
    mkdir html_reports
    echo "directory html_reports created"
fi

# Check if html_reports directory is present
if [ -d "logs" ]; then
    echo "directory logs already present in path"
else
    mkdir logs
    echo "directory logs created"
fi

# Validate that if an argument is passed or not
echo "The total number of arguments are $#"
if [ $# -eq 0 ]; then echo "No option is passed as argument"; fi

# Parse command line argument to run tests accordingly
for i in "$@"; do
    case $i in
        --regression) pytest test -s -v -m regression --html=html_reports/reports.html --log-file logs/"$(date '+%F_%H:%M:%S')".log
            break
            ;;
        --smoke) pytest test -s -v -m smoke --html=html_reports/reports.html --log-file logs/"$(date '+%F_%H:%M:%S')".log
            break
            ;;
        --sanity) pytest test -s -v -m sanity --html=html_reports/reports.html --log-file logs/"$(date '+%F_%H:%M:%S')".log
            break
            ;;
        --apitest) pytest app/test -m apitest
            break
            ;;
        *) echo "Option not available"
            ;;
    esac
done

test_exit_status=$?

exit $test_exit_status
