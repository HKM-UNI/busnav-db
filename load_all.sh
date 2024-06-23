set -e

if [ -x "$(command -v mariadb)" ]; then
    alias sqlclient=mariadb
elif [ -x "$(command -v mysql)" ]; then
    alias sqlclient=mysql
else
    printf "🤔 Looks like you haven't installed a MySQL client\n"
    printf "Go to https://dev.mysql.com/downloads/installer/ and download the installer for your platform\n"
    exit 1
fi

user="$1"
password="$2"
host=${3:-localhost}
port=${4:-3306}
database='busnav'
# sql_dirs=('')
declare -a sql_dirs=()

if [[ -z ${user} || -z ${password} ]]; then
    echo '⚠️ You are logging in without credentials'
    echo 'If you need to specify a user you can do it from the arguments'
    echo 'e.g: ./load_all.sh "root" "1234"'
fi

sqlclient -h${host} -P${port} -u${user} -p${password} -e "drop database if exists $database;"

[[ -d "Logs" ]] && rm -rf "Logs"
[[ ! -d "Logs" ]] && mkdir "Logs"

sqlclient -h${host} -P${port} -u${user} -p${password} -v < "BusNav.sql" > "Logs/00. Creation.txt"

for dir in "${sql_dirs[@]}"; do
    [[ ! -d "Logs/$dir" ]] && mkdir "Logs/$dir"
    for script in "$dir"/*.sql; do
        sqlclient \
            -h${host} \
            -P${port} \
            -u${user} \
            -p${password} \
            -v $database \
        < "$script" \
        > "Logs/${script%.*}.txt"
    done
done
