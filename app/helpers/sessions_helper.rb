module JobVacancy
  class App
    module SessionsHelper
      def current_user=(user)
        @current_user = user
      end

      def current_user
        @current_user ||= User.find_by_id(session[:current_user])
      end

      def current_user?(user)
        user == current_user
      end

      def sign_in(user)
        session[:current_user] = user.id
        self.current_user = user
      end

      def sign_out
        session.delete(:current_user)
      end

      def signed_in?
        !current_user.nil?
      end

      def markdown(text)
        options = {
          filter_html:     true,
          hard_wrap:       true,
          link_attributes: { rel: 'nofollow', target: "_blank" },
          space_after_headers: true,
          fenced_code_blocks: true
        }

        extensions = {
          autolink:           true,
          superscript:        true,
          disable_indented_code_blocks: true
        }

        renderer = Redcarpet::Render::HTML.new(options)
        markdown = Redcarpet::Markdown.new(renderer, extensions)

        markdown.render(text).html_safe
      end

    end

    helpers SessionsHelper
  end
end

