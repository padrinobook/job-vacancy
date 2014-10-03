module StringNormalizer
  def normalize_token(token)
    token.gsub("/", "").gsub("+", "")
  end
end
