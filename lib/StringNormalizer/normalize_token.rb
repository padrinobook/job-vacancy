module StringNormalizer
  def normalize(token)
    token.delete('/').delete('+')
  end
end

