module ApplicationHelper
   def form_group_tag(errors, &block)
     if errors.any?
       content_tag :div, capture(&block), class: 'form-group has-error'
     else
       content_tag :div, capture(&block), class: 'form-group'
     end
   end

  def markdown(text)
    renderer = Redcarpet::Render::HTML.new
    extensions = {fenced_code_blocks: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    (redcarpet.render text).html_safe
  end

  def vote_link_classes(post, direction)
    chevron_up = "glyphicon glyphicon-chevron-up "
    chevron_down = "glyphicon glyphicon-chevron-down "
    vote = current_user.voted(post)

    if direction == 'up'
      if vote && vote.up_vote?
        chevron_up+"voted"
      else
        chevron_up
      end
    else
      if vote && vote.down_vote?
        chevron_down+"voted"
      else
        chevron_down
      end
    end

  end

 end