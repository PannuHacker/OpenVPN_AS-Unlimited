#!/bin/bash

# Expected MD5 checksum of original file
EXPECTED_MD5="9eae8ae4b246e101d0feb7cd6f49e2ee"
OUTPUT="openvpn-as-2.5-CentOS7.x86_64.rpm"

# File parts in correct order
PARTS=(
    "openvpn_file_part_01"
    "openvpn_file_part_02"
    "openvpn_file_part_03"
    "openvpn_file_part_04"
)

# Check for all parts
for f in "${PARTS[@]}"; do
    if [[ ! -f "$f" ]]; then
        echo "[-] Missing file: $f"
        exit 1
    fi
done

# Merge the files
echo "[+] All parts found. Merging into $OUTPUT..."
cat "${PARTS[@]}" > "$OUTPUT"

# Validate checksum
MERGED_MD5=$(md5sum "$OUTPUT" | awk '{print $1}')

if [[ "$MERGED_MD5" == "$EXPECTED_MD5" ]]; then
    echo "[+] Checksum matched. Merge successfully."
    exit 0
else
    echo "[-] Checksum mismatch! Expected: $EXPECTED_MD5, Got: $MERGED_MD5"
    exit 2
fi
