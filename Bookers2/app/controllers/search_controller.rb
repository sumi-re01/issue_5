class SearchController < ApplicationController

  def search
    @model = params["model"]
    @method = params["method"]
    @content = params["content"]

    @records = search_for(@model, @method, @content)

  end

  private

  def search_for(model, method, content)

    case model
    when 'user'

      if method == 'match'
        User.where(name: "#{content}")
      elsif method == 'forward'
        User.where('name LIKE ?', "#{content}%")
      elsif method == 'backward'
        User.where('name LIKE ?', "%#{content}")
      elsif method == 'partial'
        User.where('name LIKE ?', "%#{content}%")
      end

    when 'book'

      if method == 'match'
        Book.where(['title LIKE ? OR body LIKE ?', "#{content}", "#{content}"])
      elsif method == 'forward'
        Book.where(['title LIKE ? OR body LIKE ?', "#{content}%", "#{content}%"])
      elsif method == 'backward'
        Book.where(['title LIKE ? OR body LIKE ?', "%#{content}", "%#{content}"])
      elsif method == 'partial'
        Book.where(['title LIKE ? OR body LIKE ?', "%#{content}%", "%#{content}%"])
      end
    end
  end
end
