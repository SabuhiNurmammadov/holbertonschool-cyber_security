#!/bin/bash

# Function to decode WebSphere XOR passwords
decode_websphere_xor() {
    local encoded_str=$1

    # Remove the "{xor}" prefix
    local base64_str=$(echo "$encoded_str" | sed 's/^{xor}//i')

    # Base64 decode the string
    local decoded_base64=$(echo "$base64_str" | base64 --decode 2>/dev/null)

    if [ $? -ne 0 ] || [ -z "$decoded_base64" ]; then
        echo "Error: Invalid Base64 string or decoding failed." >&2
        return 1
    fi

    local decoded_pwd=""
    local key='_'

    # Iterate over each character in the Base64 decoded string
    for (( i=0; i<${#decoded_base64}; i++ )); do
        # Get the ASCII value of the character
        char_val=$(printf '%d' "'${decoded_base64:$i:1}")
        # Get the ASCII value of the key character
        key_val=$(printf '%d' "'$key")

        # Perform the XOR operation
        xor_val=$(( char_val ^ key_val ))

        # Convert the resulting ASCII value back to a character and append
        decoded_pwd+=$(printf \\$(printf '%o' "$xor_val"))
    done

    echo "Decoded Password: $decoded_pwd"
}

# --- Usage Example ---
# Check if an argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 {xor}ENCODED_PASSWORD"
    exit 1
fi

decode_websphere_xor "$1"
