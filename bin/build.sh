#!/usr/bin/env bash

headless=false

while getopts :h flag; do
  case $flag in
    h)
      # Headless
      headless=true
      echo "Executing in headless mode"
      ;;
    ?)
      exit;
      ;;
  esac
done

shift $(( OPTIND - 1 ));

build_dir="build"
mkdir -p ${build_dir}

engine=`node -e "var p = require('./package.json'); process.stdout.write((p.engines) ? p.engines.node : '')"`
user_node=`node -v`

if [[ "$user_node" != *"$engine"* ]]; then
  echo "package.json specifies version v${engine} and you are currently using ${user_node}. Please make sure to use the correct version when installing modules to prevent issues in deployment"
  if [[ $headless == false ]]; then
    read -p "Are you sure? (y/n)" -n 1 -r
    echo    # (optional) move to a new line
    if ! [[ $REPLY =~ ^[Yy]$ ]]; then
      exit
    fi
  else
    echo "WARNING: Node version specified in package.json v${engine} does not match your version ${user_node}"
  fi
fi

git rev-list HEAD -1 > build.sha

dist_name=`node -e "var p = require('./package.json'); process.stdout.write(p.name)"`

npm run build

# npm prune --production
zip -FSr "${build_dir}"/"${dist_name}" . -x "build/*" -x "tests/*" -x "*.git*" -x "yarn.lock" -x ".env"
rm build.sha
