class PagesController < ApplicationController
  # "< ApplicationController" - указвыает на наследование от класса ApplicationController
  # Навание класса должно быть именно таким, т.е. содержать 'Pages' + 'Controller'

  def index
    # Наименование метода, который указали в config -> routes.rb
    # Разметка, которая отвечает за отображение данного метода располагается в views -> pages -> index.html.erb

    # Объявим переменную класса, которая так же доступна для отображения на странице "index"
    # Данная переменная принимает параметр в запросе поисковой строки: .../?name=yeskela
    # @name = params[:name]
    # UPD: убрали, потому что мешается
  end
end