module JobVacancy
  module String
    module Normalizer
      def normalize(token)
        token.delete('/').delete('+')
      end
    end
  end
end

