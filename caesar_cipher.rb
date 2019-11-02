# Caesar Cipher

# Caesar Cipher encrypts a MESSAGE by shifting a letter up or down the 
# alphabet by a KEY amount. If the KEY were 3 and the MESSAGE, “Hello!”.
# The Caesar Cipher will shift each letter up the alphabet 3 spaces, 
# leaving punctuation and spaces untouched but keeping capital letters 
# capitalized. If a letter is shifted past the end of the alphabet it will
# loop back around, “Z” with a KEY of 1 becomes “A” and “a” with a KEY of
# -1 becomes “z”. caesar_cipher will accept any positive or negative KEY.

require 'sinatra'
require 'sinatra/reloader'

ASCII_UPPER = (65..90).to_a 
ASCII_LOWER = (97..122).to_a
ALPHABET_LENGTH = ASCII_UPPER.length # 26 letters in the english alphabet

def caesar_cipher(message,key)

  key %= ALPHABET_LENGTH # reduces key if larger than ALPHABET_LENGTH

  cipher = message.codepoints.map do|ascii| # change string to ascii array
    if ASCII_UPPER.include?(ascii)
      # loops around ends (A to Z) and (Z to A) of alphabet if needed
      ascii -= ALPHABET_LENGTH if ascii + key > ASCII_UPPER.last 
      ascii += ALPHABET_LENGTH if ascii + key < ASCII_UPPER.first
      ascii += key
    elsif ASCII_LOWER.include?(ascii)
      # loops around end (a to z) and (z to a) of alphabet if needed
      ascii -= ALPHABET_LENGTH if ascii + key > ASCII_LOWER.last
      ascii += ALPHABET_LENGTH if ascii + key < ASCII_LOWER.first
      ascii += key 
    else
      ascii = ascii
    end
  end
  cipher.pack'U*' #converts ascii array to character string
end

get '/' do
  message = params["message"]
  key = params["key"].to_i
  cipher = caesar_cipher(message, key) if message
  erb :index, locals: {cipher: cipher}
end