# echo to stderr
>&2 echo "error"

export RESET="\033[0m"
export BLACK="\033[30m"
export RED="\033[31m"
export GREEN="\033[32m"
export YELLOW="\033[33m"
export BLUE="\033[34m"
export MAGENTA="\033[35m"
export CYAN="\033[36m"
export WHITE="\033[37m"
export BOLD_BLACK="\033[1m\033[30m"
export BOLD_RED="\033[1m\033[31m"
export BOLD_GREEN="\033[1m\033[32m"
export BOLD_YELLOW="\033[1m\033[33m"
export BOLD_BLUE="\033[1m\033[34m"
export BOLD_MAGENTA="\033[1m\033[35m"
export BOLD_CYAN="\033[1m\033[36m"
export BOLD_WHITE="\033[1m\033[37m"
export BACKGROUND_RESET="\033[49m"
export BACKGROUND_BLACK="\033[40m"
export BACKGROUND_RED="\033[41m"
export BACKGROUND_GREEN="\033[42m"
export BACKGROUND_YELLOW="\033[43m"
export BACKGROUND_BLUE="\033[44m"
export BACKGROUND_MAGENTA="\033[45m"
export BACKGROUND_CYAN="\033[46m"
export BACKGROUND_LIGHT_GRAY="\033[47m"
export BACKGROUND_DARK_GRAY="\033[100m"
export BACKGROUND_LIGHT_RED="\033[101m"
export BACKGROUND_LIGHT_GREEN="\033[102m"
export BACKGROUND_LIGHT_YELLOW="\033[103m"
export BACKGROUND_LIGHT_BLUE="\033[104m"
export BACKGROUND_LIGHT_MAGENTA="\033[105m"
export BACKGROUND_LIGHT_CYAN="\033[106m"
export BACKGROUND_WHITE="\033[107m"

echo -e "${BOLD_RED}Hello ${BOLD_GREEN}World${RESET}!"

# serve static website, NOW!
python -m SimpleHTTPServer

# loop urls in file, and download each one with wget, setting the output filename to the basename of the url
cat s3.txt | while read -r url; do
  fn=${url%%\?*}
  fn=${fn##*/}
  [[ -f "$fn" ]] && continue
  wget -O "$fn" "$url"
done
