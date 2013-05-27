module ApplicationHelper
	def markdown(text)
		concat GitHub::Markdown.render(text).html_safe
	end
end
