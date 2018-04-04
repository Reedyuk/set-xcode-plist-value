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

if [ -z "${plist_add_missing_keys}" ] ; then
  echo " [!] Missing required input: plist_add_missing_keys (true or false)!"
  exit 1
fi

# ---------------------
# --- Configs:

CONFIG_project_info_plist_path="${plist_path}"
CONFIG_plist_key_string="${plist_key}"
CONFIG_plist_value_string="${plist_value}"
CONFIG_plist_add_missing_keys="${plist_add_missing_keys}"

echo " (i) Provided Info.plist path: ${CONFIG_project_info_plist_path}"
echo " (i) Plist Key: ${CONFIG_plist_key_string}"
echo " (i) Plist value: ${CONFIG_plist_value_string}"
echo " (i) Add missing keys: ${CONFIG_plist_add_missing_keys}"

# ---------------------
# --- Main:

# verbose / debug print commands
set -v

# ---- Change Plist Value:
if [[ "${CONFIG_plist_add_missing_keys}" == "true" ]] ; then
  /usr/libexec/PlistBuddy -c "Add :${CONFIG_plist_key_string} string ${CONFIG_plist_value_string}" "${CONFIG_project_info_plist_path}"
else
  /usr/libexec/PlistBuddy -c "Set :${CONFIG_plist_key_string} ${CONFIG_plist_value_string}" "${CONFIG_project_info_plist_path}"
fi
# ==> Plist value changed
