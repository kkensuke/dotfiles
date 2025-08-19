zipen(){
    zip -er enc.zip "$@"
}

zipdec(){
    unzip -d dec enc.zip "$@"
}


# --- OpenSSL Encryption/Decryption Functions (macOS Version) ---
# Encrypts a file and removes the original on success
encrypt() {
  if [ -z "$1" ]; then echo "Usage: encrypt [filename]"; return 1; fi
  if [ ! -f "$1" ]; then echo "Error: File '$1' not found." >&2; return 1; fi
  
  if [ -f "$1.enc" ]; then
    printf "File '$1.enc' exists. Overwrite? (y/N): "
    read -r reply
    case "$reply" in
      [Yy]|[Yy][Ee][Ss]) ;;
      *) echo "Cancelled."; return 1 ;;
    esac
  fi
  
  # Attempt to encrypt the file
  if openssl enc -aes-256-cbc -salt -pbkdf2 -in "$1" -out "$1.enc"; then
    echo "✅ Encryption successful: '$1' -> '$1.enc'"
    # Delete the original file ONLY on success
    rm "$1"
  else
    echo "❌ Encryption failed."
    # Clean up failed encryption file if it exists
    rm -f "$1.enc"
    return 1
  fi
}

# Decrypts a file and removes the encrypted original on success
decrypt() {
  if [ -z "$1" ]; then echo "Usage: decrypt [filename.enc]"; return 1; fi
  if [ ! -f "$1" ]; then echo "Error: File '$1' not found." >&2; return 1; fi
  
  local output_file="${1%.enc}"
  
  # Check if output file would be overwritten
  if [ -f "$output_file" ]; then
    printf "File '$output_file' exists. Overwrite? (y/N): "
    read -r reply
    case "$reply" in
      [Yy]|[Yy][Ee][Ss]) ;;
      *) echo "Cancelled."; return 1 ;;
    esac
  fi
  
  # Attempt to decrypt the file
  if openssl enc -d -aes-256-cbc -pbkdf2 -in "$1" -out "$output_file"; then
    echo "✅ Decryption successful: '$1' -> '$output_file'"
    # Delete the encrypted source file ONLY on success
    rm "$1"
  else
    echo "❌ Decryption failed (wrong password?)."
    # Clean up the failed/partial output file if it exists
    rm -f "$output_file"
    return 1
  fi
}

# Test function to verify OpenSSL works
test_encryption() {
  echo "Testing encryption functionality..."
  echo "test content" > test_file.txt
  
  if encrypt test_file.txt && decrypt test_file.txt.enc; then
    echo "✅ Encryption test passed!"
    rm -f test_file.txt test_file.txt.enc
  else
    echo "❌ Encryption test failed!"
    rm -f test_file.txt test_file.txt.enc
    return 1
  fi
}