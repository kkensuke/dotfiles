zipen(){
    zip -er enc.zip "$@"
}

zipdec(){
    unzip -d dec enc.zip "$@"
}

# --- OpenSSL Encryption/Decryption Functions (Safe Version) ---

# Encrypts a file and removes the original on success
# Usage: encrypt [file_to_encrypt]
encrypt() {
  if [ -z "$1" ]; then echo "Usage: encrypt [filename]"; return 1; fi
  if [ ! -f "$1" ]; then echo "Error: File '$1' not found." >&2; return 1; fi
  
  if [ -f "$1.enc" ]; then
    read -p "File '$1.enc' exists. Overwrite? (y/N): " -n 1 -r
    echo
    [[ ! $REPLY =~ ^[Yy]$ ]] && return 1
  fi
  
  # Attempt to encrypt the file
  if openssl enc -aes-256-cbc -salt -pbkdf2 -in "$1" -out "$1.enc"; then
    echo "✅ Encryption successful: '$1' -> '$1.enc'"
    # Delete the original file ONLY on success
    rm "$1"
  else
    echo "❌ Encryption failed."
    return 1
  fi
}

# Decrypts a file and removes the encrypted original on success
# Usage: decrypt [file_to_decrypt.enc]
decrypt() {
  if [ -z "$1" ]; then echo "Usage: decrypt [filename.enc]"; return 1; fi
  if [ ! -f "$1" ]; then echo "Error: File '$1' not found." >&2; return 1; fi
  
  local output_file="${1%.enc}"
  
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