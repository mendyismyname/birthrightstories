module EmojiSanitizer
  module_function

  def parse(text)

    # Match Emoticons
    regex_emoticons = '/[\x{1F600}-\x{1F64F}]/u';

    # Match Miscellaneous Symbols and Pictographs
    regex_symbols = '/[\x{1F300}-\x{1F5FF}]/u';

    # Match Transport And Map Symbols
    regex_transport = '/[\x{1F680}-\x{1F6FF}]/u';

    # Match Miscellaneous Symbols
    regex_misc = '/[\x{2600}-\x{26FF}]/u';

    # Match Dingbats
    regex_dingbats = '/[\x{2700}-\x{27BF}]/u';

    return text.gsub(regex_emoticons, '')
               .gsub(regex_symbols, '')
               .gsub(regex_transport, '')
               .gsub(regex_misc, '')
               .gsub(regex_dingbats, '');
  end
end