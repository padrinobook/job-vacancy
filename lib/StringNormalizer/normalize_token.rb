module StringNormalizer
  def normalize_token(token)
    token.gsub("/", "")
  end
end
