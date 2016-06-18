#!/bin/bash
# created by Andrew Reed 2016.
# exit if a command fails
set -e

#
# Required parameters
if [ -z "${plist_path}" ] ; then
  echo " [!] Missing required input: plist_path"
  exit 1
fi
if [ ! -f "${plist_path}" ] ; then
  echo " [!] File doesn't exist at specified Info.plist path: ${plist_path}"
  exit 1
fi

if [ -z "${plist_key}" ] ; then
  echo " [!] No key for plist specified!"
  exit 1
fi

if [ -z "${plist_value}" ] ; then
  echo " [!] No value for plist specified!"
  exit 1
fi

# ---------------------
# --- Configs:

CONFIG_project_info_plist_path="${plist_path}"
CONFIG_plist_key_string="${plist_key}"
CONFIG_plist_value_string="${plist_value}"

echo " (i) Provided Info.plist path: ${CONFIG_project_info_plist_path}"
echo " (i) Plist Key: ${CONFIG_plist_key_string}"
echo " (i) Plist value: ${CONFIG_plist_value_string}"

# ---------------------
# --- Main:

# verbose / debug print commands
set -v

# ---- Change Plist Value:
/usr/libexec/PlistBuddy -c "Set :${CONFIG_plist_key_string} ${CONFIG_plist_value_string}" "${CONFIG_project_info_plist_path}"
# ==> Plist value changed
