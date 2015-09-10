module StringNormalizer
  def normalize(token)
    token.gsub("/", "").gsub("+", "")
  end
end
